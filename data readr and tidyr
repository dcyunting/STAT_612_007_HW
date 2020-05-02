---
title: "STAT 612 Week 7 Homework_Messy "
subtitle: "Data readr and tidyr"
author: "Yunting"
date: "2/29/2020"
output: pdf_document
---
```{r}
suppressMessages(library(tidyverse)) 
```

# Exercises
## 1. Baltimore City Crime Data:
### a. Import the data from https://dcgerard.github.io/stat_412_612/data/BPD_Part_1_Victim_Based_Crime_Data.zip.
```{r}
Baltimore_crime <- read_csv(file = "./data/BPD_Part_1_Victim_Based_Crime_Data.csv")
head(Baltimore_crime)

```

### b. Convert the given dates and times to date classes. For CrimeTime, not all of the rows conform to the “HH:MM:SS” format. I’ll give you a point extra credit if you successfuly demonstrate you fixed all of those locations.

```{r}
# cauculate the length of CrimeTime with each type.
Baltimore_crime %>%
  select(CrimeTime) %>%
  mutate(length_crimeTime = str_length(CrimeTime)) %>%
  #str_length: calculate the length of number length
  group_by(length_crimeTime) %>%
  summarise(count = length(length_crimeTime))
```

```{r}
# select the CrimeTime of each row looks like
Baltimore_crime %>%
   filter(str_length(CrimeTime) == 7 ) 

  
  
```

```{r}
# Let's do it!!

table_2 <- Baltimore_crime %>%
  filter(str_length(CrimeTime) == 2) %>%
  mutate(CrimeTime = parse_time(CrimeTime, format = "%H"))
         #%H default all zero after Hours

table_3 <- Baltimore_crime %>%
  filter(str_length(CrimeTime) == 3) %>%
  mutate(CrimeTime = paste("0",CrimeTime, sep=""), 
#sep: combined two kinds of stuff with "", can put anything inside to be a glue
         CrimeTime = parse_time(CrimeTime, format = "%H%M" )) 

table_4 <- Baltimore_crime %>%
  filter(str_length(CrimeTime) == 4) %>%
  mutate(CrimeTime = recode(CrimeTime, "2400" = "0000"),
  # or: mutate(CrimeTime = if_else(CrimeTime == "2400" , "0000", CrimeTime ),
    CrimeTime = parse_time(CrimeTime, format = "%H%M"))

table_5 <- Baltimore_crime %>%
  filter(str_length(CrimeTime) == 5) %>%
  mutate(CrimeTime = if_else(str_detect(CrimeTime, ":"),
                             CrimeTime, 
                             as.character(parse_number(CrimeTime))) ,
         CrimeTime =  if_else(str_detect(CrimeTime, ":"),
                             CrimeTime, 
                             str_c(str_sub(CrimeTime,1,2),
                                   str_sub(CrimeTime,3,), sep = ":")),
         CrimeTime = parse_time(CrimeTime, format = "%H:%M"))

table_7 <- Baltimore_crime %>%
  filter(str_length(CrimeTime) == 7) %>%
 mutate(CrimeTime = parse_time(CrimeTime, format = "%H:%M:%S")) 

table_8 <- Baltimore_crime %>%
  filter(str_length(CrimeTime) == 8) %>%
  mutate(CrimeTime = parse_time(CrimeTime, format = "%H:%M:%S" )) 

table_10 <- Baltimore_crime %>%
  filter(str_length(CrimeTime) == 10) %>%
  mutate(CrimeTime = str_sub("0149 01:49",5), 
         # or str_sub("0149 01:49",5,10)
    CrimeTime = parse_time(CrimeTime, format = "%H:%M" )) 
    #%H:%M default all zero after Minutes

table_NA <- Baltimore_crime %>%
  filter(is.na(CrimeTime)) %>%
  mutate(CrimeTime = parse_time(CrimeTime, format = "%H:%M:%S" ))

Baltimore_crime_data_exhausted <- table_2 %>%
  full_join(table_3) %>%
  full_join(table_4) %>%
  full_join(table_5) %>%
  full_join(table_7) %>%
  full_join(table_8) %>%
  full_join(table_10) %>%
  full_join(table_NA)


# or: rbind(table_2,table_3,table_4,table_5,
# table_7,table_8,table_10,table_NA)
# use full_join needs to have same format, including "table_NA"

Baltimore_crime_data_exhausted


```

```{r}
#Test area
#Baltimore_crime %>%
#filter(str_length(CrimeTime) == 4, CrimeTime == "2400")  %>%
#mutate(CrimeTime = if_else(CrimeTime == "2400" , "0000", CrimeTime ))
```


### If you cannot figure it out, remove those rows where the parsing failed.
###c.Make Location 1 into two columns LocationLat and LocationLon
```{r}
Baltimore_crime_data_exhausted  %>%
 separate("Location 1", into = c("LocationLat", "LocationLon"), sep = ",") %>%
  mutate(LocationLat = parse_number(LocationLat), 
         LocationLon = parse_number(LocationLon)) %>%
  head()

```

### d. Determine the % of crimes committed between midnight and 4:00 am.

```{r}
Midnight_to_4 <- Baltimore_crime_data_exhausted %>%
  filter(CrimeTime >= parse_time("00:00:00", format = "%H:%M:%S") &
         CrimeTime <= parse_time("04:00:00", format = "%H:%M:%S"))
  
percentage_of_midnight <- (nrow(Midnight_to_4)/ 
                             nrow(Baltimore_crime_data_exhausted))*100
percentage_of_midnight

```

## 2. Import the billboard dataset (posted as a .csv on Blackboard) and tidy it up. The values in column *wkx* are a song’s ranking after x weeks of being released.
```{r}
billboard <- read_csv(file = "./data/billboard.csv")
head(billboard)
```

### a. Convert all the week columns into a row for each week for each song (where there is an entry). You should wind up with 5,307 rows
```{r}
billboard %>%
 pivot_longer(cols = starts_with("wk"), 
    names_to = "week", 
    values_to = "ranking",
    values_drop_na = TRUE ,
    names_prefix = "wk"
  ) 

```

### b. Figure out the dates corresponding to each week on the chart
```{r}
billboard_revised <- billboard %>%
 pivot_longer(cols = starts_with("wk"), names_to = "week",
              values_to = "ranking", values_drop_na = TRUE ,names_prefix = "wk") %>%
  select(year:time, week, ranking, date.entered ) %>%
  rename(date = date.entered) %>%
  mutate(week = parse_number(week),
         date = date+7*(week-1))

billboard_revised  

# week 1 = week+7*0
# week 2 = week+7*1
# week 3 = week+7*2
  
# week+7 *(week-1)
```

### c. Sort the data by artist, track and week. Here are what your first entries should be (formatting can be different):
```{r}
billboard_revised %>%
  arrange(artist,track,week)

```

## 3. Import and tidy the Iris dataset from <http://archive.ics.uci.edu/ml/datasets/Iris>. You need two files to generate the data set: iris.data and iris,names. Both are text files. Then plot the measurements using boxplots with the x variable being the species, faceting by plant part (sepal or petal) and by measure dimension (length or width). Your plot should look something like this:

```{r}
iris_data <- read.csv(file = "./data/iris_data.csv", header = FALSE, sep = ",")
iris_real_data <- iris_data %>%
  
  rename("sepal_length" = "V1", "speal_width" = "V2", 
         "petal_length" = "V3", "petal_width" = "V4", "species" = "V5") %>%
  #rename(new = old)
  
  pivot_longer(cols = sepal_length:petal_width, 
               names_to = "cm", values_to = "value") %>%
  separate(col = cm, into = c("sp","dimension")) %>%
  mutate(species = recode(species, "Iris-setosa" = "setosa",
                          "Iris-versicolor" = "versicolor", 
                          "Iris-virginica" = "virginica")) 
   

iris_real_data$sp[iris_real_data$sp == "speal"] <- "sepal" 

iris_real_data %>%
  ggplot(aes(x = species,y= value)) +
  geom_boxplot()+
  facet_grid(sp~dimension) + # two category uses fact_grid
  theme_bw()+
  theme(strip.background = element_rect(colour = "black", fill = "white"))
  

```

