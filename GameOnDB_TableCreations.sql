-- ============================================================
-- GameOn App Database Schema
-- CSCI411 Database Theory and Design
-- Authors: Abel Asfaw & Carson Kariniemi
-- ============================================================

CREATE DATABASE gameon_db;
USE gameon_db;

-- ============================================================
-- CORE ENTITIES
-- ============================================================

CREATE TABLE users (
    user_id         INT AUTO_INCREMENT PRIMARY KEY,
    first_name      VARCHAR(50)  NOT NULL,
    last_name       VARCHAR(50)  NOT NULL,
    email           VARCHAR(100) NOT NULL UNIQUE,
    password_hash   VARCHAR(255) NOT NULL,
    role            ENUM('player', 'agent', 'scout', 'organizer', 'admin') NOT NULL DEFAULT 'player',
    phone           VARCHAR(20),
    profile_pic_url VARCHAR(255),
    bio             TEXT,
    skill_level     INT CHECK (skill_level BETWEEN 1 AND 10),
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE sports (
    sport_id             INT AUTO_INCREMENT PRIMARY KEY,
    sport_name           VARCHAR(50) NOT NULL UNIQUE,
    description          VARCHAR(255),
    max_players_per_team INT
) ENGINE=InnoDB;

CREATE TABLE positions (
    position_id   INT AUTO_INCREMENT PRIMARY KEY,
    sport_id      INT NOT NULL,
    position_name VARCHAR(50) NOT NULL,
    abbreviation  VARCHAR(10),
    UNIQUE (sport_id, position_name),
    FOREIGN KEY (sport_id) REFERENCES sports(sport_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE locations (
    location_id   INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    address       VARCHAR(255) NOT NULL,
    latitude      DECIMAL(10, 7) NOT NULL,
    longitude     DECIMAL(10, 7) NOT NULL,
    facility_type ENUM('court', 'field', 'park', 'gym', 'rec_center', 'other'),
    is_indoor     TINYINT(1) DEFAULT 0,
    capacity      INT
) ENGINE=InnoDB;

CREATE TABLE games (
    game_id         INT AUTO_INCREMENT PRIMARY KEY,
    sport_id        INT NOT NULL,
    location_id     INT NOT NULL,
    created_by      INT NOT NULL,
    status          ENUM('open', 'full', 'in_progress', 'completed', 'cancelled') NOT NULL DEFAULT 'open',
    scheduled_time  TIMESTAMP NOT NULL,
    max_players     INT NOT NULL,
    current_players INT NOT NULL DEFAULT 0,
    skill_level_req ENUM('beginner', 'intermediate', 'advanced', 'any'),
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sport_id)    REFERENCES sports(sport_id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES locations(location_id) ON DELETE CASCADE,
    FOREIGN KEY (created_by)  REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE teams (
    team_id   INT AUTO_INCREMENT PRIMARY KEY,
    game_id   INT NOT NULL,
    team_name VARCHAR(50) NOT NULL,
    score     INT DEFAULT 0,
    FOREIGN KEY (game_id) REFERENCES games(game_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
-- JUNCTION / BRIDGE TABLES
-- ============================================================

CREATE TABLE game_players (
    game_player_id INT AUTO_INCREMENT PRIMARY KEY,
    game_id        INT NOT NULL,
    user_id        INT NOT NULL,
    team_id        INT,
    position_id    INT,	
    status         ENUM('joined', 'confirmed', 'left', 'removed') NOT NULL DEFAULT 'joined',
    joined_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (game_id, user_id),
    FOREIGN KEY (game_id)     REFERENCES games(game_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id)     REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (team_id)     REFERENCES teams(team_id) ON DELETE SET NULL,
    FOREIGN KEY (position_id) REFERENCES positions(position_id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE game_stats (
    stat_id        INT AUTO_INCREMENT PRIMARY KEY,
    game_player_id INT NOT NULL,
    stat_type      VARCHAR(30) NOT NULL,
    stat_value     INT NOT NULL DEFAULT 0,
    FOREIGN KEY (game_player_id) REFERENCES game_players(game_player_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE game_results (
    result_id       INT AUTO_INCREMENT PRIMARY KEY,
    game_id         INT NOT NULL UNIQUE,
    winning_team_id INT,
    completed_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    notes           TEXT,
    FOREIGN KEY (game_id)         REFERENCES games(game_id) ON DELETE CASCADE,
    FOREIGN KEY (winning_team_id) REFERENCES teams(team_id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE user_sports (
    user_sport_id    INT AUTO_INCREMENT PRIMARY KEY,
    user_id          INT NOT NULL,
    sport_id         INT NOT NULL,
    years_experience INT DEFAULT 0,
    UNIQUE (user_id, sport_id),
    FOREIGN KEY (user_id)  REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (sport_id) REFERENCES sports(sport_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE user_positions (
    user_position_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id          INT NOT NULL,
    position_id      INT NOT NULL,
    is_primary       TINYINT(1) DEFAULT 0,
    UNIQUE (user_id, position_id),
    FOREIGN KEY (user_id)      REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (position_id)  REFERENCES positions(position_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
-- RECRUITMENT ENTITIES
-- ============================================================

CREATE TABLE clubs (
    club_id      INT AUTO_INCREMENT PRIMARY KEY,
    club_name    VARCHAR(100) NOT NULL,
    sport_id     INT NOT NULL,
    city         VARCHAR(50),
    state        VARCHAR(50),
    description  TEXT,
    founded_year INT,
    FOREIGN KEY (sport_id) REFERENCES sports(sport_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE agents (
    agent_id       INT AUTO_INCREMENT PRIMARY KEY,
    user_id        INT NOT NULL UNIQUE,
    agency_name    VARCHAR(100),
    license_number VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE sponsors (
    sponsor_id    INT AUTO_INCREMENT PRIMARY KEY,
    sponsor_name  VARCHAR(100) NOT NULL,
    industry      VARCHAR(50),
    contact_email VARCHAR(100),
    website       VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE club_members (
    club_member_id INT AUTO_INCREMENT PRIMARY KEY,
    club_id        INT NOT NULL,
    user_id        INT NOT NULL,
    member_role    ENUM('member', 'captain', 'coach', 'manager') DEFAULT 'member',
    joined_date    DATE NOT NULL DEFAULT (CURRENT_DATE),
    UNIQUE (club_id, user_id),
    FOREIGN KEY (club_id) REFERENCES clubs(club_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE club_sponsors (
    club_sponsor_id INT AUTO_INCREMENT PRIMARY KEY,
    club_id         INT NOT NULL,
    sponsor_id      INT NOT NULL,
    amount          DECIMAL(10, 2),
    start_date      DATE,
    end_date        DATE,
    UNIQUE (club_id, sponsor_id),
    FOREIGN KEY (club_id)    REFERENCES clubs(club_id) ON DELETE CASCADE,
    FOREIGN KEY (sponsor_id) REFERENCES sponsors(sponsor_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE club_agents (
    club_agent_id  INT AUTO_INCREMENT PRIMARY KEY,
    club_id        INT NOT NULL,
    agent_id       INT NOT NULL,
    contract_start DATE,
    contract_end   DATE,
    UNIQUE (club_id, agent_id),
    FOREIGN KEY (club_id)  REFERENCES clubs(club_id) ON DELETE CASCADE,
    FOREIGN KEY (agent_id) REFERENCES agents(agent_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE user_agents (
    user_agent_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id       INT NOT NULL,
    agent_id      INT NOT NULL,
    start_date    DATE,
    end_date      DATE,
    UNIQUE (user_id, agent_id),
    FOREIGN KEY (user_id)  REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (agent_id) REFERENCES agents(agent_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE user_sponsors (
    user_sponsor_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id         INT NOT NULL,
    sponsor_id      INT NOT NULL,
    amount          DECIMAL(10, 2),
    start_date      DATE,
    end_date        DATE,
    UNIQUE (user_id, sponsor_id),
    FOREIGN KEY (user_id)    REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (sponsor_id) REFERENCES sponsors(sponsor_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
-- SOCIAL / COMMUNICATION ENTITIES
-- ============================================================

CREATE TABLE messages (
    message_id  INT AUTO_INCREMENT PRIMARY KEY,
    sender_id   INT NOT NULL,
    receiver_id INT NOT NULL,
    game_id     INT,
    content     TEXT NOT NULL,
    sent_at     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_read     TINYINT(1) DEFAULT 0,
    FOREIGN KEY (sender_id)   REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (game_id)     REFERENCES games(game_id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id         INT NOT NULL,
    type            ENUM('game_invite', 'game_update', 'new_game', 'message', 'follow', 'general') NOT NULL,
    reference_type  VARCHAR(30),
    reference_id    INT,
    message         TEXT NOT NULL,
    is_read         TINYINT(1) DEFAULT 0,
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE followers (
    follow_id    INT AUTO_INCREMENT PRIMARY KEY,
    follower_id  INT NOT NULL,
    following_id INT NOT NULL,
    created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (follower_id, following_id),
    CHECK (follower_id != following_id),
    FOREIGN KEY (follower_id)  REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (following_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

