---
title: "hw_submit_wk8"
subtitle: "STAT 412/612 Week 8 Homework"
author: "Yunting"
date: "3/7/2020"
output: pdf_document
---

# Exercise 1: Keys

**key** = a set of variables used to connect a pair of dataframes\

**primary key** = identifies individual rows its own data frame. Give me a value, I can tell the unique row that has that value.\

## 1. Read the description of the babynames dataset with (you might need to install babynames)
```{r}
library(tidyverse)
library(help = "babynames")
```

## What are the data frames in this data set?
Ans: Applicants, Baby names, Births and Lifetables.
```{r}
library(babynames)
head(applicants) #Applicants.
head(babynames) #Baby names.
head(births) # Births
head(lifetables) # Lifetables
```

## What are the keys in each data frame? Demonstrate they are unique.

```{r}
# applicants : the keys are year and sex.
applicants %>%
  group_by(year,sex) %>% 
  count() %>%
  filter(n > 1)

```


```{r}
# babynames: the keys are year, sex, and name.
babynames %>%
  group_by(year, sex, name) %>% 
  count() %>%
  filter(n > 1)

```


```{r}
# babynames: the key is year.
births %>%
  group_by(year) %>%
  count() %>%
  filter(n > 1)
```

```{r}
# lifetables: the keys are x, sex, and year. (qx:ex are not)
lifetables %>%
  group_by(x,sex,year) %>%
  count() %>%
  filter(n > 1)

```


## 2. Read the description of the nasaweather dataset with (you might need to install nasaweather)
```{r}
library(help = "nasaweather")
```
## What are the data frames in this data set? 
Ans:  Atmospheric data, Country borders, Elevation, Glacier locations and Storm tracks data.\
```{r}
library(nasaweather)
head(atmos) #Atmospheric_data.
head(borders) #Country_borders
head(elev) #Elevation.
head(glaciers) #Glacier_locations
head(storms) #Storm_tracks_data

# Test note chunk
if (FALSE){
  Atmospheric_data.
  Country_borders
  Elevation.
  Glacier_locations
  Storm_tracks_data

} 


```
## What are the keys in each data frame?

```{r}
# atmos:the keys are lat, long, year, month
nasaweather::atmos %>%
  count(lat, long, year, month) %>%
  filter(n > 1) %>%
  nrow()
  
```

```{r}
# borders:No key in this data frame
nasaweather::borders %>%
  count(country, long, lat, group) %>%
  filter(n > 1) %>%
  nrow()
```

```{r}
# elev:the keys are long, lat
nasaweather::elev %>% 
  count(long, lat) %>%
  filter(n > 1) %>%
  nrow()

```

```{r}
# glaciers:the key is id
nasaweather::glaciers %>% 
  count(id) %>%
  filter(n > 1) %>%
  nrow()

```

```{r}
# storms:the key is name,year, month, day, hour, lat or
# name,year, month, day, hour, lat and long
# It should have been the listed variables Plus One other variable to differentiate, so it could have been lat, or long or wind, or type but not pressure or seasday. Adding two is not necessary.

nasaweather::storms %>% 
  count(name,year, month, day, hour, lat) %>% 
  filter(n > 1) %>%
  nrow()

```


# Exercise 3: Lahman’s Baseball Dataset
## This exercise concerns the Lahman dataset. You can read about it with:
```{r}
library(tidyverse)
library(Lahman)
help("Lahman-package")
```
## For this exercise, we’ll use the Master, Batting, Pitching, Fielding, Teams, and Salaries data frames.\
## 1. Load these data frames into R and read about them.
```{r}
head(Master)
head(Batting)
head(Pitching)
head(Fielding)
head(Teams)
head(Salaries)
```

## 2. Find all the names of the players who have ever had a stint (from the Fielding data frame) in the Red Sox (or the Boston Americans) in years where they made it to the World Series (so they won their leagues).
• Show the first ten names (arranged in alphabetical order of last name).\
• Note the World Series was not played each year and began in 1903.\

```{r}
Teams %>%
  filter(yearID >= 1903 ) %>%
  filter(LgWin == "Y" & teamID == "BOS") %>%
  filter(!is.na(WSWin)) %>% # WSWin should be Y or No
  select(yearID,lgID,teamID,LgWin,WSWin) -> Boston_League

left_join( Boston_League,Fielding,by = c("yearID", "lgID", "teamID")) %>% 
  left_join(Master, by = "playerID" ) %>%
  filter(stint > 0) %>%
  select(nameFirst, nameLast, yearID) %>%
  arrange(nameLast) %>%
  distinct() %>% #unique() also
  head(10)

  
```

## 3. Some players play on multiple teams each year.
• Construct a data frame containing the total salary for each player for each year.\
• Construct a second data frame containing the total number of at bats and hits for each player in a year.\

```{r}
Lahman::Salaries %>%
  group_by(yearID,playerID) %>%
  summarise(salary_total = sum(salary, na.rm = TRUE)) -> salary_total
  
Lahman::Batting %>%
  group_by(yearID,playerID) %>%
  summarise(total_bats = sum(AB, na.rm = TRUE),
            total_hits = sum(H, na.rm = TRUE)) -> total_bats_and_hits

full_join(salary_total, total_bats_and_hits, by = c("yearID", "playerID")) ->
multiple_teams_each_year

multiple_teams_each_year

```

## 4. The batting average of a player is the number of Hits divided by the number of at bats. A larger value is good.
• Using the data frames you created in part 3, create a new data frame with batting average and
salary information for only players in the years after 1985 (when salary information started being
collected) who had a minimum of 400 at bats.\


```{r}
after_1985 <- multiple_teams_each_year %>%
  mutate(batting_average = (total_hits / total_bats)) %>%
  filter(yearID > 1985 & total_bats >= 400) %>% #including 1985
  select(yearID, playerID, batting_average, salary_total) 

after_1985
```

• Explore the marginal association between a player’s batting average and their salary.\

```{r}
after_1985 %>%
  ggplot(aes(x = batting_average, y = salary_total))+
  geom_point()+
  scale_x_log10()+
  scale_y_log10()+
  ggtitle("Association between a player’s batting average and their salary") +
  geom_smooth(method = "lm", se = FALSE )+
  theme_bw()

```

• Explore if this association has changed over time (for example, because sports teams are getting
more stats-savvy). Hint: figure out how to set the color based on year.\

```{r}
after_1985 %>%
  ggplot(aes(x = batting_average, y = salary_total, color = as.factor(yearID)))+
  scale_y_log10()+
  ggtitle("Association between a player batting average and their salary") +
  geom_smooth(method = "lm", se = FALSE,linetype = "dashed")+
  theme_bw() 
```

Conclusion: The relationship between the batting average and the total salary is positive. On the other hand, when the batting average is increasing, the total salary is increasing, too. (the year of legend is not affected the batting average and total of salary.) Therefore, what happens to totally salary, while batting average is increasing over time. \


## 5. Find the salary of all players named “John” in even numbered years after 1985. Print the first ten values arranged in descending order of salary.
```{r}
Lahman::Master %>%
filter(nameFirst == "John") -> John_bio


left_join(John_bio, Salaries, by = "playerID") %>%
  select(yearID,nameFirst,nameLast,salary) %>%
  arrange(desc(salary)) %>%
  filter(yearID %%2 == 0) %>%
  head(10)

```

