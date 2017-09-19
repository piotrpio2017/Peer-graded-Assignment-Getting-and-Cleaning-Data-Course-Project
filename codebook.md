==================================================================
Peer-graded Assignment: Getting and Cleaning Data Course Project
Version 1.0
==================================================================
Author: Piotr (Tomasz) Piotrowski
==================================================================


Applied variables and calculations; and generated data sets by script >>>'run_analysis.R'<<< - to demonstrate all required kinds of operations related to: collect, work with, and clean a data set
========================================================================================================================================================================================================

Instruction 1. Merges the training and the test sets to create one data set.
==========================================================================================
Training data set was delivered for the project in 'x_train.txt' file.
Test data set was delivered for the project in 'x_test.txt' file.
However, besides merging data only from these both files, the related labels for activities and subjects was also merged for better visibility and understand two merged data sets.
a)all files ('x_train\test.txt', 'y_train\test.txt', 'subject_train\test.txt') was read using read.table() functions and get data frame classes
b)data set file for training data set was merged using cbind() function with activities and subjects labels files related to training data set
c)data set file for test data set was merged using cbind() function with activities and subjects labels files related to test data set 
d)Data frames from point b) and c) was merged using rbind() function and was created one data set ('data_set' variable).
'data_set' variable has first column named "Subjects", second column named "Activities" and remain columns come from training and test data set, named "V1...V561"

Instruction 2. Extracts only the measurements on the mean and standard deviation for each measurement.
=====================================================================================================================
a)features.txt file was read using read.table() function, because it contains all kinds of measurements, in that measurements related to mean and standard deviation
b)grep() function was used to select those rows in features.txt file, which contain measurements related to mean and standard deviation
c)select() function was used to extract only the measurements on the mean and standard deviation for each measurement using rows related to mean and std. select() function requires dplyr library.
It was created new data frame 'extr_mean_std_data_set', which has the same first and second column as 'data_set", but remain columns contain only measurements related to mean and std

Instruction 3. Uses descriptive activity names to name the activities in the data set.
=====================================================================================================
a)activity_labels.txt file was read using read.table() function, because it contains all descriptive activity labels
b)recode() function was used to change values in second column of 'extr_mean_std_data_set', related to activities from numbers to descriptive names and result was written to second column of 'extr_mean_std_data_set'

Instruction 4. Appropriately labels the data set with descriptive variable names.
==============================================================================================
a)old column names for mean measurements was taken from 'extr_mean_std_data_set' and saved as 'old_col_names_mean'
b)new column names for mean measurements was taken from 'features_txt' and saved as 'desc_col_names_mean'
c)setnames() function was used to change column names related to mean measurements to descriptive variable names and result was saved in 'extr_mean_std_data_set'
d)points a-c) was repeated for column names related to std measurements, so 'extr_mean_std_data_set' has from third to last column new descriptive columns names. The new descriptive column names are exactly the same as in features in original 'features.txt' file, so further details are e.g. available in 'features_info.txt' file

Instruction 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
==========================================================================================================================================================================
a)tidy data set with the average of each variable for each subject was created using for loop working at data set sorted according to subjects and activities values
b)tidy data set with the average of each variable for each activity was created using for loop working at data set sorted according to subjects and activities values
c)colMean() functions was used inside for loops to calculate mean for each column in 'sorted_data_set' related to measurements
d)results of each for loop were saved to new data frame 'second_data_set...'
e)results from both for loop were merged using rbind() function and saved to new data frame 'second_data_set'. 'second_data_set' has the same column names as e.g. 'extr_mean_std_data_set', but contains rows related to average (mean) for all activities and all subjects. 

Additional writing result of 5th instruction to 'tidy_data_set.txt' file
===============================================================================
a)independent second tidy_data_set, created in step 5 of the instructions, was saved as 'tidy data set.txt' text file using function write.table() with additional parameter row.name=FALSE
