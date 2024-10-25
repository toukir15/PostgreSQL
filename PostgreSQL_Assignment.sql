CREATE DATABASE university_db

-- create student table 
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    age INT,
    email VARCHAR(50),
    frontend_mark INT,
    backend_mark INT,
    status VARCHAR(50)
);

-- Create a "courses" table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT
)

-- Create an "enrollment" table 
CREATE TABLE enrollment(
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
)

-- Insert a new student
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES 
('Sameer', 21, 'sameer@example.com', 48, 60, NULL),
('Zoya', 23, 'zoya@example.com', 52, 58, NULL),
('Nabil', 22, '	nabil@example.com', 37, 46, NULL),
('Rafi', 24	, 'rafi@example.com', 41, 40, NULL),
('Sophia', 22, 'sophia@example.com', 48, 60, NULL),
('Hasan', 23, '	hasan@gmail.com', 43, 39, NULL);

-- Insert a course
INSERT INTO courses(course_name, credits)
VALUES 
('Next.js', 3),
('React.js', 4),
('Database', 3),
('Prisma', 3);

-- Insert a enrolment
INSERT INTO enrollment(student_id, course_id)
VALUES 
(1, 1),
(1, 2),
(2, 1),
(3, 2);

-- Insert a new student
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES ('Toukir', 21, 'toukir@example.com', 60, 60, NULL);

-- Retrieve the names of all students who are enrolled in the course titled 'Next.js'.
SELECT student_name FROM enrollment
JOIN students on enrollment.student_id = students.student_id 
JOIN courses on enrollment.course_id = courses.course_id 
WHERE course_name = 'Next.js';

-- Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'
UPDATE students
SET status = 'Awarded'
WHERE student_id = (
    SELECT student_id
    FROM students
    ORDER BY(frontend_mark + backend_mark) DESC
    LIMIT 1
);

-- Delete all courses that have no students enrolled.
DELETE FROM courses
WHERE NOT EXISTS (
    SELECT 1
    FROM enrollment
    WHERE enrollment.course_id = courses.course_id
);

-- Retrieve the names of students using a limit of 2, starting from the 3rd student.
SELECT student_name FROM students LIMIT 2 OFFSET 2;

-- Retrieve the course names and the number of students enrolled in each course.
SELECT course_name, COUNT(enrollment.student_id) 
AS student_enrolled 
FROM courses
JOIN enrollment ON courses.course_id = enrollment.student_id
GROUP BY courses.course_name;

-- Calculate and display the average age of all students.
SELECT ROUND(AVG(age), 2) AS average_age FROM students;

-- Retrieve the names of students whose email addresses contain 'example.com'.
SELECT student_name
FROM students
WHERE email LIKE '%example.com%';