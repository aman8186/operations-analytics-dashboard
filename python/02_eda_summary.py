import pandas as pd

cleaned_file_path = r"D:\operations-analytics-dashboard\data\cleaned\support_tickets_cleaned.csv"
eda_output_path = r"D:\operations-analytics-dashboard\reports\python_eda_summary.txt"

df = pd.read_csv(cleaned_file_path)

with open(eda_output_path, "w") as file:
    file.write("Python EDA Summary\n")
    file.write("==================\n\n")

    file.write("Dataset Shape\n")
    file.write(str(df.shape) + "\n\n")

    file.write("Main KPIs\n")
    file.write(f"Total tickets: {len(df)}\n")
    file.write(f"Within SLA: {(df['sla_status'] == 'Within SLA').sum()}\n")
    file.write(f"Breached: {(df['sla_status'] == 'Breached').sum()}\n")
    file.write(f"Not Resolved: {(df['sla_status'] == 'Not Resolved').sum()}\n")
    file.write(f"SLA Breach Rate: {round((df['sla_status'] == 'Breached').mean() * 100, 2)}%\n")
    file.write(f"Average Resolution Hours: {round(df['resolution_time_hours'].mean(), 2)}\n")
    file.write(f"Average CSAT: {round(df['csat_score'].mean(), 2)}\n")
    file.write(f"Reopen Rate: {round(df['reopened'].mean() * 100, 2)}%\n\n")

    file.write("SLA Status Distribution\n")
    file.write(df["sla_status"].value_counts().to_string())
    file.write("\n\n")

    file.write("Tickets by Product Area\n")
    file.write(df["product_area"].value_counts().to_string())
    file.write("\n\n")

    file.write("Tickets by Channel\n")
    file.write(df["channel"].value_counts().to_string())
    file.write("\n\n")

    file.write("Average Resolution Time by Priority\n")
    file.write(df.groupby("priority")["resolution_time_hours"].mean().round(2).sort_values(ascending=False).to_string())
    file.write("\n\n")

    file.write("Average CSAT by Sentiment\n")
    file.write(df.groupby("customer_sentiment")["csat_score"].mean().round(2).sort_values().to_string())
    file.write("\n\n")

    file.write("SLA Breach Rate by Product Area\n")
    breach_by_product = (
        df.assign(is_breached=(df["sla_status"] == "Breached").astype(int))
        .groupby("product_area")["is_breached"]
        .mean()
        .mul(100)
        .round(2)
        .sort_values(ascending=False)
    )
    file.write(breach_by_product.to_string())
    file.write("\n")

print("EDA summary saved successfully:")
print(eda_output_path)
