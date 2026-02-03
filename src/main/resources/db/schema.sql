CREATE DATABASE IF NOT EXISTS student_db;
USE student_db;

-- Users Table (Authentication)
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL, -- In real world, store hashed passwords
    role ENUM('ADMIN', 'STUDENT') NOT NULL
);

-- Students Table
CREATE TABLE IF NOT EXISTS students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    dob DATE,
    address TEXT,
    is_deleted BOOLEAN DEFAULT FALSE, -- Soft delete
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Courses Table
CREATE TABLE IF NOT EXISTS courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    credits INT NOT NULL
);

-- Enrollments Table (Many-to-Many relationship between Students and Courses)
CREATE TABLE IF NOT EXISTS enrollments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- Attendance Table
CREATE TABLE IF NOT EXISTS attendance (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    date DATE NOT NULL,
    status ENUM('PRESENT', 'ABSENT', 'LATE') NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- Marks Table
CREATE TABLE IF NOT EXISTS marks (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    marks_obtained DOUBLE NOT NULL,
    max_marks DOUBLE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- Sample Data
INSERT INTO users (username, password, role) VALUES 
('admin', 'admin123', 'ADMIN'),
('john.doe', 'password123', 'STUDENT'),
('jane.smith', 'password123', 'STUDENT');

INSERT INTO students (user_id, first_name, last_name, email, dob, address) VALUES 
(2, 'John', 'Doe', 'john@example.com', '2000-01-15', '123 Main St, NY'),
(3, 'Jane', 'Smith', 'jane@example.com', '2001-05-20', '456 Elm St, CA');

INSERT INTO courses (course_name, course_code, credits) VALUES 
('Java Programming', 'CS101', 4),
('Database Management', 'CS102', 3),
('Web Development', 'CS103', 3);

INSERT INTO enrollments (student_id, course_id) VALUES 
(1, 1), (1, 2),
(2, 1), (2, 3);

INSERT INTO marks (student_id, course_id, marks_obtained, max_marks) VALUES 
(1, 1, 85, 100),
(1, 2, 90, 100),
(2, 1, 78, 100),
(2, 3, 88, 100);
