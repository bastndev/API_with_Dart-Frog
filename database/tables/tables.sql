DROP DATABASE IF EXISTS protective;
CREATE DATABASE protective ;
use protective

CREATE TABLE users (
    id VARCHAR(255) PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE pets (
    id VARCHAR(255) PRIMARY KEY,
    adopted_by VARCHAR(255),
    name VARCHAR(50) NOT NULL,
    age int,
    base64image longtext,
    type VARCHAR(50) NOT NULL,
    FOREIGN KEY (adopted_by) REFERENCES users(id)
);

CREATE TABLE access_tokens (
    id VARCHAR(255) PRIMARY KEY,
    user_id VARCHAR(255),
    token VARCHAR(500) NOT NULL,
    expiration_date TIMESTAMP DEFAULT (NOW() + INTERVAL 12 HOUR),
    FOREIGN KEY (user_id) REFERENCES users(id)
);