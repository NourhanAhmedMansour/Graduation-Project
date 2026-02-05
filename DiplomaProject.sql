create database OnlineCources;
use OnlineCources;

DROP DATABASE [OnlineCources];
SELECT
    session_id,
    login_name,
    host_name,
    status
FROM sys.dm_exec_sessions
WHERE database_id = DB_ID('OnlineCources');

kill 74;
Drop table Enrollments;
create table Students(student_id int identity(1,1) primary key, 
studentname nvarchar (100) not null, 
email  nvarchar (100) unique, 
phone nvarchar (20) , 
address nvarchar (100) not null, 
join_date date);
create table Instructors(instructor_id int identity(1,1) primary key,
instructorname nvarchar (100) not null, 
email  nvarchar (100) unique, 
phone nvarchar (20) , 
address nvarchar (100) not null, 
join_date date);
CREATE TABLE Courses (course_id INT IDENTITY(1,1) PRIMARY KEY,instructor_id INT NOT NULL,
coursename NVARCHAR(100) UNIQUE NOT NULL,
category NVARCHAR(50),
level NVARCHAR(50),
price DECIMAL(10,2),
FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id));

CREATE TABLE Enrollments (enrollment_id INT IDENTITY(1,1) PRIMARY KEY,
student_id INT NOT NULL,
course_id INT NOT NULL,
enrollment_date DATE,
progress_percentage DECIMAL(5,2),
completion_status NVARCHAR(20),
FOREIGN KEY (student_id) REFERENCES Students(student_id),
FOREIGN KEY (course_id) REFERENCES Courses(course_id));

CREATE TABLE Payment (payment_id INT IDENTITY(1,1) PRIMARY KEY,
enrollment_id INT NOT NULL,
revenue DECIMAL(10,2),
payment_method NVARCHAR(50),
payment_date DATE,
FOREIGN KEY (enrollment_id) REFERENCES Enrollments(enrollment_id));

CREATE TABLE Reviews (review_id INT IDENTITY(1,1) PRIMARY KEY,
enrollment_id INT NOT NULL,
rating INT CHECK (rating BETWEEN 0 AND 10),
review_text NVARCHAR(200),
review_date DATE,
FOREIGN KEY (enrollment_id) REFERENCES Enrollments(enrollment_id));






INSERT INTO Students (studentname, email, phone, address, join_date)
VALUES
('Matthew Boyd', 'maldonadojoy@example.org', '+20-986-854-3799', 'Port Rachelside', '2024-06-03'),
('David Taylor', 'colleenlee@example.org', '+20-720-405-6813', 'Ramirezstad', '2025-10-27'),
('Susan Simpson', 'andrew70@example.org', '+20-812-341-1657', 'West Rebeccachester', '2025-05-02'),
('Matthew Escobar', 'browndarlene@example.com', '+20-669-836-2869', 'Davidville', '2024-10-12'),
('John Kelly', 'david54@example.org', '+20-683-484-6990', 'South Morganshire', '2023-02-24'),
('Julia Benson', 'williamslisa@example.org', '+20-837-622-8109', 'West Lisafort', '2024-05-27'),
('Cristian Hall', 'petersonlonnie@example.org', '+20-596-316-2705', 'Gallowayfort', '2024-06-01'),
('Cheryl Mclaughlin', 'bryantkelly@example.com', '+20-309-534-6082', 'Hillfort', '2024-06-03'),
('Jonathan Munoz', 'julia58@example.com', '+20-473-733-2314', 'South Michaelfort', '2025-11-26'),
('Denise Garcia', 'patricia56@example.com', '+20-932-677-9483', 'Wendyville', '2023-05-18'),
('Gary Bond', 'jeffreyhogan@example.net', '+20-636-458-6295', 'Johnsonbury', '2025-06-11'),
('Neil Larson', 'dgibson@example.net', '+20-861-511-2033', 'Harrisport', '2024-08-23'),
('Brittany Torres', 'ricardomcclure@example.org', '+20-555-475-6798', 'Davisshire', '2023-07-03'),
('Jennifer Horton', 'mccarthytyler@example.org', '+20-189-419-2556', 'Lisaview', '2024-07-09'),
('Patrick Wilson', 'katiewhite@example.org', '+20-906-321-5472', 'New David', '2023-08-11'),
('Mrs. Natalie Murphy', 'bradfordrichard@example.com', '+20-945-866-2808', 'Shannonland', '2024-03-28'),
('Kenneth Baxter', 'dana02@example.com', '+20-611-624-2145', 'East Shannontown', '2024-08-11'),
('Lauren Kennedy', 'stephanie86@example.com', '+20-904-284-2959', 'Fernandezville', '2024-03-09'),
('Michele Murphy', 'jenniferhopkins@example.net', '+20-562-596-1628', 'Foxhaven', '2023-09-11'),
('Lori White', 'christinagardner@example.org', '+20-549-908-3742', 'Port Dawn', '2023-01-22');



INSERT INTO Instructors (instructorname, email, phone, address, join_date)
VALUES
('Omar Hassan',        'omar.hassan@example.com',       '+20-102-345-6789', 'Nasr City, Cairo',         '2023-01-15'),
('Salma El-Sayed',     'salma.elsayed@example.com',     '+20-115-987-1234', 'Heliopolis, Cairo',        '2023-02-10'),
('Mahmoud Ali',        'mahmoud.ali@example.com',       '+20-120-555-9012', 'Giza, Dokki',              '2023-03-05'),
('Nour Abdelrahman',   'nour.abdelrahman@example.com',  '+20-111-234-5567', 'Maadi, Cairo',             '2023-04-19'),
('Hassan Mostafa',     'hassan.mostafa@example.com',    '+20-128-765-4400', '6th of October, Giza',     '2023-05-07'),
('Marwa Hussein',      'marwa.hussein@example.com',     '+20-100-332-7788', 'Zamalek, Cairo',           '2023-06-12'),
('Youssef Kamal',      'youssef.kamal@example.com',     '+20-114-920-6611', 'Mohandessin, Giza',        '2023-07-25'),
('Rana Tawfik',        'rana.tawfik@example.com',       '+20-122-310-4499', 'New Cairo, Cairo',         '2023-08-14'),
('Karim Nabil',        'karim.nabil@example.com',       '+20-109-774-2201', 'Ain Shams, Cairo',         '2023-09-02'),
('Heba Magdy',         'heba.magdy@example.com',        '+20-127-643-5575', 'Shubra, Cairo',            '2023-10-11'),
('Mostafa Fathy',      'mostafa.fathy@example.com',     '+20-106-818-9034', 'Imbaba, Giza',             '2023-11-06'),
('Farah Adel',         'farah.adel@example.com',        '+20-113-507-2680', 'Garden City, Cairo',       '2023-12-20');


INSERT INTO Courses (instructor_id, coursename)
VALUES
(1,  'Introduction to Quality Engineering'),
(2,  'Database Fundamentals'),
(3,  'Object-Oriented Programming with C#'),
(4,  'Web Development Basics'),
(5,  'Data Modeling & Normalization'),
(6,  'SQL Server Essentials'),
(7,  'Advanced T-SQL Queries'),
(8,  'API Design & REST Principles'),
(9,  'Version Control with Git'),
(10, 'Software Testing Foundations'),
(11, 'Unit Testing & Test-Driven Development'),
(12, 'Agile & Scrum Practices'),
(1,  'Introduction to Quality Engineering1'),
(2,  'Database Fundamentals2'),
(3,  'Object-Oriented Programming with C#3'),
(4,  'Web Development Basics4'),
(5,  'Data Modeling & Normalization5'),
(6,  'SQL Server Essentials6'),
(8,  'Advanced T-SQL Queries7');


INSERT INTO Enrollments (student_id, course_id, enrollment_date, progress_percentage, completion_status)
VALUES
(  1,  1, '2025-02-10',  90, 'InProgress'),
(  2,  2, '2023-03-05', 100, 'Done'),
(  3,  3, '2025-04-19',   0, 'Cancelled'),
(  4,  4, '2025-05-07',  99, 'InProgress'),
(  5,  5, '2023-06-12',   0, 'Cancelled'),
(  6,  6, '2023-07-25', 100, 'Done'),
(  7,  7, '2023-08-14',   0, 'Cancelled'),
(  8,  8, '2025-12-20',   0, 'Pending'),
(  9,  9, '2025-08-14',  95, 'InProgress'),
( 10, 10, '2025-07-25',   0, 'Pending'),
( 11, 11, '2023-09-02', 100, 'Done'),
( 12, 12, '2025-09-02',   0, 'Pending'),
( 13, 13, '2025-07-25',  85, 'InProgress'),
( 14, 14, '2023-09-02', 100, 'Done'),
( 15, 15, '2025-11-06',  50, 'InProgress'),
( 16, 16, '2025-08-14',   0, 'Pending'),
( 17, 17, '2023-11-06', 100, 'Done'),
( 18, 18, '2025-09-02',  70, 'InProgress'),
( 19, 19, '2023-07-25', 100, 'Done');


INSERT INTO Payment (enrollment_id, revenue, payment_method)
VALUES
(  1,  3000,  'Cash' ),
(  2,  5000,  'Credit Card'),
(  3,  5500,  'Cash'),
(  4,  5700,  'Cash'),
(  5,  7000,  'Credit Card'),
(  6,  4500,  'Cash'),
(  7,  76000, 'Credit Card'),
(  8,  7600,  'Cash'),
(  9,  6700,  'Cash'),
( 10,  9000,  'Credit Card'),
( 11,  8500,  'Cash'),
( 12, 10000,  'Credit Card'),
( 13,  2300,  'Cash'),
( 14, 65000,  'Credit Card'),
( 15,  5000,  'Cash'),
( 16,  6000,  'Cash'),
( 17,  7400,  'Credit Card'),
( 18,  9700,  'Credit Card'),
( 19,  8600,  'Cash');
GO

INSERT INTO Reviews (enrollment_id, rating, review_text, review_date)
VALUES
(  1,  9, 'Very Good course' ,'2026-02-10'),
(  2,  6, 'It could be more useful', '2026-02-10'),
(  3,  0, 'N/A', '2999-01-01'),
(  4,  5, 'It could be more useful','2026-02-10'),
(  5,  0, 'N/A', '2999-01-01'),
(  6,  9, 'Very Good course','2026-02-10'),
(  7,  0, 'N/A', '2999-01-01'),
(  8,  0, 'N/A', '2999-01-01'),
(  9,  7, 'Happy to take this Course','2026-02-10'),
( 10,  0, 'N/A', '2999-01-01'),
( 11,  8, 'Happy to take this Course','2026-02-10'),
( 12,  0, 'N/A', '2999-01-01'),
( 13,  4, 'It could be more useful','2026-02-10'),
( 14,  9, 'Very Good course','2026-02-10'),
( 15,  9, 'Very Good course','2026-02-10'),
( 16,  0, 'N/A', '2999-01-01'),
( 17,  8, 'Happy to take this Course','2026-02-10'),
( 18,  9, 'Very Good course','2026-02-10'),
( 19,  7, 'Happy to take this Course','2026-02-10');

select * from Reviews;
/*ALTER TABLE dbo.Enrollments
ALTER COLUMN completion_status NVARCHAR(50) NOT NULL;
DELETE FROM dbo.Enrollments;
DBCC CHECKIDENT ('dbo.Enrollments', RESEED, 0);
drop table Courses;*/

/* Total payments + Total revenue*/ 
SELECT COUNT(*) AS total_payments,SUM(p.revenue) AS total_revenue
FROM Payment p;

/* Total payments + revenue according to the payment method */ 
SELECT p.payment_method,COUNT(*) AS payments_count,SUM(p.revenue) AS total_revenue
FROM Payment p
GROUP BY p.payment_method
ORDER BY total_revenue DESC;

/* Revenue according to year and month */ 
SELECT YEAR(e.enrollment_date) AS yr,MONTH(e.enrollment_date) AS mn,SUM(p.revenue) AS monthly_revenue
FROM Payment p
JOIN Enrollments e ON e.enrollment_id = p.enrollment_id
GROUP BY YEAR(e.enrollment_date), MONTH(e.enrollment_date)
ORDER BY yr, mn;
 
/* Top Courses by Revenue */ 
SELECT TOP 5 c.coursename,SUM(p.revenue) AS total_revenue
FROM Payment p
JOIN Enrollments e ON e.enrollment_id = p.enrollment_id
JOIN Courses c ON c.course_id = e.course_id
GROUP BY c.coursename
ORDER BY total_revenue DESC;

/*Most 5 Popular Courses*/
SELECT TOP 5 c.coursename,COUNT(*) AS enrollments_count
FROM Enrollments e
JOIN Courses c ON c.course_id = e.course_id
GROUP BY c.coursename
ORDER BY enrollments_count DESC;

/*Top Instructors by Revenue*/
SELECT TOP 5 i.instructorname,SUM(p.revenue) AS total_revenue
FROM Payment p
JOIN Enrollments e ON e.enrollment_id = p.enrollment_id
JOIN Courses c ON c.course_id = e.course_id
JOIN Instructors i ON i.instructor_id = c.instructor_id
GROUP BY i.instructorname
ORDER BY total_revenue DESC;

/*Enrollments count based on completion_status*/
SELECT e.completion_status, COUNT(*) AS enrollments_count
FROM Enrollments e
GROUP BY e.completion_status
ORDER BY enrollments_count DESC;

/*Completion Rate %*/
SELECT CAST(100.0 * SUM(CASE WHEN e.completion_status = 'Done' THEN 1 ELSE 0 END)
/ NULLIF(COUNT(*), 0)
AS DECIMAL(5,2)) AS completion_rate_pct
FROM Enrollments e;

/*Courses AVG Rating*/
SELECT c.coursename,AVG(CAST(r.rating AS DECIMAL(5,2))) AS avg_rating,
COUNT(*) AS reviews_count
FROM Reviews r
JOIN Enrollments e ON e.enrollment_id = r.enrollment_id
JOIN Courses c ON c.course_id = e.course_id
WHERE r.rating > 0 AND r.review_text <> 'N/A'
GROUP BY c.coursename
ORDER BY avg_rating DESC;

/*Top Instructors by Rating*/
SELECT i.instructorname,AVG(CAST(r.rating AS DECIMAL(5,2))) AS avg_rating,
COUNT(*) AS reviews_count
FROM Reviews r
JOIN Enrollments e ON e.enrollment_id = r.enrollment_id
JOIN Courses c ON c.course_id = e.course_id
JOIN Instructors i ON i.instructor_id = c.instructor_id
WHERE r.rating > 0 AND r.review_text <> 'N/A'
GROUP BY i.instructorname
ORDER BY avg_rating DESC;

