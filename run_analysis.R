library(data.table)
library(reshape2)

## Reads data
features <- as.character(read.table("./UCI HAR Dataset/features.txt")[,2])
activity_labels <- as.character(read.table("./UCI HAR Dataset/activity_labels.txt")[,2])

# training data
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
set_train <-  data.frame(subject_train, y_train, X_train)
names(set_train) <- c(c('subject', 'activity'), features)

# testing data
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
set_test <-  data.frame(subject_test, y_test, X_test)
names(set_test) <- c(c('subject', 'activity'), features)

## 1. Merges the training and the test sets to create one data set.
set_all <- rbind(set_train, set_test)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
extract_meas <- grep('mean|std', features)
subset <- set_all[,c(1,2,extract_meas + 2)]

## 3. Uses descriptive activity names to name the activities in the data set
subset$activity <- activity_labels[subset$activity]

## 4. Appropriately labels the data set with descriptive variable names
name.new <- names(subset)
name.new <- gsub("[(][)]", "", name.new)
name.new <- gsub("^t", "TimeDomain_", name.new)
name.new <- gsub("^f", "FrequencyDomain_", name.new)
name.new <- gsub("Acc", "Accelerometer", name.new)
name.new <- gsub("Gyro", "Gyroscope", name.new)
name.new <- gsub("Mag", "Magnitude", name.new)
name.new <- gsub("-mean-", "_Mean_", name.new)
name.new <- gsub("-std-", "_StandardDeviation_", name.new)
name.new <- gsub("-", "_", name.new)
names(subset) <- name.new

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
data_tidy <- aggregate(subset[,3:81], by = list(activity = subset$activity, subject = subset$subject),FUN = mean)
write.table(x = data_tidy, file = "./UCI HAR Dataset/data_tidy.txt", row.names = FALSE)
