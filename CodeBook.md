---
title: "CodeBook.md"
author: "Joe Lee"
date: "3/19/2017"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
``

Description of the project
Take data collected from accelerometers from Samsung Galaxy S smartphone. Create
one clean and tidy data set that can be used for future analysis.

Study design and data processing
Create a R script called run_analysis.R that merges the training and test data 
sets to create one data set. Extract the measurements that include mean and 
standard deviation for each measurement. Use descriptive names for the 
activities in the data set. Change the label for the data set variables to descriptive variable names. Create a second, independent tidy data set that is 
the average (mean) of each variable for each activity and each subject.

Note on README.md file:
README.md file explains how the run_analysis.R script and this code book all
fit together for this project.

Collection of the raw data and description of how the data was collected
Data source:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Data
set.zip
License: Use of this dataset in publications must be acknowledged by referencing
the following publication [1] 
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes
-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware
-Friendly Support Vector Machine. International Workshop of Ambient Assisted 
Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
This dataset is distributed AS-IS and no responsibility implied or explicit can 
be addressed to the authors or their institutions for its use or misuse. Any 
commercial use is prohibited.
Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 
2012.

For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the 
estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

Notes on the original (raw) data:
Group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, 
WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone 
(Samsung Galaxy S II) on the waist. 
Using its embedded accelerometer and gyroscope, we captured 3-axial linear 
acceleration and 3-axial angular velocity at a constant rate of 50Hz.
The obtained dataset has been randomly partitioned into two sets, where 70% of 
the volunteers was selected for generating the training data and 30% the test 
data.

Description on how the tidy data file was created.
1. Load packages needed
2. Download data which is a zip file
3. Unzip the zip file
4. List the files and check subfolders
5. Read files using read.table for 3 test files and 3 train files
6. Check features_info.txt to understand information about the variables
7. Check the list of 561 feastures in the features.txt file
8. Read in the activity labels from the activity_labels.txt file
9. Check the dimensions on all 6 files to understand how to merge the data into 
test and train data sets
10. Change the column names to "subjectid", "activityname"", and the 
corresponding feature names
11. Use cbind() to join the data together for the test and train data sets
12. Use rbind() to merge the test and train data sets into one data set
13. Use grep() to extract the columns with names that include mean or standard deviation for each measurement and exclude mean frequency columns. This is
how the instructions were interpreted for this project. It is also explained
in the README.md file as well as below. Used an "OR" expression to capture both
mean and standard deviation measurements.
14. Create a new data frame with the extracted columns and use cbind function
to paste together.
15. Change first two column names to 'subjectid' and 'activityname'. This is
more descriptive of the data contained.
16. Use descriptive activity names to name the activities in the data set using gsub() to change activity data from numbers with description names. 
The 6 activity names are: "walking", "walking upstairs", "walking downstairs", "sitting", "standing", and "laying".
17. Clean up the rest of the column names to be more clear and descriptive
of the data contained in them. Used sub and gsub functions.
18. Arranged the cleaned data set by subject id to be ready for future analysis.
19. The next part is to create a "tidy data set" for the second part of the
project.
20. Used dplyr package and tools to group the data by subject id and activity
name, then apply a mean function to the rest of the measurement data.
21. Saved the resulting data frame into a file called "tidydata.txt".
22. Uploaded the run_analysis.R script, README.md file, and CodeBook.md file
to a GitHub repository.

Explanation of descriptive column/variable names:
- Changed "subject" column name to 'subjectid' to be clear on what the data
represented
- Changed "activity" column name to 'activityname' to be clear on what the 
data represented
- Changed the activity name data from numeric/factor class data to the actual
activity name such as "walking", "walking upstairs", "walking downstairs",
"sitting", "standing", and "laying". This is in accordance with tidy data
principles.
- Besides the first two columns, the rest of the column names were changed to
be more descriptive and clear. To accomplish this, I removed unnecessary
characters such as '-', '(', and ')'. I changed 't' to 'time', 'f' to
'frequency', and capitalized the first letter of mean and std.
- Another option to make the column names more descriptive would have been
to write out the entire description for the name. An example would be for "tBodyAcc-mean()-X" could be changed to "mean time of body acceleration signal 
in the x axis". However, I decided to not use this method. Below is a legend
explaining the different parts that may be a column name and a list of them.

Legend to variable names that were abbreviated:
        time - time
        freq - frequency domain signals with applied Fast Fourier Transform 
                (FFT)
        BodyAcc - body acceleration
        GravityAcc - gravity accleration
        BodyGyro - gyroscope
        Jerk -jerk signals obtained by the body linear acceleration and angular                     velocity that were derived in time
        Mag - magnitude
        Mean - mean value
        Std - standard deviation
        X - signal in the x axis
        Y - signal in the y axis
        Z - signal in the z axis

#Use this command to read the file
data <- read.table("./tidydata.txt",header=TRUE, row.names=NULL)
View(data)

##Description of the variables in the tidydata.txt file.
Dimensions of the dataset: 180 observations, 68 columns
Summary of the data: Each row is an average of each variable for each activity
and each subject.
Columns Names of tidydata.txt (use legend above):        
"subjectid" - integer class, 1-30                   
"activityname" - character class, 6 different levels: "walking", "walking 
upstairs", "walking downstairs", "sitting", "standing", and "laying"            
"timeBodyAccMeanX" - numeric class (same is true for the rest of the variables)
"timeBodyAccMeanY"           
"timeBodyAccMeanZ"            
"timeBodyAccStdX"            
"timeBodyAccStdY"             
"timeBodyAccStdZ"            
"timeGravityAccMeanX"         
"timeGravityAccMeanY"        
"timeGravityAccMeanZ"         
"timeGravityAccStdX"         
"timeGravityAccStdY"          
"timeGravityAccStdZ"         
"timeBodyAccJerkMeanX"        
"timeBodyAccJerkMeanY"       
"timeBodyAccJerkMeanZ"        
"timeBodyAccJerkStdX"        
"timeBodyAccJerkStdY"         
"timeBodyAccJerkStdZ"        
"timeBodyGyroMeanX"           
"timeBodyGyroMeanY"          
"timeBodyGyroMeanZ"           
"timeBodyGyroStdX"           
"timeBodyGyroStdY"            
"timeBodyGyroStdZ"           
"timeBodyGyroJerkMeanX"       
"timeBodyGyroJerkMeanY"      
"timeBodyGyroJerkMeanZ"       
"timeBodyGyroJerkStdX"       
"timeBodyGyroJerkStdY"        
"timeBodyGyroJerkStdZ"       
"timeBodyAccMagMean"          
"timeBodyAccMagStd"          
"timeGravityAccMagMean"       
"timeGravityAccMagStd"       
"timeBodyAccJerkMagMean"      
"timeBodyAccJerkMagStd"      
"timeBodyGyroMagMean"         
"timeBodyGyroMagStd"         
"timeBodyGyroJerkMagMean"     
"timeBodyGyroJerkMagStd"     
"freqBodyAccMeanX"            
"freqBodyAccMeanY"           
"freqBodyAccMeanZ"            
"freqBodyAccStdX"            
"freqBodyAccStdY"             
"freqBodyAccStdZ"            
"freqBodyAccJerkMeanX"        
"freqBodyAccJerkMeanY"       
"freqBodyAccJerkMeanZ"        
"freqBodyAccJerkStdX"        
"freqBodyAccJerkStdY"         
"freqBodyAccJerkStdZ"        
"freqBodyGyroMeanX"           
"freqBodyGyroMeanY"          
"freqBodyGyroMeanZ"           
"freqBodyGyroStdX"           
"freqBodyGyroStdY"            
"freqBodyGyroStdZ"           
"freqBodyAccMagMean"          
"freqBodyAccMagStd"          
"freqBodyBodyAccJerkMagMean"  
"freqBodyBodyAccJerkMagStd"  
"freqBodyBodyGyroMagMean"     
"freqBodyBodyGyroMagStd"     
"freqBodyBodyGyroJerkMagMean" 
"freqBodyBodyGyroJerkMagStd"
