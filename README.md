---------------Education Management System Database--------------------

This database is designed to manage and track an education platform's core entities: Students, Teachers, Courses, Schedules, and Enrollments.

1. Setup and Installation
To set up the database, you must run the three main SQL files in the exact order specified below, using a tool like MySQL Workbench.

  A. Create Structure	=> schema.sql	  --  Creates the database, all five tables, Foreign Keys, Views, and the Stored Procedure.
  B. Insert Data	    => data.sql	    --  Populates all tables with sample data (Students, Teachers, Courses, etc.).
  C. Run Reports	    => queries.sql	--  Contains all the analytical reports, tests, and proof-of-concept queries.



2. Key Database Operations (How to Use)
The primary way to interact with the database is by executing specific commands in MySQL Workbench.

  A. Run Analytical Report	 => Highlight and execute the complex SELECT query in queries.sql that uses GROUP BY and HAVING to prove the system can find all teachers who teach more than one course

  B. Calculate Average GPA  =>	Highlight and execute the SELECT query that uses ROUND(AVG(CASE...)) in queries.sql to prove the system can transform text grades into a professional numerical metric.

  C. Enroll a Student       =>	CALL EnrollStudent(student_id_param, course_id_param);	to prove the Stored Procedure works, preventing duplicate enrollments and automating the process.

  D. Check Data Integrity   => 	SELECT * FROM Teachers;	 to verifies the content of a single table.
