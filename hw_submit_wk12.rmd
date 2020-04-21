---
title: "STAT 412/612 Week 12: Homework"
subtitle: "forcats and lubridate"
author: "Yunting"
date: "4/12/2020"
output: pdf_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

```{r}
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(lubridate))
```

# Question 1: Capital Bikeshare Data
1. Load in the data containing trip information from the Capital Bikeshare program. Also load in the
station information. Rename variables that have spaces in the names trip data, station data\
Note: These data were originally from <http://data.codefordc.org/group/transportation>.\
```{r}
stations <- read_csv(file = "https://dcgerard.github.io/stat_412_612/data/capital_stations.csv")
head(stations)

trips2016 <- read_csv(file = "https://dcgerard.github.io/stat_412_612/data/capital_trips_2016.csv")

trips2016 %>%
  rename(Duration = "Duration (ms)", Start_date = "Start date",
         End_date = "End date", Start_station_number = "Start station number",
         Start_station = "Start station", End_station_number = "End station number",
         End_station = "End station", Bike_number = "Bike number",
         Member_Type = "Member Type") -> 
  trips2016

head(trips2016)
```

2. Parse the date-time information from the trip data. Recall the times are recorded in the
**America/New_York** time zone, not the **UTC** time zone. Specify that in your parser.\
```{r}
trips2016 %>%
  mutate(Start_date = mdy_hm(Start_date, tz = "America/New_York"), 
         End_date = mdy_hm(End_date, tz = "America/New_York")) -> 
  trips2016

head(trips2016)
```

3. Calculate the average number of trips for each weekday (Sunday, Monday, Tuesday . . . ) given the day has trips. There are several days with no trips.\
• Save the resulting days of week and corresponding average number of trips as a data frame called **sumdf** and print it out.\
```{r}
library(lubridate)
trips2016 %>%
  separate(Start_date, into = c("Start_d", "Start_t"), sep = " ") %>%
  group_by(Start_d)%>%
  summarize(trips = n()) %>%
  mutate(wday = wday(Start_d, label = TRUE)) %>%
  group_by(wday) %>%
  summarize(mean_num_trips = mean(trips)) -> sumdf

print(sumdf)
  
```

```{r}
# Another Method: using yday() 
# mutate(Start_date = yday(Start_date)) %>%
# count(Start_date)
```

4. Reproduce this plot in R:\
```{r}
sumdf %>%
  mutate(wday = ordered(wday, levels= c("Sat", "Fri", "Thu", 
                                        "Wed", "Tue", "Mon", "Sun"))) ->
  sumdf1

  ggplot(sumdf1, aes(x = mean_num_trips, y = wday)) +
  geom_point() +
  theme_bw()+
  xlab("Mean Number of Trips") +
  ylab("Weekday")
```

5. In a stunning show of contempt, the [IEEE Computer Society](https://en.wikipedia.org/wiki/IEEE_Computer_Society) decided to add a new weekday called
“Fooday” with abbreviation “Foo”. Fooday was decided to be the first day of the week (ahead of Sunday).\
On the first Fooday ever, people used Capital Bikeshare in record numbers, yielding 15567 trips. Add Fooday as the first level to the **wday** variable in **sumdf** and add its average number of trips (now 15567 since there has only been one Fooday so far).\
Hint: Create a new data frame that contains the Fooday trips and use **bind_rows()**.\
```{r}
Fooday <- tribble(~wday, ~mean_num_trips,
             ##----/------------
              "Foo", 15567)

# Fooday <- data.frame(wday = "Foo", mean_num_trips = 15567)

wday_vec <- c("Foo","Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" )

Fooday %>%
  mutate(wday = factor(wday, levels = wday_vec)) -> Fooday2

sumdf %>%
  mutate(wday = factor(wday, levels = wday_vec, ordered = FALSE )) -> sumdf2

bind_rows(Fooday2, sumdf2) -> Fooday_trips
print(Fooday_trips)
```

6. In another stunning show of contempt, the [IEEE Computer Society](https://en.wikipedia.org/wiki/IEEE_Computer_Society) decided to change the abbreviations from three letters to two letters. Change the levels of wday so that each day uses only two-letter
abbreviations. Your final data frame should look like this:
```{r}
Fooday_trips %>%
  mutate(wday = str_sub(wday,1,2),
         wday = parse_factor(wday))-> 
  ABBR_Fooday_trips

print(ABBR_Fooday_trips)
```

7. In the **stations** data frame, it seems that **installDate** is populated by the number of milliseconds since January 1, 1970, 00:00:00 (in the **America/New_York** time zone). Parse this into a date-time and make a histogram of the install dates. It should look something like this:\
```{r}
# 1000 milliseconds = 1 seconds
stations <- read_csv(file = "./data/capital_stations.csv")
sample_n(stations,6)

stations %>%
  mutate(oldtime = ymd_hms("1970-01-01 00:00:00", tz = "America/New_York"),
         installDate = (oldtime + dmilliseconds(installDate))) %>%
  
  ggplot(aes(x = installDate)) +
  geom_histogram() +
  theme_bw() +
  xlab("Install Date") +
  ylab("Count")
               


```





