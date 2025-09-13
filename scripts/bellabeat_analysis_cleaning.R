# March to April Daily Activity Dataset Cleaning

# Load the dataset
daily_activity_1 <- read_csv("F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/raw_datasets/March_12--April_11/dailyActivity_merged.csv")

# Inspect the dataset
View(daily_activity_1)                
head(daily_activity_1)                 
skim_without_charts(daily_activity_1)
colnames(daily_activity_1)            
str(daily_activity_1)       
glimpse(daily_activity_1)           

# Clean the dataset

# 1. Clean column names
daily_activity_1 <- daily_activity_1 %>%
  clean_names()

# 2. Convert activity_date column to proper Date format
daily_activity_1 <- daily_activity_1 %>%
  mutate(activity_date = mdy(activity_date))

# 3. Remove duplicates (if any)
daily_activity_1 <- daily_activity_1 %>%
  distinct()

# 4. Drop irrelevant columns (logged_activities_distance = mostly zero, sedentary_active_distance = always zero)
daily_activity_1 <- daily_activity_1 %>%
  select(-logged_activities_distance, -sedentary_active_distance)

# Data quality check

# 5. Quick integrity check for distance columns
daily_activity_1 %>%
  mutate(check_distance = very_active_distance + 
           moderately_active_distance + 
           light_active_distance) %>%
  summarise(match_rate = mean(abs(check_distance - total_distance) < 0.01))

# 6. Check for missing values
colSums(is.na(daily_activity_1))

# 7. Check unique users
n_distinct(daily_activity_1$id)

# 8. Check date range
range(daily_activity_1$activity_date)

# 9. Outlier detection for steps and calories
daily_activity_1 %>%
  summarise(max_steps = max(total_steps),
            min_steps = min(total_steps),
            max_calories = max(calories),
            min_calories = min(calories))

# Remove unrealistic values (remove rows where steps = 0 and calories = 0)
daily_activity_1 <- daily_activity_1 %>%
  filter(total_steps > 0 & calories > 0)

# Feature engineering (engagement-focused)
daily_activity_1 <- daily_activity_1 %>%
  mutate(
    # Add weekday column
    weekday = weekdays(activity_date),
    
    # Total active minutes across categories
    active_minutes_total = very_active_minutes + fairly_active_minutes + lightly_active_minutes,
    
    # Engagement levels based on total steps
    engagement_level = case_when(
      total_steps < 5000 ~ "Low",
      total_steps < 10000 ~ "Moderate",
      TRUE ~ "High"
    )
  )

# Save cleaned dataset
write_csv(daily_activity_1, 
          "F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/cleaned_datasets/daily_activity_clean_first.csv")

# April to May Daily Activity Dataset Cleaning

# Load the dataset
daily_activity_2 <- read_csv("F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/raw_datasets/April_12--May_12/dailyActivity_merged.csv")

# Inspect the dataset
View(daily_activity_2)                
head(daily_activity_2)                 
skim_without_charts(daily_activity_2)
colnames(daily_activity_2)            
str(daily_activity_2)       
glimpse(daily_activity_2)           

# Clean the dataset

# 1. Clean column names
daily_activity_2 <- daily_activity_2 %>%
  clean_names()

# 2. Convert activity_date column to proper Date format
daily_activity_2 <- daily_activity_2 %>%
  mutate(activity_date = mdy(activity_date))

# 3. Remove duplicates (if any)
daily_activity_2 <- daily_activity_2 %>%
  distinct()

# 4. Drop irrelevant columns (logged_activities_distance = mostly zero, sedentary_active_distance = always zero)
daily_activity_2 <- daily_activity_2 %>%
  select(-logged_activities_distance, -sedentary_active_distance)

# Data quality check

# 5. Quick integrity check for distance columns
daily_activity_2 %>%
  mutate(check_distance = very_active_distance + 
           moderately_active_distance + 
           light_active_distance) %>%
  summarise(match_rate = mean(abs(check_distance - total_distance) < 0.01))

# 6. Check for missing values
colSums(is.na(daily_activity_2))

# 7. Check unique users
n_distinct(daily_activity_2$id)

# 8. Check date range
range(daily_activity_2$activity_date)

# 9. Outlier detection for steps and calories
daily_activity_2 %>%
  summarise(max_steps = max(total_steps),
            min_steps = min(total_steps),
            max_calories = max(calories),
            min_calories = min(calories))

# Remove unrealistic values (remove rows where steps = 0 and calories = 0)
daily_activity_2 <- daily_activity_2 %>%
  filter(total_steps > 0 & calories > 0)

# Feature engineering (engagement-focused)
daily_activity_2 <- daily_activity_2 %>%
  mutate(
    # Add weekday column
    weekday = weekdays(activity_date),
    
    # Total active minutes across categories
    active_minutes_total = very_active_minutes + fairly_active_minutes + lightly_active_minutes,
    
    # Engagement levels based on total steps
    engagement_level = case_when(
      total_steps < 5000 ~ "Low",
      total_steps < 10000 ~ "Moderate",
      TRUE ~ "High"
    )
  )

# Save cleaned dataset
write_csv(daily_activity_2, 
          "F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/cleaned_datasets/daily_activity_clean_second.csv")


# ------------------------
# Merge March–April and April–May Cleaned Daily Activity Datasets
# ------------------------

# Load both cleaned datasets
daily_activity_first <- read_csv("F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/cleaned_datasets/daily_activity_clean_first.csv")
daily_activity_second <- read_csv("F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/cleaned_datasets/daily_activity_clean_second.csv")

# Merge them into one dataframe
daily_activity_all <- bind_rows(daily_activity_first, daily_activity_second)

# Remove duplicates just in case (e.g., if April 12th appears in both files)
daily_activity_all <- daily_activity_all %>%
  distinct()

# Verify merged dataset
nrow(daily_activity_all)  
n_distinct(daily_activity_all$id)  
range(daily_activity_all$activity_date)

# Save final merged dataset
write_csv(daily_activity_all, 
          "F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/cleaned_datasets/daily_activity_clean_all.csv")


# March to April Weight Log Dataset Cleaning

# Load the dataset
weight_log_1 <- read_csv("F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/raw_datasets/March_12--April_11/weightLogInfo_merged.csv")

# Inspect the dataset
View(weight_log_1)
head(weight_log_1)
skim_without_charts(weight_log_1)
colnames(weight_log_1)
str(weight_log_1)
glimpse(weight_log_1)

# Clean the dataset

# 1. Clean column names
weight_log_1 <- weight_log_1 %>%
  clean_names()

# 2. Convert date column to proper Date format
weight_log_1 <- weight_log_1 %>%
  mutate(date = mdy_hms(date))   # keep time since it’s in the data

# 3. Remove duplicates (if any)
weight_log_1 <- weight_log_1 %>%
  distinct()

# 4. Check missing values
colSums(is.na(weight_log_1))

# 5. Outlier detection for Weight and BMI
weight_log_1 %>%
  summarise(max_weight = max(weight_kg, na.rm = TRUE),
            min_weight = min(weight_kg, na.rm = TRUE),
            max_bmi = max(bmi, na.rm = TRUE),
            min_bmi = min(bmi, na.rm = TRUE))

# 6. Remove unrealistic values (filter BMI > 10 & BMI < 60 (reasonable range))
weight_log_1 <- weight_log_1 %>%
  filter(bmi > 10 & bmi < 60)

# ------------------------
# Save cleaned dataset
# ------------------------
write_csv(weight_log_1, 
          "F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/cleaned_datasets/weight_log_clean_first.csv")


# April to May Weight Log Dataset Cleaning

# Load the dataset
weight_log_2 <- read_csv("F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/raw_datasets/April_12--May_12/weightLogInfo_merged.csv")

# Inspect the dataset
View(weight_log_2)
head(weight_log_2)
skim_without_charts(weight_log_2)
colnames(weight_log_2)
str(weight_log_2)
glimpse(weight_log_2)

# Clean the dataset

# 1. Clean column names
weight_log_2 <- weight_log_2 %>%
  clean_names()

# 2. Convert date column to proper Date format
weight_log_2 <- weight_log_2 %>%
  mutate(date = mdy_hms(date))

# 3. Remove duplicates (if any)
weight_log_2 <- weight_log_2 %>%
  distinct()

# 4. Check missing values
colSums(is.na(weight_log_2))

# 5. Outlier detection for Weight and BMI
weight_log_2 %>%
  summarise(max_weight = max(weight_kg, na.rm = TRUE),
            min_weight = min(weight_kg, na.rm = TRUE),
            max_bmi = max(bmi, na.rm = TRUE),
            min_bmi = min(bmi, na.rm = TRUE))

# 6. Remove unrealistic values (optional: filter BMI > 10 & BMI < 60)
weight_log_2 <- weight_log_2 %>%
  filter(bmi > 10 & bmi < 60)

# ------------------------
# Save cleaned dataset
# ------------------------
write_csv(weight_log_2,
          "F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/cleaned_datasets/weight_log_clean_second.csv")

# Merge March–April and April–May cleaned weight logs

# Load both cleaned files
weight_log_1 <- read_csv("F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/cleaned_datasets/weight_log_clean_first.csv")
weight_log_2 <- read_csv("F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/cleaned_datasets/weight_log_clean_second.csv")

# Merge datasets
weight_log_final <- bind_rows(weight_log_1, weight_log_2)

# Remove duplicates after merging
weight_log_final <- weight_log_final %>%
  distinct()

# Check date range
range(weight_log_final$date)

# Check unique users
n_distinct(weight_log_final$id)

# ------------------------
# Save merged cleaned dataset
# ------------------------
write_csv(weight_log_final, 
          "F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/cleaned_datasets/weight_log_clean_final.csv")

# ---------------------------------------
# March to April Heart Rate Log Cleaning
# ---------------------------------------

# Load the dataset
heart_rate_1 <- read_csv("F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/raw_datasets/March_12--April_11/heartrate_seconds_merged.csv")

# Inspect the dataset
View(heart_rate_1)
head(heart_rate_1)
skim_without_charts(heart_rate_1)
glimpse(heart_rate_1)

# Clean the dataset
heart_rate_1 <- heart_rate_1 %>%
  clean_names() %>%                                   
  mutate(time = mdy_hms(time)) %>%                    
  distinct()                              

# Check missing values
colSums(is.na(heart_rate_1))

# Outlier detection (check min & max heart rate)
heart_rate_1 %>%
  summarise(min_hr = min(value, na.rm = TRUE),
            max_hr = max(value, na.rm = TRUE))

# Filter unrealistic HR values (keep only 40–220 bpm as physiological range)
heart_rate_1 <- heart_rate_1 %>%
  filter(value >= 40 & value <= 220)

# Save cleaned dataset
write_csv(heart_rate_1,
          "F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/cleaned_datasets/heart_rate_clean_first.csv")

# ---------------------------------------
# April to May Heart Rate Log Cleaning
# ---------------------------------------

# Load the dataset
heart_rate_2 <- read_csv("F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/raw_datasets/April_12--May_12/heartrate_seconds_merged.csv")

# Inspect the dataset
View(heart_rate_2)
head(heart_rate_2)
skim_without_charts(heart_rate_2)
glimpse(heart_rate_2)

# Clean the dataset
heart_rate_2 <- heart_rate_2 %>%
  clean_names() %>%                                  
  mutate(time = mdy_hms(time)) %>%                    
  distinct()                                       

# Check missing values
colSums(is.na(heart_rate_2))

# Outlier detection (check min & max heart rate)
heart_rate_2 %>%
  summarise(min_hr = min(value, na.rm = TRUE),
            max_hr = max(value, na.rm = TRUE))

# Optional: filter unrealistic HR values (keep only 40–220 bpm)
heart_rate_2 <- heart_rate_2 %>%
  filter(value >= 40 & value <= 220)

# Save cleaned dataset
write_csv(heart_rate_2,
          "F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/cleaned_datasets/heart_rate_clean_second.csv")

# ------------------------------
# Merge Cleaned Heart Rate Files
# ------------------------------

# Load both cleaned datasets
heart_rate_1 <- read_csv("F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/cleaned_datasets/heart_rate_clean_first.csv")
heart_rate_2 <- read_csv("F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/cleaned_datasets/heart_rate_clean_second.csv")

# Merge datasets
heart_rate_final <- bind_rows(heart_rate_1, heart_rate_2)

# Remove duplicates after merge
heart_rate_final <- heart_rate_final %>% distinct()

# Save merged dataset
write_csv(heart_rate_final,
          "F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/cleaned_datasets/heart_rate_clean_final.csv")

# ------------------------------
# Sleep Day Dataset Cleaning
# ------------------------------

# 1. Load the dataset
sleep_day <- read_csv("F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/raw_datasets/April_12--May_12/sleepDay_merged.csv")

# 2. Inspect the dataset
View(sleep_day)
head(sleep_day)
skim_without_charts(sleep_day)
colnames(sleep_day)
str(sleep_day)
glimpse(sleep_day)

# 3. Clean column names
sleep_day <- sleep_day %>%
  clean_names()

# 4. Convert date column to proper Date format
sleep_day <- sleep_day %>%
  mutate(sleep_day = mdy_hms(sleep_day))

# 5. Remove duplicates
sleep_day <- sleep_day %>%
  distinct()

# 6. Handle unrealistic values and consistency checks
sleep_day <- sleep_day %>%
  filter(
    total_minutes_asleep >= 120 & total_minutes_asleep <= 960,    # 2–16 hours reasonable range
    total_time_in_bed >= 120 & total_time_in_bed <= 1100,         # 2–18 hours reasonable in-bed range
    total_minutes_asleep <= total_time_in_bed                     # asleep cannot exceed time in bed
  )

# 7. Feature engineering for engagement analysis
sleep_day <- sleep_day %>%
  mutate(
    # Sleep efficiency percentage
    sleep_efficiency = round((total_minutes_asleep / total_time_in_bed) * 100, 1),
    
    # Awake/restless minutes
    awake_minutes = total_time_in_bed - total_minutes_asleep,
    
    # Weekday for behavior patterns
    weekday = weekdays(sleep_day)
  )

# 8. Save cleaned dataset
write_csv(sleep_day,
          "F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/cleaned_datasets/sleep_day_clean.csv")

# =======================================================
# Bellabeat Case Study - Analysis Phase
# =======================================================

# =======================================================
# 1. Import Cleaned Datasets
# =======================================================
daily_activity <- read_csv("F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/cleaned_and_merged_datasets/daily_activity_clean_final.csv")
weight_log     <- read_csv("F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/cleaned_and_merged_datasets/weight_log_clean_final.csv")
heart_rate     <- read_csv("F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/cleaned_and_merged_datasets/heart_rate_clean_final.csv")
sleep_day      <- read_csv("F:/Google_Data_Analysis/case_studies/case_study_2/case_study_2_datasets/cleaned_and_merged_datasets/sleep_day_clean.csv")

# =======================================================
# 2. Daily Activity Analysis (Engagement Patterns)
# =======================================================
engagement_summary <- daily_activity %>%
  group_by(engagement_level) %>%
  summarize(
    avg_steps = mean(total_steps, na.rm = TRUE),
    avg_active_minutes = mean(active_minutes_total, na.rm = TRUE),
    avg_calories = mean(calories, na.rm = TRUE),
    avg_sedentary = mean(sedentary_minutes, na.rm = TRUE),
    user_count = n_distinct(id),
    .groups = "drop"
  )

steps_calories_corr <- cor(daily_activity$total_steps,
                           daily_activity$calories,
                           use = "complete.obs")

sedentary_trend <- daily_activity %>%
  group_by(weekday) %>%
  summarize(avg_sedentary = mean(sedentary_minutes, na.rm = TRUE), .groups = "drop")

# Quick diagnostic scatter (exploration only)
ggplot(daily_activity, aes(x = total_steps, y = calories)) +
  geom_point(alpha = 0.5) +
  labs(title = "Diagnostic: Steps vs Calories (Exploration)")

# =======================================================
# 3. Sleep Data Analysis (Wellness & Lifestyle Habits)
# =======================================================
sleep_summary <- sleep_day %>%
  summarize(
    avg_sleep_hours = mean(total_minutes_asleep, na.rm = TRUE) / 60,
    avg_efficiency  = mean(sleep_efficiency, na.rm = TRUE),
    min_efficiency  = min(sleep_efficiency, na.rm = TRUE),
    max_efficiency  = max(sleep_efficiency, na.rm = TRUE)
  )

sleep_weekday <- sleep_day %>%
  group_by(weekday) %>%
  summarize(
    avg_sleep_hours = mean(total_minutes_asleep, na.rm = TRUE) / 60,
    avg_eff         = mean(sleep_efficiency, na.rm = TRUE),
    .groups = "drop"
  )

sleep_correlation <- cor(sleep_day$total_time_in_bed,
                         sleep_day$total_minutes_asleep,
                         use = "complete.obs")

# =======================================================
# 4. Weight Log Analysis (Health-conscious Segments)
# =======================================================
bmi_summary <- weight_log %>%
  summarize(
    avg_bmi = mean(bmi, na.rm = TRUE),
    max_bmi = max(bmi, na.rm = TRUE),
    min_bmi = min(bmi, na.rm = TRUE)
  )

manual_logs <- weight_log %>%
  count(is_manual_report) %>%
  mutate(perc = n / sum(n) * 100)

# =======================================================
# 5. Heart Rate Analysis (Stress & Activity)
# =======================================================
heart_rate_daily <- heart_rate %>%
  mutate(date = as.Date(time)) %>%
  group_by(id, date) %>%
  summarize(
    avg_hr = mean(value, na.rm = TRUE),
    max_hr = max(value, na.rm = TRUE),
    min_hr = min(value, na.rm = TRUE),
    .groups = "drop"
  )

hr_summary <- heart_rate_daily %>%
  summarize(
    overall_avg_hr = mean(avg_hr, na.rm = TRUE),
    resting_min    = min(min_hr, na.rm = TRUE),
    resting_max    = max(max_hr, na.rm = TRUE)
  )

# =======================================================
# 6. Cross-Dataset Insights (Marketing Value)
# =======================================================
safe_cor <- function(x, y) {
  if (sum(complete.cases(x, y)) > 1) {
    return(cor(x, y, use = "complete.obs"))
  } else {
    return(NA)
  }
}

activity_sleep <- daily_activity %>%
  left_join(sleep_day, by = c("id" = "id", "activity_date" = "sleep_day"))

cor_steps_sleep <- safe_cor(activity_sleep$total_steps, activity_sleep$total_minutes_asleep)

activity_weight <- daily_activity %>%
  left_join(weight_log, by = c("id" = "id", "activity_date" = "date"))

cor_calories_bmi <- safe_cor(activity_weight$calories, activity_weight$bmi)

activity_hr <- daily_activity %>%
  left_join(heart_rate_daily, by = c("id" = "id", "activity_date" = "date"))

cor_activity_hr <- safe_cor(activity_hr$total_steps, activity_hr$avg_hr)

# =======================================================
# 7. Print Key Results
# =======================================================
cat("---- Daily Activity Summary ----\n")
print(engagement_summary)
cat("Steps vs Calories Correlation:", round(steps_calories_corr, 3), "\n")
print(sedentary_trend)

cat("\n---- Sleep Summary ----\n")
print(sleep_summary)
print(sleep_weekday)
cat("Sleep correlation (time in bed vs asleep):", round(sleep_correlation, 3), "\n")

cat("\n---- Weight Log Summary ----\n")
print(bmi_summary)
print(manual_logs)

cat("\n---- Heart Rate Summary ----\n")
print(hr_summary)

cat("\n---- Cross Dataset Correlations ----\n")
cat("Activity vs Sleep correlation:", round(cor_steps_sleep, 3), "\n")
cat("Calories vs BMI correlation:", round(cor_calories_bmi, 3), "\n")
cat("Steps vs Avg HR correlation:", round(cor_activity_hr, 3), "\n")

# =======================================================
# Custom Visualization Theme (unchanged)
# =======================================================
custom_theme <- theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 16, hjust = 0.5), 
    plot.subtitle = element_text(size = 12, hjust = 0.5, margin = margin(b = 10)), 
    axis.title.x = element_text(face = "bold", size = 13, margin = margin(t = 10)),
    axis.title.y = element_text(face = "bold", size = 13, margin = margin(r = 10)),
    axis.text = element_text(size = 11),
    panel.grid.major = element_line(color = "grey85"),
    panel.grid.minor = element_blank()
  )

# Helper: order weekdays Monday → Sunday
order_weekdays <- function(df, colname) {
  weekday_levels <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
  df %>%
    mutate("{colname}" := factor(.data[[colname]], levels = weekday_levels))
}

# =======================================================
# 1. Engagement Insights: Activity & Calories
# =======================================================
ggplot(daily_activity, aes(x = total_steps, y = calories)) +
  geom_point(alpha = 0.5, color = "blue") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  annotate("text", x = 34000, y = 4000, label = "More steps → more calories consumed", 
           color = "black", size = 5, hjust = 1, fontface = "bold", angle = 30) +
  labs(
    title = "Steps vs Calories Burned",
    subtitle = "Clear link: active users burn more calories",
    x = "Total Steps",
    y = "Calories Burned"
  ) +
  custom_theme

# =======================================================
# 2. Sedentary Patterns by Weekday
# =======================================================
sedentary_trend <- daily_activity %>%
  group_by(weekday) %>%
  summarize(avg_sedentary = mean(sedentary_minutes, na.rm = TRUE), .groups = "drop") %>%
  order_weekdays("weekday")

ggplot(sedentary_trend, aes(x = weekday, y = avg_sedentary, group = 1)) +
  geom_line(color = "purple", linewidth = 1.2) +
  geom_point(size = 3, color = "purple") +
  annotate("text", x = 1.3, y = max(sedentary_trend$avg_sedentary), 
           label = "Highest on Monday", color = "black", size = 4, vjust = -0.1, fontface = "bold") +
  annotate("text", x = 4.9, y = max(sedentary_trend$avg_sedentary) * 0.95, 
           label = "Rise again at Friday", color = "black", size = 4, vjust = -1,, fontface = "bold", angle = 65) +
  labs(
    title = "Sedentary Behavior by Weekday",
    subtitle = "Sedentary peaks at week start & end",
    x = "Weekday",
    y = "Average Sedentary Minutes"
  ) +
  custom_theme

# =======================================================
# 3. Sleep Insights: Sleep Duration
# =======================================================
sleep_weekday <- sleep_day %>%
  group_by(weekday) %>%
  summarize(
    avg_sleep_hours = mean(total_minutes_asleep, na.rm = TRUE) / 60,
    avg_eff = mean(sleep_efficiency, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  order_weekdays("weekday")

ggplot(sleep_weekday, aes(x = weekday, y = avg_sleep_hours, fill = weekday)) +
  geom_col(show.legend = FALSE) +
  labs(
    title = "Average Sleep Hours by Weekday",
    subtitle = "Users sleep less on weekdays",
    x = "Weekday",
    y = "Average Sleep Hours"
  ) +
  custom_theme

# =======================================================
# 4. Weight & BMI Insights
# =======================================================
ggplot(weight_log, aes(x = bmi)) +
  geom_histogram(binwidth = 1, fill = "green", color = "black") +
  annotate("text", 
           x = 28, y = 45, 
           label = "Peak around BMI 23 → Healthy range", 
           color = "black", size = 4, fontface = "bold", hjust = 0.5) +
  labs(
    title = "BMI Distribution of Users",
    subtitle = "Most users fall in the healthy BMI range (18.5–24.9)",
    x = "BMI",
    y = "Number of Users"
  ) +
  custom_theme


# =======================================================
# 5. Heart Rate Insights
# =======================================================
ggplot(heart_rate_daily, aes(x = avg_hr)) +
  geom_histogram(binwidth = 2, fill = "orange", color = "black") +
  labs(
    title = "Distribution of Average Daily Heart Rate",
    subtitle = "Majority fall in healthy range",
    x = "Average Heart Rate (bpm)",
    y = "Number of Users"
  ) +
  custom_theme

# =======================================================
# 6. Cross-Dataset Insights: Steps vs Sleep
# =======================================================
ggplot(activity_sleep, aes(x = total_steps, y = total_minutes_asleep)) +
  geom_point(alpha = 0.5, color = "darkblue") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  annotate(
    "text", x = 29000, y = 700, 
    label = "More steps ≠ longer sleep", 
    color = "black", size = 5, hjust = 1, fontface = "bold"
  ) +
  labs(
    title = "Steps vs Sleep Duration",
    subtitle = "Being more active doesn’t guarantee more rest",
    x = "Total Steps",
    y = "Minutes Asleep"
  ) +
  custom_theme



