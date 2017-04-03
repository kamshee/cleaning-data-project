---
title: "readme.md"
author: "Joe Lee"
date: "3/19/2017"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

Project for Getting and Cleaning Data using data from a smartphone.

This README file explains what files are included and how they are connected.

Data source: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Files included in the repository:
run_analysis.R
CodeBook.md
tidydata.txt

run_analysis.R script
        This script is used to take the raw data and create a tidy data set 
        into a file called tidydata.txt
        
        Summary of the methods used:
        Download the data from the URL above. It is a zip file.
        The result will be a folder with two subfolders containing the test
        and train data sets.
        Make data frames from the test and train data sets. There are 3 files
        each.
        Organize the two data sets separately and merge into one data set.
        Subset the data to collect only the variables with mean and standard
        deviation but excluding mean frequency. This explains what I
        interpreted the directions to be, but another person may have chosen to
        include the mean frequency variables.
        Change the activity names from numeric class data to descriptions that
        are character class. There are 6 different activity names.
        Change the column variable names to be descriptive and clear.
        Use dplyr package and tools to group the data by subject and activity,
        then use summarise_each function to apply mean function to the rest of
        the column variables to create the final tidy data set.
        Use the tidy data set to create a file called tidydata.txt.
        The tidy data set has 180 rows and 68 columns.
        
        To run the script:
        Download the run_analysis.R script and run it from the working directory.
        source(run_analysis.R)
        
Details on CodeBook.md
        This code book describes the variables, data, and methods used to
        clean and tidy the data.
        
Details on tidydata.txt
        This is the tidy data file created from running the run_analysis.R 
        script.
        
        Information on the dataset:
        The tidy data set has 180 rows and 68 columns.
        The first two columns are the subject id and the activity name.
        The rest of the columns (numbered 3-68, total 66) are the mean
        of the smartphone sensor measurements that are grouped by the first two
        columns.# Getting-and-cleaning-data-project
