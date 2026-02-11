-- Database Initialization Script
-- Generated: 2026-02-12

-- 1. Create Tables
CREATE TABLE IF NOT EXISTS users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS projects (
    project_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    owner_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    status VARCHAR(20) DEFAULT 'active'
);

-- 2. Insert Sample Data
INSERT INTO users (username, email) VALUES 
('dev_guru', 'guru@example.com'),
('data_wiz', 'wiz@example.com');

INSERT INTO projects (title, description, owner_id) VALUES 
('Project Alpha', 'A high-priority internal tool.', 1),
('Beta Launch', 'Public-facing API documentation.', 2);

-- 3. Simple Verification Query
SELECT u.username, p.title, p.status 
FROM users u 
JOIN projects p ON u.user_id = p.owner_id;
