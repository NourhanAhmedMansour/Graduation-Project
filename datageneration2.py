import random
from datetime import date, timedelta
import pandas as pd
from faker import Faker
fake = Faker()
# ====== SETTINGS ======
N_STUDENTS = 200
N_INSTRUCTORS = 20

COURSE_TITLES = ["Database Fundamentals", "SQL Server Essentials", "Power BI Basics",
    "Python for Data Analysis", "Excel Reporting", "Data Visualization",
    "ETL Foundations", "Business Intelligence", "Data Modeling",
    "Statistics for Data", "Intro to Programming", "Advanced SQL Queries"]

PAYMENT_METHODS = ["Cash", "Credit Card", "Wallet"]
STATUSES = ["Done", "InProgress", "Pending", "Cancelled"]

def rand_date(start_year=2023, end_year=2025):
    start = date(start_year, 1, 1)
    end = date(end_year, 12, 31)
    return start + timedelta(days=random.randint(0, (end - start).days))
# ====== 1) STUDENTS ======
students = []
emails = set()
for sid in range(1, N_STUDENTS + 1):
    email = fake.email()
    while email in emails:
        email = fake.email()
    emails.add(email)
    students.append({"student_id": sid,"studentname": fake.name(),"email": email,"phone": fake.phone_number(),
    "address": fake.city(),"join_date": rand_date(2023, 2025) })
df_students = pd.DataFrame(students)

# ====== 2)INSTRUCTORS======
instructors = []
inst_emails = set()
for iid in range(1, N_INSTRUCTORS + 1):
    email = fake.email()
    while email in inst_emails:
        email = fake.email()
    inst_emails.add(email)
    instructors.append({"instructor_id": iid,"instructorname": fake.name(),"email": email,"phone": fake.phone_number(),
    "address": fake.city(),"join_date": rand_date(2023, 2025)})
df_instructors = pd.DataFrame(instructors)

# ====== 3) COURSES ======
courses = []
course_names_used = set()
for cid, sid in enumerate(range(1, N_STUDENTS + 1), start=1):
    base = random.choice(COURSE_TITLES)
    # ensure unique coursename (your table has UNIQUE)
    cname = f"{base} - {sid}"
    while cname in course_names_used:
        cname = f"{base} - {sid} - {random.randint(1,9999)}"
    course_names_used.add(cname)
    courses.append({"course_ids": cid,"student_id": sid,"instructor_id": random.randint(1, N_INSTRUCTORS),
     "coursename": cname })
df_courses = pd.DataFrame(courses)

# ====== 4) ENROLLMENTS ======
enrollments = []
for eid, sid in enumerate(range(1, N_STUDENTS + 1), start=1):
    status = random.choices(STATUSES, weights=[0.55, 0.25, 0.15, 0.05], k=1)[0]
    if status == "Done":
        progress = round(random.uniform(95, 100), 2)
    elif status == "InProgress":
        progress = round(random.uniform(30, 94), 2)
    elif status == "Pending":
        progress = 0.0
    else:  
        progress = round(random.uniform(0, 50), 2)
    enroll_date = rand_date(2023, 2025)
    enrollments.append({"enrollment_id": eid,"student_id": sid,"enrollment_date": enroll_date,"progress_percentage": progress,
     "completion_status": status})
df_enrollments = pd.DataFrame(enrollments)

# ====== 5) PAYMENT======
payments = []
for pid, eid in enumerate(range(1, N_STUDENTS + 1), start=1):
    revenue = round(random.uniform(100, 900), 2)
    payments.append({"payment_id": pid,"enrollment_id": eid,"revenue": revenue,"payment_method": random.choice(PAYMENT_METHODS)})
df_payments = pd.DataFrame(payments)

# ====== 6) REVIEWS ======
reviews = []
for rid, eid in enumerate(range(1, N_STUDENTS + 1), start=1):
    rating = random.randint(1, 10)
    enroll_date = df_enrollments.loc[df_enrollments["enrollment_id"] == eid, "enrollment_date"].values[0]
    review_date = pd.to_datetime(enroll_date) + pd.Timedelta(days=random.randint(1, 60))
    reviews.append({"review_id": rid,"enrollment_id": eid,"rating": rating,"review_text": fake.sentence(nb_words=8),
    "review_date": review_date.date()})
df_reviews = pd.DataFrame(reviews)

# ====== SAVE CSVs ======
df_students.to_csv("Students.csv", index=False)
df_instructors.to_csv("Instructors.csv", index=False)
df_courses.to_csv("Courses.csv", index=False)
df_enrollments.to_csv("Enrollments.csv", index=False)
df_payments.to_csv("Payment.csv", index=False)
df_reviews.to_csv("Reviews.csv", index=False)