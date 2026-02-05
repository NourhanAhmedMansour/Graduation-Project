import pandas as pd

students = pd.read_csv("Students.csv")
enrollments = pd.read_csv("Enrollments.csv")
payments = pd.read_csv("Payment.csv")
reviews = pd.read_csv("Reviews.csv")
courses = pd.read_csv("Courses.csv")
instructors = pd.read_csv("Instructors.csv")

analysis = (enrollments
            .merge(students, on="student_id", how="left")
            .merge(payments, on="enrollment_id", how="left")
            .merge(reviews, on="enrollment_id", how="left")
            .merge(courses, on="student_id", how="left")
            .merge(instructors, on="instructor_id", how="left")
           )

print("Rows:", len(analysis))
print("Any missing?", analysis.isna().sum().sum())

analysis.to_csv("analysis_dataset_full_no_missing.csv", index=False)