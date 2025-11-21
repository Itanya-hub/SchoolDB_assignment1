USE SchoolProgram_project ;

-- 1. Create Parent Table: Teachers
CREATE TABLE Teachers (
    Teacher_ID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    ContactEmail VARCHAR(100) UNIQUE NOT NULL
);

-- 2. Create Parent Table: Students
CREATE TABLE Students (
    Student_ID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    EnrollmentDate DATE
);

-- 3. Create Child Table: Courses (References Teachers)
CREATE TABLE Courses (
    Course_ID VARCHAR(10) PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT NOT NULL,
    Teacher_ID INT,
    FOREIGN KEY (Teacher_ID) REFERENCES Teachers(Teacher_ID)
);

-- 4. Create Child Table: Schedules (References Courses)
CREATE TABLE Schedules (
    Schedule_ID INT PRIMARY KEY,
    Course_ID VARCHAR(10) NOT NULL,
    DayOfWeek VARCHAR(10) NOT NULL,
    StartTime TIME NOT NULL,
    Location VARCHAR(50),
    FOREIGN KEY (Course_ID) REFERENCES Courses(Course_ID)
);

-- 5. Create Associative Table: Enrollments (References Students and Courses)
CREATE TABLE Enrollments (
    Enrollment_ID INT PRIMARY KEY,
    Student_ID INT NOT NULL,
    Course_ID VARCHAR(10) NOT NULL,
    EnrollmentDate DATE,
    Grade CHAR(2),
    UNIQUE (Student_ID, Course_ID),
    FOREIGN KEY (Student_ID) REFERENCES Students(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES Courses(Course_ID)
);

-- Indexing--
-- I am indexing LastName to speed up searches performed by staff.
CREATE INDEX idx_student_lastname ON Students (LastName);

-- 1. Report View: Course Enrollment Count
CREATE VIEW CourseEnrollmentCount AS
SELECT
    C.CourseName,
    COUNT(E.Student_ID) AS TotalStudents
FROM
    Courses AS C
JOIN
    Enrollments AS E ON C.Course_ID = E.Course_ID
GROUP BY
    C.CourseName;

-- 2. Simplified View: Student Course Details
CREATE VIEW StudentCourseDetails AS
SELECT
    S.FirstName,
    S.LastName,
    C.CourseName,
    E.Grade
FROM
    Students AS S
JOIN
    Enrollments AS E ON S.Student_ID = E.Student_ID
JOIN
    Courses AS C ON E.Course_ID = C.Course_ID;
    
-- 3. Simplified View: Teacher Workload (Extra View)
CREATE VIEW TeacherWorkload AS
SELECT
    T.FirstName,
    T.LastName,
    COUNT(C.Course_ID) AS TotalCoursesTaught
FROM
    Teachers AS T
LEFT JOIN
    Courses AS C ON T.Teacher_ID = C.Teacher_ID
GROUP BY
    T.Teacher_ID, T.FirstName, T.LastName;
    
    -- Stored Procedure (Simulates enrolling a student)
DELIMITER //

-- This tells the MySQL client to stop recognizing the semicolon (;) as the end of a command and start looking for // instead.
-- This allows the MySQL client to process the multiple semicolons (;) inside the procedure block correctly.
CREATE PROCEDURE EnrollStudent(
    IN student_id_param INT,
    IN course_id_param INT
)
BEGIN
    -- I check if the enrollment already exists to prevent duplication
    IF NOT EXISTS (
        SELECT 1 FROM Enrollments WHERE Student_ID = student_id_param AND Course_ID = course_id_param
    ) THEN
        INSERT INTO Enrollments (Student_ID, Course_ID, EnrollmentDate)
        VALUES (student_id_param, course_id_param, CURDATE());
    END IF;
END //

DELIMITER ; -- This returns the delimiter back to the standard semicolon.