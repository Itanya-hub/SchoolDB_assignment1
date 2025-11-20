-- data.sql

-- Disable foreign key checks temporarily for TRUNCATE commands
SET FOREIGN_KEY_CHECKS = 0;

-- For clearing data from tables (Child tables first)
TRUNCATE TABLE Enrollments;
TRUNCATE TABLE Schedules;
TRUNCATE TABLE Courses;
TRUNCATE TABLE Students;
TRUNCATE TABLE Teachers;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;


-- Teachers Table (Lärare)
INSERT INTO Teachers (Teacher_ID, FirstName, LastName, ContactEmail) VALUES
(101, 'Fabian', 'Ugglas', 'fabian.ug@univ.edu'),
(102, 'Maria', 'Svensson', 'maria.s@univ.edu'),
(103, 'Nicklas', 'Lundgren', 'nicklas.l@univ.edu'),
(104, 'Tanya', 'Larsson', 'tanya.l@univ.edu');

-- Students Table (Studenter)
INSERT INTO Students (Student_ID, FirstName, LastName, Email, EnrollmentDate) VALUES
(201, 'Alicia', 'Karlsson', 'alicia.k@student.edu', '2024-08-20'),
(202, 'David', 'Ek', 'david.e@student.edu', '2024-08-20'),
(203, 'Frida', 'Bergman', 'frida.b@student.edu', '2024-09-01'),
(204, 'Erik', 'Jansson', 'erik.j@student.edu', '2024-09-01'),
(205, 'Gustav', 'Hansen', 'gustav.h@student.edu', '2025-01-15'),
(206, 'Sofia', 'Lind', 'sofia.l@student.edu', '2025-01-15'),
(207, 'Hugo', 'Mårtensson', 'hugo.m@student.edu', '2025-02-01'),
(208, 'Elin', 'Nilsson', 'elin.n@student.edu', '2025-02-01');


-- Courses Table (Kurser) - References Teachers(Teacher_ID)
INSERT INTO Courses (Course_ID, CourseName, Credits, Teacher_ID) VALUES
('WD101', 'Wood Design', 15, 101),       -- Fabian Ugglas
('CS202', 'Database Systems', 7.5, 102),  -- Maria Svensson
('HIST301', 'World History', 7.5, 103),   -- Nicklas Lundgren
('MDF404', 'Modern furniture', 15, 101),  -- Fabian Ugglas
('PH202', 'Western Philosophy', 15, 104), -- Tanya Larsson
('TH100', 'Thai foundation', 7.5, 104);   -- Tanya Larsson


-- Schedules Table (Scheman) - References Courses(Course_ID)
INSERT INTO Schedules (Schedule_ID, Course_ID, DayOfWeek, StartTime, Location) VALUES
(501, 'WD101', 'Monday', '09:00:00', 'Room A101'),
(502, 'CS202', 'Tuesday', '13:00:00', 'Lab B205'),
(503, 'HIST301', 'Wednesday', '10:30:00', 'Room C302'),
(504, 'MDF404', 'Thursday', '14:00:00', 'Room A101'),
(505, 'PH202', 'Friday', '10:00:00', 'Room B301'),
(506, 'TH100', 'Friday', '14:00:00','Room B302');


-- Enrollments Table (Registreringar) - References Students and Courses
INSERT INTO Enrollments (Enrollment_ID, Student_ID, Course_ID, EnrollmentDate, Grade) VALUES
-- 2024 Students taking original courses (WD101, CS202)
(601, 201, 'WD101', '2024-08-20', 'A'),   -- Alicia in Wood Design
(602, 201, 'CS202', '2024-08-20', 'B'),   -- Alicia in Databases
(603, 202, 'WD101', '2024-08-20', 'C'),   -- David in Wood Design
(604, 203, 'HIST301', '2024-09-01', 'A'),  -- Frida in History
(605, 203, 'MDF404', '2024-09-01', 'B'),   -- Frida in Modern Furniture
(606, 204, 'CS202', '2024-09-01', NULL),  -- Erik in Databases (No grade yet)


-- 2025 Students taking new/existing courses (Ph202, HIST301)
(607, 205, 'Ph202', '2025-01-15', NULL), -- Gustav in Western Philosophy
(608, 206, 'HIST301', '2025-01-15', NULL), -- Sofia in History
(609, 207, 'WD101', '2025-02-01', NULL), -- Hugo in Wood Design
(610, 208, 'CS202', '2025-02-01', NULL), -- Elin in Databases
(611, 202, 'TH100', '2025-02-01', NULL), -- David in Thai Foundation 
(612, 203, 'TH100', '2025-02-01', NULL); -- Frida in Thai Foundation 



