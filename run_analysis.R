## Getting and Cleaning Data - Course Project

#One of the most exciting areas in all of data science right now is wearable 
#computing - see for example this article . Companies like Fitbit, Nike, and 
#Jawbone Up are racing to develop the most advanced algorithms to attract new 
#users. The data linked to from the course website represent data collected from 
#the accelerometers from the Samsung Galaxy S smartphone. A full description is 
#available at the site where the data was obtained:
#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#Here are the data for the project:
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#You should create one R script called run_analysis.R that does the following.
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each 
#measurement.
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names.
#From the data set in step 4, creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject.

#Tidy data definition
#1. one column per variable
#2. one row per case/observation
#3. column names are clear

#License: Use of this dataset in publications must be acknowledged by referencing
#the following publication [1] 
#[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes
#-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware
#-Friendly Support Vector Machine. International Workshop of Ambient Assisted 
#Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
#This dataset is distributed AS-IS and no responsibility implied or explicit can 
#be addressed to the authors or their institutions for its use or misuse. Any 
#commercial use is prohibited.
#Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 
#2012.

#For each record it is provided:
#- Triaxial acceleration from the accelerometer (total acceleration) and the 
#estimated body acceleration.
#- Triaxial Angular velocity from the gyroscope. 
#- A 561-feature vector with time and frequency domain variables. 
#- Its activity label. 
#- An identifier of the subject who carried out the experiment.

#load packages
library(dplyr)
library(plyr) ## need for join()
#Create 'data' folder for files if it doesn't exist already
if(!file.exists("./data")){dir.create("./data")}
#Download zip file
dataset_url <-
        "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataset_url, "dataset.zip")
unzip("dataset.zip", exdir = "data") ## unzip to 'data' folder
#Use TextWrangler program to check files 
#Read the ReadMe file to see how all the files are connected
#Group of 30 volunteers within an age bracket of 19-48 years. 
#Each person performed six activities (WALKING, WALKING_UPSTAIRS, 
#WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone 
#(Samsung Galaxy S II) on the waist. 
#Using its embedded accelerometer and gyroscope, we captured 3-axial linear 
#acceleration and 3-axial angular velocity at a constant rate of 50Hz. 

##Check file names in folders and subfolders
list.files("data") ## lists files in “data” folder
list.files("UCI HAR Dataset") ## lists files in UCI... folder
list.files("UCI HAR Dataset/test") ## lists files in test subfolder
list.files("UCI HAR Dataset/train") ## lists files in train subfolder

##Read files from UCI HAR Dataset folder, test and train subfolders
##Read files from test subfolder
# 'test/subject_test.txt': Each row identifies the subject who performed the 
#activity for each window sample. Its range is from 1 to 30. 
subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt") #Test activity labels
##Read files from train subfolder
# 'train/subject_train.txt': Each row identifies the subject who performed the 
# activity for each window sample. Its range is from 1 to 30.
subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")

# 'features_info.txt': Shows information about the variables used on the feature 
#vector.
# 'features.txt': List of all features. There are 561 features. These names
# will be used as variable names for the xtest and xtrain datasets
features <- read.table("./UCI HAR Dataset/features.txt")
featuresnames <- features$V2

# 'activity_labels.txt': Links the class labels with their activity name.
# These labels are for the y-files.
#1 WALKING
#2 WALKING_UPSTAIRS
#3 WALKING_DOWNSTAIRS
#4 SITTING
#5 STANDING
#6 LAYING
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")

#Check dimensions for all files, and figure out how to merge them
dim(subjecttest) # returns [1] 2947    1
dim(xtest) # returns [1] 2947    1
dim(ytest) # returns [1] 2947    1
dim(subjecttrain) #returns [1] 7352    1
dim(xtrain) #returns [1] 7352    1
dim(ytrain) #returns [1] 7352    1

#Change column names (could also use rename() with dplyr package)
names(subjecttest)[1]<-"subject"
names(ytest)[1]<-"activity"
names(xtest)<-featuresnames
names(subjecttrain)[1]<-"subject"
names(ytrain)[1]<-"activity"
names(xtrain)<-featuresnames

#Use rbind() or cbind() to join data together in separate test and train sets
testdf<-cbind(subjecttest,ytest)
testdf<-cbind(testdf,xtest)
traindf<-cbind(subjecttrain,ytrain)
traindf<-cbind(traindf,xtrain)

#Merge training and test sets to create one data set
datasetdf<-rbind(testdf,traindf)

#Use expression to sort out variable names with mean or std
#Use \\ to capture ( and )
subset<-grep("mean\\(\\)|std\\(\\)",names(datasetdf))
length(subset) ## returns 66
newdf<-cbind(datasetdf$subject,datasetdf$activity)
newdf<-cbind(newdf,datasetdf[,subset])

#Change first two column names to 'subjectid' and 'activityname'
names(newdf)[1]<-"subjectid"
names(newdf)[2]<-"activityname"

#Use descriptive activity names to name the activities in the data set
#Use gsub() to change activity data from numbers with description names
newdf$activityname<-gsub("1","walking",newdf$activity)
newdf$activityname<-gsub("2","walking upstairs",newdf$activity)
newdf$activityname<-gsub("3","walking downstairs",newdf$activity)
newdf$activityname<-gsub("4","sitting",newdf$activity)
newdf$activityname<-gsub("5","standing",newdf$activity)
newdf$activityname<-gsub("6","laying",newdf$activity)

#Label the data set with descriptive variable names that are appropriate
#Explanation of descriptive name selection provided in CodeBook.md
currentnames<-names(newdf)
#remove all '-', '(',')'
#replace t with time, f with freq, mean with Mean, std with Std
newnames<-gsub("-","",currentnames) ## Replace all ‘_’
newnames<-sub("\\(\\)","",newnames)
newnames<-sub("^t","time",newnames)
newnames<-sub("^f","freq",newnames)
newnames<-sub("mean","Mean",newnames)
newnames<-sub("std","Std",newnames)

names(newdf)<-newnames ## Change newdf column names using newnames variable
newdf<-arrange(newdf,subjectid) ## Arrange data set by subjectid

####################################
## Final cleaned data set is 'newdf'
####################################

####################################
#Create a second, independent tidy data set with the average of each variable
#for each activity and each subject
####################################

# Use dplyr package functions to clean and tidy this data set
# Data is already arranged by subjectid

# Use dplyr tools to tidy data as requested.
# Use group_by using subjectid and activityname, then use summarise_each
# function to apply mean to the rest of the 66 variables

tidydf<-newdf %>%
        group_by(subjectid,activityname) %>%
        summarise_each(funs(mean))

## The resulting dataframe, besides the subjectid and activityname, shows the
## mean value of each of the variables grouped by subjectid and activityname
## which are the first two columns.

#Save the file using write.table
tidydata <- write.table(tidydf, "./tidydata.txt", row.names=NULL) 

#Use this command to read the file
data <- read.table("./tidydata.txt",header=TRUE, row.names=NULL)
View(data)

#Uploaded the run_analysis.R, the second dataset tidydata.txt, readme.md 
#and the codebook.md to GitHub

