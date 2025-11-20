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