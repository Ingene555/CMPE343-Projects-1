CREATE DATABASE IF NOT EXISTS mybase;
USE `mybase`;

/*Using DDL statements (create table), 
create tutor, student, course, 
takes and teaches tables.
Make sure that you specify primary keys, foreign keys, 
unique and not null values*/
CREATE TABLE tutor (
    tid INT PRIMARY KEY,
    t_fname VARCHAR(20),
    t_lname VARCHAR(20),
    hourly_wage FLOAT,
    CONSTRAINT unique_id UNIQUE (tid)
);

CREATE TABLE student(
    sid INT PRIMARY KEY,
    s_fname VARCHAR(20),
    s_lname VARCHAR(20),
    address VARCHAR(30),
    city VARCHAR(20),
    CONSTRAINT unique_id UNIQUE (sid)
);

CREATE TABLE course(
    course_code VARCHAR(10) PRIMARY KEY,
    title VARCHAR(20),
    credit FLOAT,
    semester VARCHAR(10),
    CONSTRAINT unique_code UNIQUE (course_code)
);

CREATE TABLE takes(
    sid INT,
    course_code VARCHAR(10),
    FOREIGN KEY (sid) REFERENCES student(sid),
    FOREIGN KEY (course_code) REFERENCES course(course_code)
);

CREATE TABLE teaches(
    tid INT,
    course_code VARCHAR(10),
    hours INT,
    FOREIGN KEY (tid) REFERENCES tutor(tid),
    FOREIGN KEY (course_code) REFERENCES course(course_code)
);

/*Using insert into DML statements, 
add the given records above to the designated tutor, 
student, course, takes and teaches tables*/
INSERT INTO tutor
VALUES 
(1, "Alex", "Jackson", 40),
(2, "David", "Lewis", 10),
(3, "Sue", "White", 20);

INSERT INTO student
VALUES
(1111, "Jane", "Morgan", "Yasemin sokak, Gonyeli", "Nicosia"),
(2222, "Katie", "Smith", "Gul sokak, Hamitkoy", "Kyrenia"),
(3333, "Lestie", "Carr", "Zeytin sokak, Catalkoy", "Kyrenia"),
(4444, "Max", "McKane", "Lale sokak, Kucukkaymakli", "Nicosia");

INSERT INTO course
VALUES
("CMPE343", "DBMS 1", 4, "Fall"),
("CMPE344", "DBMS 2", 4, "Spring"),
("MATH101", "calculus 1", 4, "Fall"),
("MATH121", "Linear Algebra", 2, "Fall"),
("CMPE214", "Visual Programming", 3, "Spring");

INSERT INTO  takes
VaLUES
(1111, "CMPE343"),
(1111, "CMPE214"),
(2222, "MATH101"),
(2222, "MATH121"),
(4444, "CMPE214"),
(4444, "CMPE344");

INSERT INTO teaches
VALUES
(1, "CMPE343", 3),
(1, "CMPE344", 3),
(2, "MATH101", 3),
(2, "MATH121", 2),
(3, "CMPE214", 3);

/*List all information about students 
who have taken a course called ‘DBMS’ (title) */
SELECT * FROM student 
LEFT OUTER JOIN takes 
ON student.sid = takes.sid 
LEFT OUTER JOIN course
ON course.course_code=takes.course_code
WHERE course.title="DBMS";

/* Find the last name of all tutors 
whose hourly wage is greater than 15*/
SELECT t_lname 
FROM tutor 
WHERE hourly_wage>15;

/*Find the first name of all students 
whose address contains the word ‘koy’*/
SELECT s_fname 
FROM student 
WHERE address LIKE "%koy%";

/* Display course_code of courses 
which have been taken by a student ‘1111’*/
SELECT course.course_code 
FROM course 
LEFT OUTER JOIN takes 
ON course.course_code=takes.course_code
WHERE sid=1111;

/*Display the first, 
last name and address of all students 
who live in Nicosia */
SELECT s_fname, s_lname, address
FROM student WHERE city="Nicosia";

/* List course codes of courses 
that have 4 credits and 
taught in Spring Semester */
SELECT course.course_code
FROM course 
WHERE credit=4 AND semester="Spring";

/* List course_codes of the courses 
that has 2 hours lectures*/
SELECT course.course_code
FROM course
LEFT OUTER JOIN teaches
ON course.course_code=teaches.course_code
WHERE teaches.hours=2;

/*Add a new column to the student table called CGPA 
that has float datatype*/
ALTER TABLE student ADD
(cgpa FLOAT);

/*Using DML based on sid, add the following CGPA values into the student table.  
1111→ 2.88 
2222→ 3.14 
3333→ 2.05 
4444→ 3.77 */
UPDATE student SET cgpa=2.88 WHERE sid=1111;
UPDATE student SET cgpa=3.14 WHERE sid=2222;
UPDATE student SET cgpa=2.05 WHERE sid=3333;
UPDATE student SET cgpa=3.77 WHERE sid=4444;

