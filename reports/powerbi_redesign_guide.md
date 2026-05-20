# Power BI Redesign Guide

Use this as the visual reference for redesigning the dashboard in the AdventureWorks-style layout.

## Global Style

- Page background: `#F4F6F8`
- Left navigation bar: `#111827`
- Accent teal: `#14B8A6`
- Main blue: `#2563EB`
- Warning orange: `#F97316`
- Breach red: `#EF4444`
- Success green: `#10B981`
- Card background: white
- Text: `#111827`
- Secondary text: `#6B7280`

## Page Structure

Every page should use the same structure:

1. Dark left navigation bar
2. Page title at top-left of content area
3. KPI cards below title
4. Main visuals in a clean 2-column or 3-column layout
5. Minimal borders, light shadow, consistent spacing

## Page 1: Executive Overview

Cards:
- Total Tickets
- Within SLA Tickets
- Breached Tickets
- Not Resolved Tickets
- Average Resolution Hours
- Average CSAT
- Reopen Rate
- SLA Breach Rate

Visuals:
- Monthly Ticket Volume
- Tickets by Product Area
- Tickets by Channel

## Page 2: SLA Performance

Cards:
- SLA Breach Rate
- Within SLA Tickets
- Breached Tickets
- Average Resolution Hours

Visuals:
- SLA Status Distribution
- SLA Breach Rate by Product Area
- SLA Status by Priority
- Average Resolution Hours by Priority

## Page 3: Customer Experience

Cards:
- Average CSAT
- Reopen Rate
- Total Tickets

Visuals:
- Average CSAT by Sentiment
- Average CSAT by Region
- Reopen Rate by Channel
- Tickets by Customer Segment

## Page 4: Risk Prediction Queue

Cards:
- Total Predicted Tickets
- High Risk Tickets
- Medium Risk Tickets
- Low Risk Tickets
- Average Breach Risk Probability

Visuals:
- Risk Level Distribution
- High Risk Tickets by Product Area
- High Risk Ticket Queue table

## Power BI Tips

- Use simple Card visuals, not KPI visuals.
- Turn on visual title for every chart.
- Keep all cards the same size on each page.
- Use the same color meaning everywhere: red/orange for breach/risk, teal/green for good, blue for neutral volume.
- Remove unnecessary chart gridlines when the visual becomes cluttered.
- Use exact numbers on cards if possible: Display units = None.
