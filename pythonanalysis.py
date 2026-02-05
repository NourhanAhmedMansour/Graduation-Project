import pandas as pd
import matplotlib.pyplot as plt

# =========================
# Load dataset
# =========================
FILE = "analysis_dataset_full_no_missing.csv"
df = pd.read_csv(FILE)
print("Rows, Columns:", df.shape)
print("\nMissing values per column:\n", df.isna().sum())

# =========================
# Data types + dates
# =========================
date_cols = ["join_date", "enrollment_date", "review_date"]
for c in date_cols:
    if c in df.columns:
        df[c] = pd.to_datetime(df[c], errors="coerce")
for c in ["revenue", "progress_percentage", "rating"]:
    if c in df.columns:
        df[c] = pd.to_numeric(df[c], errors="coerce")

# KPIs
total_students = df["student_id"].nunique()
total_instructors = df["instructor_id"].nunique()
total_courses = df["course_ids"].nunique() if "course_ids" in df.columns else df["coursename"].nunique()
total_enrollments = df["enrollment_id"].nunique()
total_revenue = df["revenue"].sum()
print("\n================ KPIs ================")
print("Total Students:", total_students)
print("Total Instructors:", total_instructors)
print("Total Courses:", total_courses)
print("Total Enrollments:", total_enrollments)
print("Total Revenue:", round(total_revenue, 2))
print("Avg Revenue / Enrollment:", round(df.groupby("enrollment_id")["revenue"].sum().mean(), 2))

# 1) Revenue trend (Monthly)
if "enrollment_date" in df.columns:
    df["enroll_month"] = df["enrollment_date"].dt.to_period("M").astype(str)
    rev_month = (df.groupby("enroll_month")["revenue"].sum().reset_index().sort_values("enroll_month"))
    print("\nRevenue by Month (top 10 rows):\n", rev_month.head(10))
    plt.figure()
    plt.plot(rev_month["enroll_month"], rev_month["revenue"])
    plt.xticks(rotation=90, ha="right")
    plt.xlabel("Month")
    plt.ylabel("Revenue")
    plt.title("Monthly Revenue Trend")
    plt.tight_layout()
    plt.show()

# 2) Completion status distribution
status_counts = df.drop_duplicates("enrollment_id")["completion_status"].value_counts()
print("\nCompletion Status Counts:\n", status_counts)
plt.figure()
plt.bar(status_counts.index.astype(str), status_counts.values)
plt.xlabel("Completion Status")
plt.ylabel("Enrollments")
plt.title("Enrollments by Completion Status")
plt.tight_layout()
plt.show()
# 3) Progress analysis by status
progress_by_status = (df.drop_duplicates("enrollment_id").groupby("completion_status")["progress_percentage"].mean().sort_values(ascending=False))
print("\nAvg Progress by Status:\n", progress_by_status)
plt.figure()
plt.bar(progress_by_status.index.astype(str), progress_by_status.values)
plt.xlabel("Completion Status")
plt.ylabel("Avg Progress %")
plt.title("Average Progress by Completion Status")
plt.tight_layout()
plt.show()
# 4) Payment method analysis
pm = (df.groupby("payment_method")["revenue"].agg(payments_count="count", total_revenue="sum").sort_values("total_revenue", ascending=False))
print("\nPayment Method Summary:\n", pm)
plt.figure()
plt.bar(pm.index.astype(str), pm["total_revenue"].values)
plt.xlabel("Payment Method")
plt.ylabel("Total Revenue")
plt.title("Total Revenue by Payment Method")
plt.tight_layout()
plt.show()

# 5) Top instructors by revenue
top_instructors = (df.groupby(["instructor_id", "instructorname"])["revenue"].sum().reset_index().sort_values("revenue", ascending=False).head(10))
print("\nTop 10 Instructors by Revenue:\n", top_instructors)
plt.figure()
plt.bar(top_instructors["instructorname"], top_instructors["revenue"])
plt.xticks(rotation=45, ha="right")
plt.xlabel("Instructor")
plt.ylabel("Revenue")
plt.title("Top 10 Instructors by Revenue")
plt.tight_layout()
plt.show()

# 6) Course performance (Revenue + Avg Rating)
course_perf = (df.groupby(["course_ids", "coursename"]).agg(total_revenue=("revenue", "sum"),avg_rating=("rating", "mean"),
 enrollments=("enrollment_id", "nunique")).reset_index().sort_values("total_revenue", ascending=False))
print("\nTop 10 Courses by Revenue:\n", course_perf.head(10))

# 7) Segmentation: Student spending buckets
student_spend = (df.groupby(["student_id", "studentname"])["revenue"].sum().reset_index().rename(columns={"revenue": "total_spent"}))
student_spend["spend_segment"] = pd.qcut(student_spend["total_spent"],q=4,labels=["Low", "Mid", "High", "VIP"])
print("\nStudent Spend Segments:\n", student_spend["spend_segment"].value_counts())

