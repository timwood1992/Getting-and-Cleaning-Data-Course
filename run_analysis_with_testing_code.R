# Getting and Cleaning Data
## Course Project

##  All files for this project can be found at the following GitHub repo:
##  https://github.com/timwood1992/Getting-and-Cleaning-Data-Course.git


##  Note:  To run this R script, the data folder for the assignment (titled "UCI HAR Dataset") must be
##  unzipped and saved in your R working directory.

##############################################################################################

##  The objective of this section of code is to perform step # 1 of the Program assignment:
##    1.  Merges the training and the test sets to create one data set.

##############################################################################################

##  Loads in the three files from the train dataset
##    x_train_data is a data frame that lists 7352 observations for 561 variables.
##    y_train_data is a data frame that lists the activity associated with each observation in x_train_data.
##    subject_train_data is a data frame that lists the subjects for each observation in x_train_data.

x_train_data <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train_data <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train_data <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## Take a look at the data     ************** Take out these lines prior to submission ******************
x_train_data[1:10,1:10]
head(y_train_data)
head(subject_train_data)


##  Loads in the three files from the test dataset
##    x_test_data is a data frame that lists 2947 observations for 561 variables.
##    y_test_data is a data frame that lists the activity associated with each observation in x_test_data.
##    subject_test_data is a data frame that lists the subjects for each observation in x_test_data.

x_test_data <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test_data <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test_data <- read.table("./UCI HAR Dataset/test/subject_test.txt")

## Take a look at the data     ************** Take out these lines prior to submission ******************
x_test_data[1:10,1:10]
head(y_test_data)
head(subject_test_data)


##  Load the list of features into the data frame "features_list".  This data frame lists the feature
##  that was measured for each of the 561 variables in x_train_data.
features_list <- read.table("./UCI HAR Dataset/features.txt")

## Take a look at the data     ************** Take out these lines prior to submission ******************
head(features_list)

##  Replace the column names in X_train_data and x_test_data with the name of each feature that was measured
colnames(x_train_data) <- features_list[,2]
colnames(x_test_data) <- features_list[,2]

## Take a look at the data     ************** Take out these lines prior to submission ******************
x_train_data[1:10,1:10]
x_test_data[1:10,1:10]

## Replace the column name for y_train_data and y_test_data to a more descriptive name
colnames(y_train_data) <- "Activity"
colnames(y_test_data) <- "Activity"

## Take a look at the data     ************** Take out these lines prior to submission ******************
head(y_train_data)
head(y_test_data)

## Replace the column name for y_train_data and y_test_data to a more descriptive name
colnames(subject_train_data) <- "Subject"
colnames(subject_test_data) <- "Subject"

## Take a look at the data     ************** Take out these lines prior to submission ******************
head(subject_train_data)
head(subject_test_data)


## Combine the list of subjects, Activity, and the feature measurement into one data frame for the train
## data set and the test data set.
train_data <- cbind(subject_train_data, y_train_data, x_train_data)
test_data <- cbind(subject_test_data, y_test_data, x_test_data)

## Take a look at the data     ************** Take out these lines prior to submission ******************
train_data[1:10,1:10]
test_data[1:10,1:10]


## Combine the the train data set and the test data set together to form one data frame of all data.
human_activity_recognition_data <- rbind(train_data, test_data)

## Take a look at the data     ************** Take out these lines prior to submission ******************
human_activity_recognition_data[1:10, 1:10]


##############################################################################################

##  The objective of this section of code is to perform step # 2 of the Program assignment:
##    2.  Extracts only the measurements on the mean and standard deviation for each measurement.

##############################################################################################

## Creates a subset of the data which contains the mean and standard deviation measurements listed in 
## the data frame human_activity_recognition_data.  Note that this includes only the measurements specifically
## labeled as mean or std (e.g. it does not include meanFreq). 
mean_and_std_data_frame <- human_activity_recognition_data[,grep("mean\\(\\)|std\\(\\)", names(human_activity_recognition_data))]

## Add the Subject and Activity data to the mean_and_std_data_frame
mean_and_std_data_frame <- cbind(human_activity_recognition_data[,1:2], mean_and_std_data_frame)

## Take a look at the data     ************** Take out these lines prior to submission ******************
mean_and_std_data_frame[1:10,1:10]
mean_and_std_data_frame[1:10,57:66]


##############################################################################################

##  The objective of this section of code is to perform step # 3 of the Program assignment:
##    3.  Uses descriptive activity names to name the activities in the data set.

##############################################################################################

## Load the activity names from the data provided.
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

## Take a look at the data     ************** Take out these lines prior to submission ******************
activity_labels

## Change labels to lower case.
activity_labels[,2] <- tolower(activity_labels[,2])

## Take out the "_" characters in the labels.
activity_labels[,2] <- gsub("_"," ", activity_labels[,2])

## Take a look at the data     ************** Take out these lines prior to submission ******************
activity_labels

## Replace the activity numbers in mean_and_std_data_frame with the activity name
for (i in 1:length(activity_labels[,2]))  {
    mean_and_std_data_frame[,2] <- gsub(activity_labels[i,1], activity_labels[i,2], mean_and_std_data_frame[,2])    
}

## Take a look at the data     ************** Take out these lines prior to submission ******************
mean_and_std_data_frame[1:10,1:10]
mean_and_std_data_frame[10290:10299,1:10]


##############################################################################################

##  The objective of this section of code is to perform step # 4 of the Program assignment:
##    4.  Appropriately labels the data set with descriptive variable names.

##############################################################################################

## Take a look at the names of the variables    ************** Take out these lines prior to submission ******************
## This file will load into the Working Directory.  You can view it in a text editor.  The purpose of 
## viewing this file is to establish which character patterns need to change to convert the column
## names into descriptive varialbe names.
write.table(names(mean_and_std_data_frame), file="Program_Assignment_variable_names.txt")

## Establish the character patterns we want to replace and specify the replacement characters.
## This was obtained by looking at the names of the variables.
variables_pattern <- list("^t", "^f", "std", "mean", "Mag", "BodyBody", "\\(\\)", "-")
variables_replacement <- list("Time", "Frequency", "StdDev", "Mean", "Magnitude", "Body", "", "")


## Replace the character patterns in mean_and_std_data_frame with the revised characters in order to
## have descriptive variable names.
for (i in 1:length(variables_pattern))  {
    colnames(mean_and_std_data_frame) <- gsub(variables_pattern[i], variables_replacement[i], colnames(mean_and_std_data_frame))    
}

## Take a look at the names     ************** Take out these lines prior to submission ******************
names(mean_and_std_data_frame)


##############################################################################################

##  The objective of this section of code is to perform step # 5 of the Program assignment:
##    5.  Creates a second, independent tidy data set with the average of each variable for 
##        each activity and each subject. 

##############################################################################################

## Use the aggregate function to create a new dataframe with the average for each variable by 
## activity and subject
SummaryData <-aggregate(.~Activity+Subject,mean_and_std_data_frame, FUN=mean)

## Take a look at the data     ************** Take out these lines prior to submission ******************
SummaryData[1:10, 1:5]
SummaryData[30:40, 1:5]
SummaryData[170:180, 1:5]

## Write the dataframe to a file in the Working Directory.  This can be viewed by a text editor or using Excel.
## Note that this will create two files: a text file and a csv file.
write.table(SummaryData, file="Program_Assignment_Summary_Data.txt", quote=FALSE,row.names=FALSE)
write.csv(SummaryData, file="Program_Assignment_Summary_Data.csv", row.names=FALSE)


## Print the list of names for use in the Code Book README file.
write.table(names(SummaryData), file="Program_Assignment_Summary_Data_Variable_Names", row.names=FALSE)


