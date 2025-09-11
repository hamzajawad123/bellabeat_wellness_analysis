# Bellabeat Wellness Analysis  

## Overview  
This project is part of the **Google Data Analytics Professional Certificate Capstone**.  

The objective is to analyze **Bellabeat’s wellness data** to understand user patterns in activity, sleep, weight, and heart rate. These insights are then used to recommend strategies that can enhance user engagement and support Bellabeat’s growth as a holistic wellness brand.  

---

## Business Task  
Design **data-driven product and marketing strategies** to increase user engagement by:  
- Identifying behavioral patterns in activity, sleep, and health metrics.  
- Understanding differences between highly active and less active users.  
- Supporting recommendations with visual evidence and measurable insights.  

---

## Datasets  
The analysis uses **publicly available Fitbit wellness tracker data** from a sample of Bellabeat users.  

- [Daily Activity Dataset](./datasets/daily_activity.csv)  
- [Sleep Dataset](./datasets/sleep_day.csv)  
- [Weight Log Dataset](./datasets/weight_log.csv)  
- [Heart Rate Dataset](./datasets/heart_rate_daily.csv)  

> Note: Data has been cleaned, merged, and anonymized before analysis.  

---

## Process  
The analysis followed the **six-step data analysis framework**:  

1. **Ask** – Define the problem: “How do Bellabeat users engage with their wellness data across activity, sleep, and health?”  
2. **Prepare** – Collect and merge daily activity, sleep, weight, and heart rate datasets.  
3. **Process** – Clean data (remove duplicates, fix missing values, standardize formats).  
4. **Analyze** – Explore trends in steps, calories, sleep duration, BMI, and heart rate.  
5. **Share** – Create clear visualizations and summaries to communicate patterns.  
6. **Act** – Suggest strategies to improve user engagement and product positioning.  

---

## Key Insights  
- **Activity**: Highly active users walk ~13,000 steps daily vs. ~2,500 for less active users. More steps strongly correlate with more calories burned (r = 0.56).  
- **Sedentary Patterns**: Sitting time is highest on Mondays and Fridays, and lowest on Tuesdays, showing clear weekday effects.  
- **Sleep**: Average sleep is 7.2 hours with high quality (91% efficiency). Users sleep more on weekends and less on workdays.  
- **Weight & BMI**: Average BMI is 25.4 (borderline healthy). About 64% of users log weight manually, showing proactive health tracking.  
- **Heart Rate**: Average daily heart rate is 79 bpm. Ranges show both casual and fitness-focused users.  
- **Activity vs Sleep**: Slight negative correlation (r = -0.28) — more activity does not always mean more sleep.  

---

## Tech Stack  
![R](https://img.shields.io/badge/-R-blue?logo=r&logoColor=white)  
![Excel](https://img.shields.io/badge/-Excel-green?logo=microsoft-excel&logoColor=white)  
![PowerPoint](https://img.shields.io/badge/-PowerPoint-orange?logo=microsoft-powerpoint&logoColor=white)  

---

## Deliverables  
- [Case Study Report (PDF)](./deliverables/Bellabeat_Wellness_Analysis_Report.pdf)  
- [PowerPoint Presentation](./deliverables/Bellabeat_Wellness_Analysis_Presentation.pptx)  
- [Data Cleaning Script (R)](./scripts/data_cleaning.R)  
- [Exploratory Data Analysis (R)](./scripts/eda_analysis.R)  

---

## Sample Visualizations  

Here are a few key visualizations generated during the analysis:  

**Visualization 1: Steps vs Calories Burned**  
Shows a positive trend — more steps lead to more calories burned.  
![Steps vs Calories](./visuals/steps_vs_calories.png)  

---

**Visualization 2: Sedentary Time by Weekday**  
Highlights peaks in sitting behavior on Mondays and Fridays.  
![Sedentary Time](./visuals/sedentary_by_weekday.png)  

---

**Visualization 3: Average Sleep Hours by Weekday**  
Shows lower sleep on weekdays and higher sleep on weekends.  
![Sleep Hours](./visuals/sleep_by_weekday.png)  

---

**Visualization 4: BMI Distribution of Users**  
Reveals most users are in a moderate BMI range (~25).  
![BMI Distribution](./visuals/bmi_distribution.png)  

---

## Recommendations  
1. Launch **weekday activity challenges** to counter high sedentary time.  
2. Promote **Bellabeat as a sleep and stress management guide** alongside activity tracking.  
3. Introduce **auto-weight logging features** to reduce manual effort.  
4. Position Bellabeat as a **holistic wellness brand** focusing on activity, sleep, heart, and weight tracking.  

---

## About This Project  
This case study demonstrates **real-world data analytics skills** including:  
- Data cleaning and wrangling  
- Exploratory and statistical analysis  
- Data visualization  
- Business storytelling  
- Actionable recommendations  

---

## Acknowledgements  
- Data adapted from **Fitbit wellness tracker datasets** shared under public use.  
- Case study inspired by the **Google Data Analytics Professional Certificate**.  

---
