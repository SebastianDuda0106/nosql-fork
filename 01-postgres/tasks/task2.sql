--0.
drop table if EXISTS bookings;
drop table if EXISTS users;
drop table if EXISTS rooms;

--1.
CREATE TABLE rooms(
    id SERIAL PRIMARY KEY,
    room_name char(50) NOT NULL UNIQUE,
    capacity int check (capacity>0),
    has_projector BOOLEAN DEFAULT true
);

--2.
CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    full_name varchar(100) not null,
    email VARCHAR(100) UNIQUE not null
);

--3.
CREATE TABLE bookings(
    id SERIAL PRIMARY KEY,
    room_id int REFERENCES rooms(id) on delete CASCADE,
    user_id int REFERENCES users(id) on delete CASCADE,
    booking_date DATE not null,
    duration_hours int check(duration_hours between 1 and 8)
);

--4.
-- Insert Rooms
INSERT INTO rooms (room_name, capacity, has_projector) VALUES
('Boardroom A', 12, true),
('Focus Room B', 4, false),
('Auditorium C', 50, true);

-- Insert Users
INSERT INTO users (full_name, email) VALUES
('Alice Johnson', 'alice.johnson@example.com'),
('Bob Smith', 'bob.smith@example.com'),
('Charlie Brown', 'charlie.brown@example.com');

-- Insert Bookings
INSERT INTO bookings (room_id, user_id, booking_date, duration_hours) VALUES
(1, 1, '2026-09-20', 2), -- Alice booked Boardroom A
(1, 2, '2026-09-21', 4), -- Bob booked Boardroom A
(2, 1, '2026-09-22', 1), -- Alice booked Focus Room B
(3, 3, '2026-09-20', 3); -- Charlie booked Auditorium C

--operation A
SELECT full_name,room_name,booking_date,duration_hours
FROM public.users us
INNER JOIN public.bookings bs ON us.id=bs.user_id
INNER JOIN public.rooms rs ON bs.room_id=rs.id;

--operation B
--not unique
INSERT INTO users (full_name, email) 
VALUES ('Duplicate User', 'alice.johnson@example.com');

--capacity>0
INSERT INTO rooms (room_name, capacity, has_projector) 
VALUES ('Tiny Closet', 0, false);

--hours 1-8
INSERT INTO bookings (room_id, user_id, booking_date, duration_hours) 
VALUES (1, 1, '2026-09-25', 10);

--operation C
SELECT full_name,room_id,user_id FROM users
INNER JOIN bookings on users.id=bookings.user_id;

DELETE FROM users WHERE email = 'alice.johnson@example.com';