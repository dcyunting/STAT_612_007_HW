---
title: "Homework 1"
author: "Yunting"
date: "1/20/2020"
output: pdf_document
---
## Instructions
There are two parts to this homework:\
1. Reproduce this **entire document** in Markdown (including these instructions).\   
2. Insert code chunks as apporpriate and solve the problems in the second part.\    
 
Knit directly to PDF.\   

Submit both .Rmd and PDF to Blackboard in a single submission by the due date and time (before the next class).\  

# STAT 412/612 Statistical Programming in R, Spring 2020 Secs 007/007 (Syllabus Extract)\  
**Time**: 5:30 - 8:00 pm ~~Fridays Don Myers Technology and Innovation (DMTI), Room 109.\
**Instructor**: Dr. Richard Ressler\
* Email: <rressler@american.edu>\    
* Office: DMTI 106-O\
* Phone: 202-885-6472\
* Office Hours: in Syllabus on Blackboard\  

### Material
* Required Hardware and Software:\
– *Laptop computer* - **fully charged for each class**\
– Current version of R\
– Current version of R Studio\

* Books: [R for Data Science by Wickham and Grolemund (O’Reilly).](r4ds.had.co.nz)

# Acknowledgements
I have read the syllabus provided on the Blackboard system for this class and section.\ 

I understand the course learning outcomes and tentative schedule.\ 

If I have to miss class *on the rare occasion*, I am responsible for any assignments or papers given out during any missed class. I will obtain these materials from a colleague BEFORE the next class meeting.\ 

I expect to have to do some research (using Google, stackoverflow, etc.) to do my assignments. I will cite sources from which I have used code and describe how I adjusted it.\ 

I understand sharing, reviewing, or using solutions to any exam or homework in any way from previous or concurrent versions of this course is prohibited and a violation of the *Academic Integrity Code.*\ 

### Graded Work
**Assignments:** There will be approximately 9 formal homework assignments throughout the semester plus deliverables for a final project.\

I may receive assistance from other students in the class and the professor, but my submissions must be composed of my own thoughts, coding and words. If I get ideas from online resources such as stackoverflow or github when I get stuck, I will cite my source and be specific about what I have added to it. I will be able to redo the code “cold” when I do this. Failure to do so is a violation of AU’s Academic Integrity Code.\

Late assignments will not be accepted.\

**Exams:** We will have approximately three in-class exams. Any material covered in class, assigned readings,or on assignments is “fair game.” No make-up exams will be given unless I have an extremely compelling excuse such as a previously-requested observance of a religious holiday or a documented medical emergency.\

**Project:**

> My project should involve working with 2-4 classmates on a fairly large real-world dataset to answer some question of interest. It should be reproducible and include graphical representations of my data.

*Grading* I should be able to explain my work on assignments, exams, and project and my rationale. Based on my explanation (or lack thereof), the professor may modify my grade. My final grade will be determined by:  

**Undergraduate students-412:** | **Graduate Students-612:**
------------- | -------------
Assignments (40%) | Assignments (40%)
Exams (30% composed of: Exam 1 = 10%,Exam 2 = 10%, Final Exam = 10%)|Exams (30% composed of: Exam 1 = 10%, Exam 2 = 10%, Final Exam = 10%)
Final Project (20%) | Final Project (30%)
Attendance and Participation (10%) | Attendance and Participation (May lower Grade%)

### Final Grades
The final grades will be based on a curve if the median is below 85. A visual representation of possible curves follows:  


![](D:/American_University/MAP/STAT-612-007_Statistical_Programming_in_R/STAT_612/wk1/hw/stat614curve.png)

### Other Notes
We will occasionally need to type equations like $A=\pi*r^{2}$. More often we will evaluate something like: the number of cars in the mtcars built-in dataset is 50.

# Exercises using Base R
Complete the following exercises using base R.\
Useful functions seq(), sum(), mean(), sd,[], c(), length(), log(), data.frame()\  

1. Create a vector that contains all integers divisible by 5 from 65 to 250. Assign this vector to a variable.
Add up the elements of this vector. What is the mean of the vector?
```{r}
x <- c(65:250)
y <- x [x%%5 ==0]
sum(y)
mean(y)

```
2. Create a vector of numerics of length 100 that starts at 65 and ends at 250 and assign to a variable.
The difference between any two consecutive elements should be the same. Add up the elements of this
vector. What is its standard deviation?
```{r}
x <- seq(from <- 65,to <- 250,length.out = 100)
x
sum(x)
sd(x,na.rm = TRUE)
```
3. Extract the 11th element from the vector you created in part 1.
```{r}
y[11]
```
4. Extract the 11th to 25th elements from the vector you created in part 1.
```{r}
y[11:25]
```
5. Combine the vectors from parts 1 and 2 and assign this combined vector to a new variable.
```{r}
a <- seq(from <- 65,to <- 250,length.out = 100)
total <- c(y,a)
total
```
6. Use a function to determine the length of the vector in part 5.
```{r}
length_of_total <- length(total)
length_of_total
```
7. What is the sum of the log of every element in the vector in part 5?
```{r}
num <- c(y,a)
log(num)
sum(log(num))
```
8. Create two vectors of length 3, one with numbers and one with characters. Create a dataframe with the vectors. Sum the numbers in the first column.
```{r}
apple <- 1:3
bird <- c("cat", "dog","egg")
df <- data.frame(apple,bird)
df
sum(df$apple)

```

