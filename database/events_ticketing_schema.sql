

-- Drop tables in proper order due to foreign key dependencies
DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS venues;
DROP TABLE IF EXISTS users;

-- Create users table
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    is_event_holder BOOLEAN NOT NULL DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create venues table
CREATE TABLE venues (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    max_capacity INTEGER NOT NULL,
    location TEXT NOT NULL,
    event_holder_id INTEGER NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (event_holder_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create events table
CREATE TABLE events (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT,
    date DATE NOT NULL,
    venue_id INTEGER NOT NULL,
    FOREIGN KEY (venue_id) REFERENCES venues(id)
);

-- Create tickets table (uses event_id instead of venue_id)
CREATE TABLE tickets (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    section TEXT NOT NULL,
    number INTEGER NOT NULL,
    price REAL NOT NULL,
    taken BOOLEAN NOT NULL DEFAULT 0,
    event_id INTEGER NOT NULL,
    FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE
);

-- Optional indexes
CREATE INDEX idx_tickets_event_id ON tickets(event_id);
CREATE INDEX idx_venues_event_holder_id ON venues(event_holder_id);

-- Insert users
INSERT INTO users (email, password, is_event_holder) VALUES
('alice@example.com', 'password123', 1),
('bob@example.com', 'securepass', 1),
('charlie@example.com', '12345abc', 1),
('diana@example.com', 'mypassword', 1),
('edward@example.com', 'pass1234', 1),
('fiona@example.com', 'helloWorld', 1),
('george@example.com', 'qwerty123', 1),
('hannah@example.com', 'admin123', 1),
('ivan@example.com', 'letmein', 1),
('julia@example.com', 'password1', 1);

-- Insert venues
INSERT INTO venues (name, max_capacity, location, event_holder_id) VALUES
('Liberty Dome', 5000, 'New York, NY', 1),
('Sunset Arena', 8000, 'Los Angeles, CA', 2),
('Windy City Pavilion', 6000, 'Chicago, IL', 3),
('Bayou Stadium', 7500, 'Houston, TX', 4),
('Desert Lights Arena', 7200, 'Phoenix, AZ', 5),
('Liberty Hall', 6800, 'Philadelphia, PA', 6),
('Riverwalk Center', 7000, 'San Antonio, TX', 7),
('Pacific Breeze Arena', 7100, 'San Diego, CA', 8),
('Metroplex Stadium', 6900, 'Dallas, TX', 9),
('Silicon Center', 7300, 'San Jose, CA', 10);

-- Insert events
INSERT INTO events (name, description, date, venue_id) VALUES
('Summer Bash', 'Annual summer concert series', '2025-06-15', 1),
('Rockfest', 'Local rock bands showdown', '2025-07-04', 2),
('Jazz Nights', 'Smooth jazz experience', '2025-07-10', 3),
('Tech Expo', 'Latest in tech and gadgets', '2025-08-01', 4),
('Desert Rave', 'Electronic music festival', '2025-08-12', 5),
('IndieFest', 'Independent artists live', '2025-09-05', 6),
('Country Jam', 'Country music live show', '2025-09-15', 7),
('Beach Beats', 'Sun, sand, and sound', '2025-10-01', 8),
('Metro Gala', 'Formal music and dinner', '2025-10-20', 9),
('Startup Summit', 'Entrepreneur networking', '2025-11-01', 10);

-- Insert tickets
-- Event 1
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 1, 51.00, 0, 1);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 2, 51.00, 0, 1);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 3, 51.00, 0, 1);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('B', 4, 61.00, 0, 1);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('B', 5, 61.00, 0, 1);

-- Event 2
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 1, 51.00, 0, 2);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 2, 51.00, 0, 2);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 3, 51.00, 0, 2);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('B', 4, 61.00, 0, 2);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('B', 5, 61.00, 0, 2);

-- Event 3
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 1, 51.00, 0, 3);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 2, 51.00, 0, 3);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 3, 51.00, 0, 3);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('B', 4, 61.00, 0, 3);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('B', 5, 61.00, 0, 3);

-- Event 4
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 1, 51.00, 0, 4);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 2, 51.00, 0, 4);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 3, 51.00, 0, 4);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('B', 4, 61.00, 0, 4);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('B', 5, 61.00, 0, 4);

-- Event 5
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 1, 51.00, 0, 5);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 2, 51.00, 0, 5);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 3, 51.00, 0, 5);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('B', 4, 61.00, 0, 5);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('B', 5, 61.00, 0, 5);

-- Event 6
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 1, 51.00, 0, 6);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 2, 51.00, 0, 6);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 3, 51.00, 0, 6);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('B', 4, 61.00, 0, 6);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('B', 5, 61.00, 0, 6);

-- Event 7
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 1, 51.00, 0, 7);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 2, 51.00, 0, 7);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 3, 51.00, 0, 7);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('B', 4, 61.00, 0, 7);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('B', 5, 61.00, 0, 7);

-- Event 8
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 1, 51.00, 0, 8);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 2, 51.00, 0, 8);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 3, 51.00, 0, 8);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('B', 4, 61.00, 0, 8);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('B', 5, 61.00, 0, 8);

-- Event 9
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 1, 51.00, 0, 9);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 2, 51.00, 0, 9);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 3, 51.00, 0, 9);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('B', 4, 61.00, 0, 9);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('B', 5, 61.00, 0, 9);

-- Event 10
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 1, 51.00, 0, 10);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 2, 51.00, 0, 10);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('A', 3, 51.00, 0, 10);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('B', 4, 61.00, 0, 10);
INSERT INTO tickets (section, number, price, taken, event_id) VALUES ('B', 5, 61.00, 0, 10);


