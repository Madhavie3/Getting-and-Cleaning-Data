
setwd("/Users/VjMadz/Desktop/Coursera assignments/Getting and cleaning data/UCI HAR Dataset")
library(reshape2)

filename <- "getdata_dataset.zip"

## Download and unzip the given project dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# First activity_labels and feature data sets were loaded to R
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activitylabels[,2] <- as.character(activitylabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extracts only the measurements on the mean and standard deviation for each measurement.
finalfeatures <- grep(".*mean.*|.*std.*", features[,2])
finalfeatures.names <- features[finalfeatures,2]
finalfeatures.names = gsub('-mean', 'Mean', finalfeatures.names)
finalfeatures.names = gsub('-std', 'Std', finalfeatures.names)
finalfeatures.names <- gsub('[-()]', '', finalfeatures.names)


# Loading the train datasets and did a cbind to get final tain data set

xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")[finalfeatures]
ytrain <- read.table("UCI HAR Dataset/train/Y_train.txt")
strain <- read.table("UCI HAR Dataset/train/subject_train.txt")
finaltrain <- cbind(xtrain, ytrain, strain)

# Loading the test datasets and did a cbind to get final test data set

xtest <- read.table("UCI HAR Dataset/test/X_test.txt")[finalfeatures]
ytest <- read.table("UCI HAR Dataset/test/Y_test.txt")
stest <- read.table("UCI HAR Dataset/test/subject_test.txt")
finaltest <- cbind(xtest, ytest, stest)

# Merges the training and the test sets to create one data set.

finaldata <- rbind(finaltrain, finaltest)
colnames(finaldata) <- c("subject", "activity", finalfeatures.names)

# # Uses descriptive activity names to name the activities in the data set and turns activitiy and subjects to factors
# Appropriately labels the data set with descriptive variable names.
finaldata$activity <- factor(finaldata$activity, levels = activitylabels[,1], labels = activitylabels[,2])
finaldata$subject <- as.factor(finaldata$subject)

finaldata.melted <- melt(finaldata, id = c("subject", "activity"))
finaldata.mean <- dcast(finaldata.melted, subject + activity ~ variable, mean)

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

write.table(finaldata.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
file.show("tidy.txt")

