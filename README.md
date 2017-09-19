Peer-graded Assignment: Getting and Cleaning Data Course Project
Version 1.0
==================================================================
Author: Piotr (Tomasz) Piotrowski
==================================================================

Realized features and results:
=================================
All five instructions:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

are realized by scipt file >>>'run_analysis.R'<<< 

Further details related to realization above instructions and data processing are described in file >>>'codebook.md'<<<

Final result from last - 5th - instruction is written to text file >>>'tidy_data_set.txt'<<< using write.table() function, which contains also argument: row.names=FALSE.

Summary of delivered files:
=========================================

- 'README.md' - this file, which should be read first

- 'run_analysis.R': R script file, which processing data according to instructions available at Coursera website "Peer-graded Assignment: Getting and Cleaning Data Course Project" 

- 'codebook.md': Code book MD file to indicate and explain calculated variables and summaries 

- 'tidy_data_set.txt': data set in text file, containing final result of last fifth instruction

License:
========
Only for activities related to Coursera course "Getting and Cleaning Data".
