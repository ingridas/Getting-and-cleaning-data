#Code Book for Project

##Overview

Source of the original data:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Description of the data is available:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Process

##Data processing & analysis

The script run_analysis.R performs the following process to clean up the data and create tiny data set:

1. Reads features and activity labels from `features.txt` and `activity_labels.txt`.
2. Reads training data from files `X_train.txt`, `y_train.txt` and `subject_train.txt` and combines them in a data frame.
3. Reads testing data from files `X_test.txt`, `y_test.txt` and `subject_test.txt` and combines them in a data frame.
4. Merges the training and the test sets to create one data set.
5. Identifies the features containing either "mean" or "std" in them using a function `grep`.
6. Extracts only the measurements on the mean and standard deviation for each measurement in a subset.
7. Identifies the column names of subset.
8. Replaces descriptive column names by appropriate ones, e.g., changes "Acc" to "Accelerometer" or "Mag" to "Magnitude" using function `gsub`.
9. Groups the measureements by activity and subject and calculates the average of measurements in the subset using a function `aggregate`.
10. Writes tidy data into the file `data_tidy.txt` using a function `write.table`.

##Variables

- features - contains features from `features.txt`
- activity_labels - contains activity labels from `activity_labels.txt`
- X_train - contains training measurements from `X_train.txt`
- y_train - contains training activities from a`y_train.txt`
- subject_train - contains training subjects from `subject_train.txt`
- set_train - a data frame containing training subject, activity and measurements
- X_test - contains testing measurements from `X_test.txt`
- y_test - contains testing activities from a`y_test.txt` 
- subject_test - contains testing subjects from `subject_test.txt`
- set_test - a data frame containing testing subject, activity and measurements
- set_all - a data frame with merged training and testing data 
- extract_meas - contains features with mean or standard deviation 
- subset - a data frame containing only data of mean or standard deviation measurements
- name.new - is used to change columns labels with descriptive variable names
- data_tidy -  a data frame of tidy data set with the average of each variable for each activity and each subject

##Output

`data_tidy.txt' is a 180x81 data frame.

- The first column contains activity name.
- The second column contains subject ID.
- The rest contains average of each measurement for each activity and each subject.
