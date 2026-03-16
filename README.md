# GameOn-Project-CSCI411

SQL schema files for the GameOn project, plus a small Python terminal app for connecting to the MySQL database hosted on Aiven.

## Python CLI

The terminal client lives in `gameon_cli.py` and can:

- test the database connection
- list tables and views in the current schema

## Setup

1. Create a virtual environment:

	```powershell
	python -m venv .venv
	```

2. Activate it in PowerShell:

	```powershell
	.\.venv\Scripts\Activate.ps1
	```

3. Install dependencies:

	```powershell
	pip install -r requirements.txt
	```

4. Copy `.env.example` to `.env` and fill in your Aiven MySQL values.

5. Download the Aiven CA certificate and either save it as `ca.pem` in the repo root or update `MYSQL_SSL_CA` to point to the certificate path.

6. Run the app:

	```powershell
	python gameon_cli.py
	```

## Environment Variables

- `MYSQL_HOST`
- `MYSQL_PORT`
- `MYSQL_DATABASE`
- `MYSQL_USER`
- `MYSQL_PASSWORD`
- `MYSQL_SSL_MODE`
- `MYSQL_SSL_CA`
- `MYSQL_SSL_VERIFY_CERT`
- `MYSQL_SSL_VERIFY_IDENTITY`