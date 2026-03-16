from __future__ import annotations

import os
from getpass import getpass
from pathlib import Path
from typing import Any

import mysql.connector
from dotenv import load_dotenv
from mysql.connector import Error

MAX_CELL_WIDTH = 40


def load_environment() -> None:
    env_path = Path(__file__).with_name(".env")
    if env_path.exists():
        load_dotenv(env_path)


def env_bool(name: str, default: bool) -> bool:
    raw_value = os.getenv(name)
    if raw_value is None:
        return default
    return raw_value.strip().lower() in {"1", "true", "yes", "on"}


def build_connection_config() -> dict[str, Any]:
    required = ["MYSQL_HOST", "MYSQL_PORT", "MYSQL_DATABASE", "MYSQL_USER"]
    missing = [name for name in required if not os.getenv(name)]
    if missing:
        missing_list = ", ".join(missing)
        raise RuntimeError(
            f"Missing required environment variables: {missing_list}. "
            "Copy .env.example to .env and fill in your Aiven values."
        )

    password = os.getenv("MYSQL_PASSWORD")
    if not password:
        password = getpass("MySQL password: ")

    config: dict[str, Any] = {
        "host": os.getenv("MYSQL_HOST"),
        "port": int(os.getenv("MYSQL_PORT", "3306")),
        "database": os.getenv("MYSQL_DATABASE"),
        "user": os.getenv("MYSQL_USER"),
        "password": password,
        "autocommit": False,
    }

    ssl_mode = os.getenv("MYSQL_SSL_MODE", "REQUIRED").upper()
    if ssl_mode == "DISABLED":
        config["ssl_disabled"] = True
    else:
        config["ssl_disabled"] = False
        ssl_ca = os.getenv("MYSQL_SSL_CA")
        if ssl_ca:
            config["ssl_ca"] = str(Path(ssl_ca).expanduser())
            config["ssl_verify_cert"] = env_bool("MYSQL_SSL_VERIFY_CERT", True)
            config["ssl_verify_identity"] = env_bool("MYSQL_SSL_VERIFY_IDENTITY", True)

    return config


def format_cell(value: Any) -> str:
    if value is None:
        text = "NULL"
    else:
        text = str(value)
    text = text.replace("\n", " ").replace("\r", " ")
    if len(text) > MAX_CELL_WIDTH:
        return text[: MAX_CELL_WIDTH - 3] + "..."
    return text


def print_rows(rows: list[dict[str, Any]]) -> None:
    if not rows:
        print("No rows returned.")
        return

    columns = list(rows[0].keys())
    widths = {
        column: max(len(column), *(len(format_cell(row.get(column))) for row in rows))
        for column in columns
    }

    header = " | ".join(column.ljust(widths[column]) for column in columns)
    separator = "-+-".join("-" * widths[column] for column in columns)

    print(header)
    print(separator)
    for row in rows:
        line = " | ".join(format_cell(row.get(column)).ljust(widths[column]) for column in columns)
        print(line)


def prompt_choice() -> str:
    print()
    print("\nGameOn DB CLI")
    print("1. Test connection")
    print("2. List tables and views")
    print("Q. Quit")
    return input("Choose an option: ").strip().lower()


def list_objects(connection: mysql.connector.MySQLConnection) -> list[dict[str, Any]]:
    query = """
        SELECT table_name, table_type
        FROM information_schema.tables
        WHERE table_schema = DATABASE()
        ORDER BY table_type, table_name
    """
    with connection.cursor(dictionary=True) as cursor:
        cursor.execute(query)
        rows = cursor.fetchall()
    print("\n")
    print_rows(rows)
    return rows


def test_connection(connection: mysql.connector.MySQLConnection) -> None:
    connection.ping(reconnect=True, attempts=1, delay=0)
    print(f"\nConnected to {connection.database} on {connection.server_host}:{connection.server_port}")


def main() -> int:
    load_environment()

    try:
        connection = mysql.connector.connect(**build_connection_config())
    except Error as exc:
        print(f"Connection failed: {exc}")
        return 1
    except RuntimeError as exc:
        print(exc)
        return 1

    try:
        test_connection(connection)
        while True:
            choice = prompt_choice()
            try:
                if choice == "1":
                    test_connection(connection)
                elif choice == "2":
                    list_objects(connection)
                elif choice in {"q", "quit", "exit"}:
                    print("Goodbye.")
                    return 0
                else:
                    print("Choose 1-2 or Q.")
            except (Error, ValueError) as exc:
                print(f"Error: {exc}")
    finally:
        connection.close()


if __name__ == "__main__":
    raise SystemExit(main())
