import pandas as pd
import numpy as np

# File paths
raw_file_path = r"D:\operations-analytics-dashboard\data\raw\synthetic_it_support_tickets.csv"
cleaned_file_path = r"D:\operations-analytics-dashboard\data\cleaned\support_tickets_cleaned.csv"

# Load dataset
df = pd.read_csv(raw_file_path, keep_default_na=False)

print("Dataset loaded successfully")
print("Original shape:", df.shape)

# Convert created_at to datetime
df["created_at"] = pd.to_datetime(df["created_at"])

# Convert blank resolution time to NaN, then numeric
df["resolution_time_hours"] = df["resolution_time_hours"].replace("", np.nan)
df["resolution_time_hours"] = pd.to_numeric(df["resolution_time_hours"], errors="coerce")

# Create date columns for analysis and Power BI
df["created_date"] = df["created_at"].dt.date
df["created_year"] = df["created_at"].dt.year
df["created_month"] = df["created_at"].dt.month
df["created_month_name"] = df["created_at"].dt.month_name()
df["created_year_month"] = df["created_at"].dt.to_period("M").astype(str)
df["created_hour"] = df["created_at"].dt.hour
df["created_day_name"] = df["created_at"].dt.day_name()

# SLA target logic
def get_sla_target(row):
    sla_plan = row["sla_plan"]
    priority = row["priority"]

    if sla_plan == "platinum" and priority == "urgent":
        return 4
    elif sla_plan == "platinum" and priority == "high":
        return 8
    elif sla_plan == "platinum" and priority == "medium":
        return 24
    elif sla_plan == "platinum" and priority == "low":
        return 48

    elif sla_plan == "gold" and priority == "urgent":
        return 8
    elif sla_plan == "gold" and priority == "high":
        return 16
    elif sla_plan == "gold" and priority == "medium":
        return 36
    elif sla_plan == "gold" and priority == "low":
        return 72

    elif sla_plan == "standard" and priority == "urgent":
        return 12
    elif sla_plan == "standard" and priority == "high":
        return 24
    elif sla_plan == "standard" and priority == "medium":
        return 48
    elif sla_plan == "standard" and priority == "low":
        return 96

    else:
        return 72

df["sla_target_hours"] = df.apply(get_sla_target, axis=1)

# SLA status logic
df["sla_status"] = np.where(
    df["resolution_time_hours"].isna(),
    "Not Resolved",
    np.where(
        df["resolution_time_hours"] > df["sla_target_hours"],
        "Breached",
        "Within SLA"
    )
)

# Basic checks
print("\nCleaned shape:", df.shape)

print("\nSLA Status Counts:")
print(df["sla_status"].value_counts())

print("\nMain KPIs:")
print("Total tickets:", len(df))
print("Within SLA:", (df["sla_status"] == "Within SLA").sum())
print("Breached:", (df["sla_status"] == "Breached").sum())
print("Not Resolved:", (df["sla_status"] == "Not Resolved").sum())
print("Average resolution hours:", round(df["resolution_time_hours"].mean(), 2))
print("Average CSAT:", round(df["csat_score"].mean(), 2))
print("Reopen rate:", round(df["reopened"].mean() * 100, 2), "%")

# Export cleaned data
df.to_csv(cleaned_file_path, index=False)

print("\nCleaned file saved successfully:")
print(cleaned_file_path)
