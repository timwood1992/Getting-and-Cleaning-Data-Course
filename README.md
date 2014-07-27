## Getting and Cleaning Data Course - Program Assignment

This README file describes my submission for the Program Assignment for the Getting and Cleaning Data Course.  All files are located with the Githup repo:
https://github.com/timwood1992/Getting-and-Cleaning-Data-Course.git

The required files for this assignment contained within the Github repo are:

run_analysis.R
README.md
CodeBook.md

In addition, the following files are also included in the repo:

run_analysis_with_testing_code.R
Program_Assignment_Summary_Data.txt
Program_Assignment_Summary_Data.csv


## Data:
The data used for this assignment represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The specific data used for the assignment can be downloaded at: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

To run the R script submitted for this assignment, the data folder for the assignment (titled "UCI HAR Dataset") must be unzipped and saved in your R working directory.


## Description of Measurements:

The description of the downloaded data can be found in the README file located in the UCI HAR Dataset folder.  An excerpt is:

Human Activity Recognition Using Smartphones Dataset
Version 1.0

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

Notes: 

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.


## Program Assignment:

From the downloaded data, the following assignment steps were performed.  The R script titled run_analysis.R performs these steps.

1.  Merges the training and the test sets to create one data set.
2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
3.  Uses descriptive activity names to name the activities in the data set
4.  Appropriately labels the data set with descriptive variable names. 
5.  Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The independent tidy data set produced in step 5 (titled “Program_Assignment_Summary_Data.txt”) was also submitted as part of this assignment.


## Steps Performed Within the R Script:

### For Step 1:

Loads in the three files from the train dataset
    x_train_data is a data frame that lists 7352 observations for 561 variables.
    y_train_data is a data frame that lists the activity associated with each observation in x_train_data.
    subject_train_data is a data frame that lists the subjects for each observation in x_train_data.

Loads in the three files from the test dataset
    x_test_data is a data frame that lists 2947 observations for 561 variables.
    y_test_data is a data frame that lists the activity associated with each observation in x_test_data.
    subject_test_data is a data frame that lists the subjects for each observation in x_test_data.

Loads the list of features into the data frame "features_list".  This data frame lists the feature that was measured for each of the 561 variables in x_train_data.

Replaces the column names in X_train_data and x_test_data with the name of each feature that was measured

Replaces the column name for y_train_data and y_test_data to a more descriptive name

Combines the list of Subjects, Activity, and the feature measurement into one data frame for the train data set and the test data set.

Combines the the train data set and the test data set together to form one data frame of all data.


### For Step 2:

Creates a subset of the data which contains the mean and standard deviation measurements listed in the data frame human_activity_recognition_data.  Note that this includes only the measurements specifically labeled as mean or std (e.g. it does not include meanFreq or the angle measurements). 

Adds the Subject and Activity data to the mean_and_std_data_frame


### For Step 3:

Loads the activity names from the data provided.

Changes labels to lower case.

Take out the "_" characters in the labels.

Replace the activity numbers in mean_and_std_data_frame with the activity name


### For Step 4:

Establish the character patterns we want to replace and specify the replacement characters.  The list of character patterns to replace was obtained by visually looking at the names of the variables and determining patterns that are common among several variables.  The list is as follows:

Pattern               Replacement
^t                      TimeDomain
^f                      FrequencyDomain
std                     StdDev
mean                    Mean
Mag                     Magnitude
BodyBody                Body
()                      ""
-                       ""

Replaces the character patterns in mean_and_std_data_frame with the revised characters in order to have descriptive variable names.  For the revised list of variable names, please see the “List of Modifications to the Variable Names” section below.


### For Step 5:

Uses the aggregate function to create a new dataframe with the average for each variable by activity and subject.

Writes the dataframe to a file in the Working Directory.  This can be viewed by a text editor or using Excel.  This script will save two files, one in txt format and the other in csv format.  The files names are:
Program_Assignment_Summary_Data.txt
Program_Assignment_Summary_Data.csv


## List of Modifications to the Variable Names

Original Name                     Descriptive Variable Name
Subject                             Subjet
Activity                            Activity
tBodyAcc-mean()-X                   TimeBodyAccMeanX
tBodyAcc-mean()-Y                   TimeBodyAccMeanY
tBodyAcc-mean()-Z                   TimeBodyAccMeanZ
tBodyAcc-std()-X                    TimeBodyAccStdDevX
tBodyAcc-std()-Y                    TimeBodyAccStdDevY
tBodyAcc-std()-Z                    TimeBodyAccStdDevZ
tGravityAcc-mean()-X                TimeGravityAccMeanX
tGravityAcc-mean()-Y                TimeGravityAccMeanY
tGravityAcc-mean()-Z                TimeGravityAccMeanZ
tGravityAcc-std()-X                 TimeGravityAccStdDevX
tGravityAcc-std()-Y                 TimeGravityAccStdDevY
tGravityAcc-std()-Z                 TimeGravityAccStdDevZ
tBodyAccJerk-mean()-X               TimeBodyAccJerkMeanX
tBodyAccJerk-mean()-Y               TimeBodyAccJerkMeanY
tBodyAccJerk-mean()-Z               TimeBodyAccJerkMeanZ
tBodyAccJerk-std()-X                TimeBodyAccJerkStdDevX
tBodyAccJerk-std()-Y                TimeBodyAccJerkStdDevY
tBodyAccJerk-std()-Z                TimeBodyAccJerkStdDevZ
tBodyGyro-mean()-X                  TimeBodyGyroMeanX
tBodyGyro-mean()-Y                  TimeBodyGyroMeanY
tBodyGyro-mean()-Z                  TimeBodyGyroMeanZ
tBodyGyro-std()-X                   TimeBodyGyroStdDevX
tBodyGyro-std()-Y                   TimeBodyGyroStdDevY
tBodyGyro-std()-Z                   TimeBodyGyroStdDevZ
tBodyGyroJerk-mean()-X              TimeBodyGyroJerkMeanX
tBodyGyroJerk-mean()-Y              TimeBodyGyroJerkMeanY
tBodyGyroJerk-mean()-Z              TimeBodyGyroJerkMeanZ
tBodyGyroJerk-std()-X               TimeBodyGyroJerkStdDevX
tBodyGyroJerk-std()-Y               TimeBodyGyroJerkStdDevY
tBodyGyroJerk-std()-Z               TimeBodyGyroJerkStdDevZ
tBodyAccMag-mean()                  TimeBodyAccMagnitudeMean
tBodyAccMag-std()                   TimeBodyAccMagnitudeStdDev
tGravityAccMag-mean()               TimeGravityAccMagnitudeMean
tGravityAccMag-std()                TimeGravityAccMagnitudeStdDev
tBodyAccJerkMag-mean()              TimeBodyAccJerkMagnitudeMean
tBodyAccJerkMag-std()               TimeBodyAccJerkMagnitudeStdDev
tBodyGyroMag-mean()                 TimeBodyGyroMagnitudeMean
tBodyGyroMag-std()                  TimeBodyGyroMagnitudeStdDev
tBodyGyroJerkMag-mean()             TimeBodyGyroJerkMagnitudeMean
tBodyGyroJerkMag-std()              TimeBodyGyroJerkMagnitudeStdDev
fBodyAcc-mean()-X                   FrequencyBodyAccMeanX
fBodyAcc-mean()-Y                   FrequencyBodyAccMeanY
fBodyAcc-mean()-Z                   FrequencyBodyAccMeanZ
fBodyAcc-std()-X                    FrequencyBodyAccStdDevX
fBodyAcc-std()-Y                    FrequencyBodyAccStdDevY
fBodyAcc-std()-Z                    FrequencyBodyAccStdDevZ
fBodyAccJerk-mean()-X               FrequencyBodyAccJerkMeanX
fBodyAccJerk-mean()-Y               FrequencyBodyAccJerkMeanY
fBodyAccJerk-mean()-Z               FrequencyBodyAccJerkMeanZ
fBodyAccJerk-std()-X                FrequencyBodyAccJerkStdDevX
fBodyAccJerk-std()-Y                FrequencyBodyAccJerkStdDevY
fBodyAccJerk-std()-Z                FrequencyBodyAccJerkStdDevZ
fBodyGyro-mean()-X                  FrequencyBodyGyroMeanX
fBodyGyro-mean()-Y                  FrequencyBodyGyroMeanY
fBodyGyro-mean()-Z                  FrequencyBodyGyroMeanZ
fBodyGyro-std()-X                   FrequencyBodyGyroStdDevX
fBodyGyro-std()-Y                   FrequencyBodyGyroStdDevY
fBodyGyro-std()-Z                   FrequencyBodyGyroStdDevZ
fBodyAccMag-mean()                  FrequencyBodyAccMagnitudeMean
fBodyAccMag-std()                   FrequencyBodyAccMagnitudeStdDev
fBodyBodyAccJerkMag-mean()          FrequencyBodyAccJerkMagnitudeMean
fBodyBodyAccJerkMag-std()           FrequencyBodyAccJerkMagnitudeStdDev
fBodyBodyGyroMag-mean()             FrequencyBodyGyroMagnitudeMean
fBodyBodyGyroMag-std()              FrequencyBodyGyroMagnitudeStdDev
fBodyBodyGyroJerkMag-mean()         FrequencyBodyGyroJerkMagnitudeMean
fBodyBodyGyroJerkMag-std()          FrequencyBodyGyroJerkMagnitudeStdDev




