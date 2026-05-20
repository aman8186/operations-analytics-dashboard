import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import OneHotEncoder
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, classification_report, confusion_matrix

cleaned_file_path = r"D:\operations-analytics-dashboard\data\cleaned\support_tickets_cleaned.csv"
model_output_path = r"D:\operations-analytics-dashboard\reports\model_results.txt"

df = pd.read_csv(cleaned_file_path)

# Use only resolved tickets for training
model_df = df[df["sla_status"].isin(["Within SLA", "Breached"])].copy()

# Target column
model_df["is_breached"] = (model_df["sla_status"] == "Breached").astype(int)

# Features available before final resolution
features = [
    "customer_segment",
    "channel",
    "product_area",
    "issue_type",
    "priority",
    "sla_plan",
    "customer_sentiment",
    "has_attachment",
    "platform",
    "region",
    "created_hour"
]

X = model_df[features]
y = model_df["is_breached"]

categorical_features = [
    "customer_segment",
    "channel",
    "product_area",
    "issue_type",
    "priority",
    "sla_plan",
    "customer_sentiment",
    "platform",
    "region"
]

numeric_features = [
    "has_attachment",
    "created_hour"
]

preprocessor = ColumnTransformer(
    transformers=[
        ("cat", OneHotEncoder(handle_unknown="ignore"), categorical_features),
        ("num", "passthrough", numeric_features)
    ]
)

model = RandomForestClassifier(
    n_estimators=100,
    random_state=42,
    class_weight="balanced"
)

pipeline = Pipeline(
    steps=[
        ("preprocessor", preprocessor),
        ("model", model)
    ]
)

X_train, X_test, y_train, y_test = train_test_split(
    X,
    y,
    test_size=0.2,
    random_state=42,
    stratify=y
)

pipeline.fit(X_train, y_train)

y_pred = pipeline.predict(X_test)

accuracy = accuracy_score(y_test, y_pred)
report = classification_report(y_test, y_pred)
matrix = confusion_matrix(y_test, y_pred)

with open(model_output_path, "w") as file:
    file.write("SLA Breach Prediction Model Results\n")
    file.write("===================================\n\n")
    file.write(f"Model: Random Forest Classifier\n")
    file.write(f"Training rows: {len(X_train)}\n")
    file.write(f"Testing rows: {len(X_test)}\n")
    file.write(f"Accuracy: {round(accuracy * 100, 2)}%\n\n")
    file.write("Classification Report\n")
    file.write(report)
    file.write("\nConfusion Matrix\n")
    file.write(str(matrix))

print("Model training completed")
print("Accuracy:", round(accuracy * 100, 2), "%")
print("Model results saved:")
print(model_output_path)
