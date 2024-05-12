QUERY

-- Globals

-- No equivalent global settings are needed in PostgreSQL.

-- Table 'institution'
DROP TABLE IF EXISTS institution;
CREATE TABLE institution (
  id SERIAL PRIMARY KEY,
  description VARCHAR(220),
  work_hours INTEGER NOT NULL DEFAULT 0,
  rating INTEGER NOT NULL DEFAULT 0,
  id_posts INTEGER,
  id_actions INTEGER,
  id_permission INTEGER NOT NULL DEFAULT 1,
  password VARCHAR NOT NULL,
  email VARCHAR NOT NULL,
  cnpj INTEGER NOT NULL DEFAULT 0,
  id_pfp VARCHAR,
  fantasy_name VARCHAR NOT NULL,
  id_type BYTEA NOT NULL,
  registered_when TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Table 'post'
DROP TABLE IF EXISTS post;
CREATE TABLE post (
  id SERIAL PRIMARY KEY,
  timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  description VARCHAR(220),
  fantasy_name VARCHAR NOT NULL,
  id_pfp VARCHAR
);

-- Table 'comments'
DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
  content VARCHAR,
  id_pfp VARCHAR,
  timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fantasy_name INTEGER,
  id SERIAL PRIMARY KEY
);

-- Table 'actions'
DROP TABLE IF EXISTS actions;
CREATE TABLE actions (
  id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL,
  description VARCHAR(220) NOT NULL,
  work_hours INTEGER NOT NULL DEFAULT 0,
  id_pfp VARCHAR
);

-- Table 'users'
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  password VARCHAR NOT NULL,
  email VARCHAR NOT NULL,
  cpf INTEGER NOT NULL DEFAULT 0,
  id_pfp VARCHAR,
  id_permission INTEGER NOT NULL DEFAULT 2,
  id_actions INTEGER,
  work_hours INTEGER NOT NULL DEFAULT 0,
  description VARCHAR(220) NOT NULL,
  id_posts INTEGER DEFAULT 0,
  registered_when TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  tags VARCHAR NOT NULL,
  name VARCHAR(14) NOT NULL
);

-- Table 'type'
DROP TABLE IF EXISTS type;
CREATE TABLE type (
  id BYTEA NOT NULL PRIMARY KEY
);

-- Table 'user_volunteer'
DROP TABLE IF EXISTS user_volunteer;
CREATE TABLE user_volunteer (
  id SERIAL PRIMARY KEY,
  id_users INTEGER NOT NULL,
  id_actions INTEGER NOT NULL
);

-- Table 'pfp'
DROP TABLE IF EXISTS pfp;
CREATE TABLE pfp (
  id VARCHAR PRIMARY KEY
);

-- Table 'comments_post'
DROP TABLE IF EXISTS comments_post;
CREATE TABLE comments_post (
  id SERIAL PRIMARY KEY,
  id_comments INTEGER NOT NULL,
  id_post INTEGER NOT NULL
);

-- Table 'Permissions'
DROP TABLE IF EXISTS Permissions;
CREATE TABLE Permissions (
  id INTEGER NOT NULL PRIMARY KEY
);

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE institution ADD FOREIGN KEY (id_posts) REFERENCES post (id);
ALTER TABLE institution ADD FOREIGN KEY (id_actions) REFERENCES actions (id);
ALTER TABLE institution ADD FOREIGN KEY (id_permission) REFERENCES Permissions (id);
ALTER TABLE institution ADD FOREIGN KEY (id_pfp) REFERENCES pfp (id);
ALTER TABLE actions ADD FOREIGN KEY (id_pfp) REFERENCES pfp (id);
ALTER TABLE users ADD FOREIGN KEY (id_pfp) REFERENCES pfp (id);
ALTER TABLE users ADD FOREIGN KEY (id_permission) REFERENCES Permissions (id);
ALTER TABLE users ADD FOREIGN KEY (id_posts) REFERENCES post (id);
ALTER TABLE user_volunteer ADD FOREIGN KEY (id_users) REFERENCES users (id);
ALTER TABLE user_volunteer ADD FOREIGN KEY (id_actions) REFERENCES actions (id);
ALTER TABLE comments_post ADD FOREIGN KEY (id_comments) REFERENCES comments (id);
ALTER TABLE comments_post ADD FOREIGN KEY (id_post) REFERENCES post (id);