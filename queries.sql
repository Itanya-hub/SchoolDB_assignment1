-- 1. Report: List all students, their enrolled courses, and grades (3-Table JOIN)
SELECT
    S.FirstName,
    S.LastName,
    C.CourseName,
    E.Grade,
    E.EnrollmentDate
FROM
    Students AS S
JOIN
    Enrollments AS E ON S.Student_ID = E.Student_ID
JOIN
    Courses AS C ON E.Course_ID = C.Course_ID
ORDER BY
    S.LastName, E.EnrollmentDate;
    
    
    -- 2. Report: List all student enrollments, including the course teacher (4-Table JOIN)
SELECT
    S.FirstName AS StudentFirstName,
    S.LastName AS StudentLastName,
    C.CourseName,
    T.FirstName AS TeacherFirstName,
    T.LastName AS TeacherLastName,
    E.Grade,
    E.EnrollmentDate
FROM
    Students AS S
JOIN
    Enrollments AS E ON S.Student_ID = E.Student_ID
JOIN
    Courses AS C ON E.Course_ID = C.Course_ID
JOIN
    Teachers AS T ON C.Teacher_ID = T.Teacher_ID  -- New JOIN
ORDER BY
    StudentLastName, CourseName;
    
    
    -- 3. Report: Count the number of students enrolled in each course
SELECT
    C.CourseName,
    T.FirstName AS TeacherFirstName,
    T.LastName AS TeacherLastName,
    COUNT(E.Student_ID) AS TotalStudentsEnrolled
FROM
    Courses AS C
JOIN
    Teachers AS T ON C.Teacher_ID = T.Teacher_ID -- Link to get Teacher Name
LEFT JOIN
    Enrollments AS E ON C.Course_ID = E.Course_ID -- LEFT JOIN ensures courses with 0 students still appear
GROUP BY
    C.CourseName, T.FirstName, T.LastName
ORDER BY
    TotalStudentsEnrolled DESC, C.CourseName;
    
    -- 4. Report: List all courses and schedules taught by a specific teacher (e.g., Tanya Larsson)
SELECT
    T.FirstName AS TeacherFirstName,
    T.LastName AS TeacherLastName,
    C.CourseName,
    S.DayOfWeek,
    S.StartTime,
    S.Location
FROM
    Teachers AS T
JOIN
    Courses AS C ON T.Teacher_ID = C.Teacher_ID
JOIN
    Schedules AS S ON C.Course_ID = S.Course_ID
WHERE
    T.LastName = 'Larsson' -- Filter for Tanya Larsson
ORDER BY
    S.DayOfWeek, S.StartTime;
    
    -- 5. Report: Identify teachers who teach more than 1 course (using COUNT and HAVING)
SELECT
    T.FirstName,
    T.LastName,
    COUNT(C.Course_ID) AS NumberOfCoursesTaught
FROM
    Teachers AS T
JOIN
    Courses AS C ON T.Teacher_ID = C.Teacher_ID
GROUP BY
    T.Teacher_ID, T.FirstName, T.LastName
HAVING
    COUNT(C.Course_ID) > 1
ORDER BY
    NumberOfCoursesTaught DESC;
    
    
    -- 6. Report: Find all enrollments where the final grade has not been entered (i.e., Grade is NULL)
SELECT
    S.FirstName,
    S.LastName,
    C.CourseName,
    T.LastName AS Teacher,
    E.EnrollmentDate
FROM
    Enrollments AS E
JOIN
    Students AS S ON E.Student_ID = S.Student_ID
JOIN
    Courses AS C ON E.Course_ID = C.Course_ID
JOIN
    Teachers AS T ON C.Teacher_ID = T.Teacher_ID
WHERE
    E.Grade IS NULL
ORDER BY
    E.EnrollmentDate DESC;
    
    
    -- 7. Report: Calculate the average credit value of courses taught by each teacher
SELECT
    T.FirstName,
    T.LastName,
    COUNT(C.Course_ID) AS TotalCourses,
    AVG(C.Credits) AS AverageCreditsTaught
FROM
    Teachers AS T
JOIN
    Courses AS C ON T.Teacher_ID = C.Teacher_ID
GROUP BY
    T.Teacher_ID, T.FirstName, T.LastName
ORDER BY
    AverageCreditsTaught DESC;
    
    
    -- 8. Report: Count total student enrollments broken down by the year of enrollment
SELECT
    YEAR(EnrollmentDate) AS EnrollmentYear,
    COUNT(Student_ID) AS TotalStudentsEnrolled
FROM
    Students
GROUP BY
    EnrollmentYear
ORDER BY
    EnrollmentYear;
    
    -- 9. Report: Find all students enrolled in courses taught by Tanya Larsson (using a Subquery)
SELECT
    S.FirstName,
    S.LastName,
    C.CourseName
FROM
    Students AS S
JOIN
    Enrollments AS E ON S.Student_ID = E.Student_ID
JOIN
    Courses AS C ON E.Course_ID = C.Course_ID
WHERE
    C.Teacher_ID IN (
        SELECT Teacher_ID
        FROM Teachers
        WHERE LastName = 'Larsson'
    )
ORDER BY
    S.LastName, C.CourseName;
    
    
    -- 10. Report: Format student names and display the enrollment year using SQL functions
SELECT
    CONCAT(UPPER(S.LastName), ', ', S.FirstName) AS StudentFullName,
    YEAR(S.EnrollmentDate) AS EnrollmentYear,
    S.Email -- ***FIXED: Changed ContactEmail to Email***
FROM
    Students AS S
ORDER BY
    S.LastName;
    
    -- 11. Report: Categorize student performance based on their grades (Using CASE Statement)
SELECT
    S.FirstName,
    S.LastName,
    C.CourseName,
    E.Grade,
    CASE
        WHEN E.Grade = 'A' THEN 'Excellent'
        WHEN E.Grade = 'B' OR E.Grade = 'C' THEN 'Passing'
        WHEN E.Grade IS NULL THEN 'In Progress'
        ELSE 'Needs Review'
    END AS PerformanceCategory
FROM
    Students AS S
JOIN
    Enrollments AS E ON S.Student_ID = E.Student_ID
JOIN
    Courses AS C ON E.Course_ID = C.Course_ID
ORDER BY
    S.LastName, E.Grade;
    
-- 12. Create a VIEW for the main Enrollment Report
DROP VIEW IF EXISTS V_EnrollmentReport;

CREATE VIEW V_EnrollmentReport AS
SELECT
    S.FirstName AS StudentFirstName,
    S.LastName AS StudentLastName,
    C.CourseName,
    T.LastName AS TeacherLastName,
    E.Grade
FROM
    Students AS S
JOIN Enrollments AS E ON S.Student_ID = E.Student_ID
JOIN Courses AS C ON E.Course_ID = C.Course_ID
JOIN Teachers AS T ON C.Teacher_ID = T.Teacher_ID;

-- Query to test the new VIEW
SELECT
    StudentFirstName,
    StudentLastName,
    CourseName
FROM
    V_EnrollmentReport
WHERE
    Grade IS NULL;


-- 13. Action: UPDATE a teacher's contact email (Simulate modifying data)
UPDATE Teachers
SET ContactEmail = 'fabian.ugglas@newmail.com'
WHERE Teacher_ID = 101;

-- Verification query (Optional: Run to see the change)
SELECT * FROM Teachers WHERE Teacher_ID = 101;


-- 14. Action: DELETE a specific data row (Simulate removing specific data)
-- It will delete an enrollment that has no grade yet (e.g., Hugo in WD101)
-- Student 207 (Hugo) is currently taking WD101

DELETE FROM Enrollments
WHERE Student_ID = 207 AND Course_ID = 'WD101';

-- Verification query (Optional: Run to ensure Hugo's enrollment in WD101 is gone)
SELECT * FROM Enrollments WHERE Student_ID = 207;


-- 15. Report: Free-text search (LIKE) to find all courses related to 'Design' or 'Wood'
SELECT
    Course_ID,
    CourseName
FROM
    Courses
WHERE
    CourseName LIKE '%Design%' OR CourseName LIKE '%wood%'
ORDER BY
    CourseName;