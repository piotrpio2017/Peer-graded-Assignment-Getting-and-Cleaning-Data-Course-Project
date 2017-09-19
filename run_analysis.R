## 1. Merge the training and the test sets to create one data set

#Read text files related to: training set, test set, training activities, test activities, training subjects, test subjects and produce data frames, in that for better observation structure of data
#Names of data frames as much similar as source text files, to assure better understanding 
x_train_txt <- read.table("./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
x_test_txt <- read.table("./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
y_train_txt <- read.table("./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
y_test_txt <- read.table("./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
subject_train_txt <- read.table("./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
subject_test_txt <- read.table("./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")

#Add training labels to training for better observation relation between training set and its labels (-activities) 
train_txt <- cbind(subject_train_txt, y_train_txt, x_train_txt)

#Add test labels to test set for better observation relation between test set and its labels (-activities)
test_txt <- cbind(subject_test_txt, y_test_txt, x_test_txt)

#Merge the training and the test sets to create one data set
data_set <- rbind(train_txt, test_txt)

#Call first column of data set as "Subjects"
names(data_set)[1] <- paste("Subjects")

#Call second column of data set as "Activities"
names(data_set)[2] <- paste("Activities")


## 2. Extract only the measurements on the mean and standard deviation for each measurement

#Read features text file and produce data frame for ability to observe kinds of features
features_txt <- read.table("./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/features.txt")

#Extract those rows (-features) from features list, which are related only to mean and standard deviation
mean_row <- grep("mean()", features_txt[, "V2"])
std_row <- grep("std()", features_txt[, "V2"])

#Extract from data set only the measurements on the mean and standard deviation for each measurement
library(dplyr)
extr_mean_std_data_set <- select(data_set, 1, 2, mean_row+2, std_row+2) #first column is reserved for activities "Labels", not measurements


## 3. Use descriptive activity names to name the activities in the data set

#Read text files related to activities labels, in that for better observation structure of data
activity_labels_txt <- read.table("./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")

#Change numerical values of activities labels to descriptive names of activities labels 
desc_activity_names <- activity_labels_txt[ ,"V2"]
extr_mean_std_data_set$Activities <- recode(extr_mean_std_data_set$Activities, desc_activity_names[1], desc_activity_names[2], desc_activity_names[3], desc_activity_names[4], desc_activity_names[5], desc_activity_names[6])


## 4. Appropriately labels the data set with descriptive variable names

#Appropriately labels the data set with descriptive variable names for columns related to "mean" features
old_col_names_mean <- c(as.character(names(extr_mean_std_data_set[,3:48])))
desc_col_names_mean <- c(as.character(features_txt[mean_row, "V2"]))
library(data.table)
setnames(extr_mean_std_data_set, old_col_names_mean, desc_col_names_mean)

#Appropriately labels the data set with descriptive variable names for columns related to "std" features
old_col_names_std <- c(as.character(names(extr_mean_std_data_set[,49:81])))
desc_col_names_std <- c(as.character(features_txt[std_row, "V2"]))
setnames(extr_mean_std_data_set, old_col_names_std, desc_col_names_std)


## 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject

#Sort data set according to Subjects and according to Activities
sorted_data_set <- arrange(extr_mean_std_data_set, extr_mean_std_data_set$Subjects, extr_mean_std_data_set$Activities)

#Create independent tidy data set with the average of each variable for each subject
variables_means_rows <- sorted_data_set
for (subject in 1:30) {
    subject_mean <- as.vector(colMeans(sorted_data_set[sorted_data_set$Subjects == subject, 3:81]))
    variables_means_rows[subject,3:81] <- subject_mean
        
}
second_data_set_subject <- variables_means_rows[1:30, ]

#Create independent tidy data set with the average of each variable for each activity
variables_means_rows <- sorted_data_set
for (activity in unique(sorted_data_set[,"Activities"])) {
    activity_mean <- as.vector(colMeans(sorted_data_set[sorted_data_set$Activities == activity, 3:81]))
    variables_means_rows[activity,3:81] <- activity_mean
  
}
second_data_set_activity <- variables_means_rows[1:6, ]

#Create independent tidy data set with the average of each variable for each activity and each subject
second_data_set <- rbind(second_data_set_activity, second_data_set_subject)


## Write tidy data set, created in step 5 of the instructions, as a txt file created with write.table() using row.name=FALSE for upload during submission
write.table(second_data_set, "./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Tidy Dataset/tidy_data_set.txt", row.names = FALSE)