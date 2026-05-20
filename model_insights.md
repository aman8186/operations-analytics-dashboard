# SLA Breach Prediction Model Insights

## Model Used

Random Forest Classifier

## Model Goal

The model predicts whether a support ticket is likely to breach SLA. It helps operations teams identify unresolved tickets that need priority attention.

## Features Used

- Customer segment
- Support channel
- Product area
- Issue type
- Priority
- SLA plan
- Customer sentiment
- Attachment flag
- Platform
- Region
- Ticket created hour

## Model Performance

- Accuracy: 78.36%

## Test Results Summary

The model performed well in identifying tickets that remain within SLA. It was less strong at detecting breached tickets because breached tickets are fewer in the dataset. To make the model more useful for operations, a custom probability threshold was used to classify unresolved tickets into risk levels.

## Unresolved Ticket Risk Distribution

- Low Risk: 31,446
- Medium Risk: 7,402
- High Risk: 1,039

## Business Value

The model helps managers prioritize unresolved tickets with the highest SLA breach risk. This can reduce delays, improve customer satisfaction, reduce escalations, and protect customer trust.
