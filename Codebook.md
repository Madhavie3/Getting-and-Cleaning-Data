

Identifiers

subject - The ID of the test subject
activity - The type of activity performed when the  measurements were taken

The dataset tidy.csv is the result of cleaning and selecting data from data from an experiment in which measurements were collected from the accelerometer and 
gyroscope from the Samsung Galaxy S smartphone used by 30 subjects carrying out a variety of 6 activities. 
The first variable denotes the subject number that performed an activity. In total there are 30 subjects.
The second variable activity denotes the activity performed by the subject. There are six activites, listed here:
Activity Labels
WALKING           : subject was walking during the test
WALKING_UPSTAIRS  : subject was walking up a staircase during the test
WALKING_DOWNSTAIRS: subject was walking down a staircase during the test
SITTING           : subject was sitting during the test
STANDING          : subject was standing during the test
LAYING            : subject was laying down during the test
1.only features that estimated mean and standard deviations, using a grep on "mean|std" were considered.

2.The feature names from the original data have been rewritten, using the following rules:
The prefix t is for time variables,  So that it is clear that the feature corresponds to the time domain.
The prefix f is for frequency variables, so that it is clear that the feature corresponds to the frequency domain.

3.Description of the Script

# First activity_labels and feature data sets were loaded to R
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Loading the train datasets and did a cbind to get final tain data set
xtrain 
ytrain 
strain 
finaltrain

# Loading the test datasets and did a cbind to get final test data set

xtest 
ytest 
stest 
finaltest 

# Merges the training and the test sets using Rbind to create one data set.

#  Uses descriptive activity names to name the activities in the data set and turns activitiy and subjects to factors
# Appropriately labels the data set with descriptive variable names.
finaldata$activity 
finaldata$subject 
finaldata.melted (The melt function takes data in wide format and stacks a set of columns into a single column of data)

# created an independent tidy data set with the average of each variable for each activity and each subject.
write.table(finaldata.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
file.show("tidy.txt") (displays output txt file)

