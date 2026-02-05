Project Description
This project represents an Online Courses Platform Data Management and Analytics System designed 
to store, manage, and analyze data related to students, instructors, courses, enrollments,
payments, and course reviews.
The main objective of this project is to build a complete data solution from scratch, 
starting from database design to advanced data analysis and visualization. 
The system helps stakeholders understand user behavior, track revenue performance, 
measure course popularity, and evaluate instructor effectiveness.
Using a relational database, the platform stores structured information about students, 
available courses, instructors, enrollment records, payment transactions, and user feedback. 
Python is used to generate realistic datasets, clean and analyze data, while SQL is used to 
answer real business questions such as identifying top-selling courses, monthly revenue trends, 
student completion rates, and customer segmentation.
The analyzed results are exported to Excel to create pivot tables and charts, 
and finally visualized in Power BI through an interactive dashboard that provides 
key performance indicators (KPIs) and filters for deeper insights. 
This system supports data-driven decision-making for improving course quality, 
marketing strategies, and overall platform performance.
---------------------------------------------------------------------------------------------------
Problem Statement:

Online learning platforms generate large amounts of data from different activities such as student registrations, course enrollments, payments, and course feedback. Without a well-structured data system, it becomes difficult to track performance, understand learner behavior, and make informed business decisions.
This project addresses the need for a centralized, relational database that can:
Organize platform data efficiently (students, instructors, courses, enrollments, payments, and reviews).
Support business reporting such as revenue trends, top-performing courses, and instructor performance.
Provide insights into learner engagement, completion rates, and satisfaction through ratings and progress tracking.
By transforming raw operational data into meaningful analytics, the platform can improve course offerings, marketing strategies, and overall user experience.
Database Design Explanation
The database is designed as a relational model to ensure data consistency, scalability, and easy analysis. The design includes six related tables, each representing a key entity in the online courses platform:

Students:
Stores student profiles and signup information. Each student has a unique identifier (student_id) used across the database.

Instructors:
Stores instructor details and areas of specialization. Each instructor can create multiple courses.

Courses:
Stores course information such as title, category, level, price, and the instructor responsible for the course.
instructor_id is a foreign key referencing the Instructors table.

Enrollments:
Acts as a bridge table between Students and Courses, capturing each enrollment event.
It stores enrollment date, progress percentage, and completion status.

Payments:
Stores payment transactions linked to enrollments. This allows tracking revenue, payment methods, and refund cases.
Each payment is linked to a specific enrollment through enrollment_id.

Reviews:
Stores student ratings and feedback after taking a course. Reviews are linked to enrollments to ensure that only enrolled students can review a course.
----------------------------------------------------------------------------------------------------
Key Relationships
One instructor can teach many courses (1-to-many).
One student can enroll in many courses, and each course can have many enrolled students (many-to-many resolved by the Enrollments table).
Each enrollment can have one or more payment transactions (supporting installments or refunds).
Each enrollment can have zero or one review (not all students leave feedback).
This structure supports accurate reporting, prevents duplicate data, and enables meaningful analysis using SQL, Python, Excel, and Power BI.
----------------------------------------------------------------------------------------------------
Project Objectives:
The main objectives of this project are:
Design and implement a well-structured relational database for an online learning platform.
Create a realistic dataset that simulates real user behavior and platform activity.
Analyze platform data to discover trends in enrollments, revenue, and course performance.
Identify top-performing courses and instructors based on sales and user ratings.
Measure student engagement through progress tracking and completion rates.
Build interactive dashboards to support data-driven business decisions.
Expected Insights
This project aims to provide valuable insights such as:
Monthly revenue trends and peak enrollment periods.
Best-selling and highest-rated courses.
Student completion and dropout rates by course category and difficulty level.
Top spending customers and most profitable instructors.
Most preferred payment methods.
Relationship between course pricing and student satisfaction.