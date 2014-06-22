=====================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
Getting Average Values For Every Combination Of Activity and Subject
=====================================================================

=============
Introduction
=============

This experiment was performed across 30 subjects doing 6 activities which includes walking, laying etc. This experiment calculates the linear acceleration and angular velocity at a constant rate.

Acceleration is measures through accelerometer and Angular velocity through Gyroscope. This experiment is recorded through all three axes (X,Y,Z)

A number of functions such as mean(), std(), min(), max() is calculated for each combination of the Subject-Activity. The calculated data are available. The details of the data are given below

===============
Data details
===============

The files required for this particular analysis are placed in the following location:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


The files placed in the above mentioned location are:

- 'README.txt': Gives an overall view of why and how the observations are obtained

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'test/subject_test.txt': Subject set for test

- 'trin/subject_train.txt': Subject set for train

================
Processing
================

Merges the training and the test sets to create one data set:
-------------------------------------------------------------

1. Unzip the file from the above mentioned location
	
2. Create a new folder Rproject 

3. Copy the files 'activity_labels', 'features' and 'features_info' to Rproject

4. Copy 'Subject_test', 'x_test', 'y_test' from Test folder to Rproject

5. Similarly, do the same step for Train folder

6. Set Rproject as working Directory

Only the above mentioned files are taken because the details of the test and train sets can be obtained from this and there is no need of the other files.

This is known by looking at the description of tables provided above. 

7. These files are imported as text files in R

8. The x test and Y test data has 561 variables of 2947 obs and 1 variable of 2947 obs respectively

9. So, to map the Activities with the values, both these are column binded

10. The same explanation goes true for the train data values as well

11. The features data contains the column names of the x test and y test data and hence they are assigned appropriately

12. Both the datasets obtained above are row binded to obtain a full data set of test and train data with activities

13. The subject test and train values are row binded and then column binded with the final data set which noe has the values mapped to activity and subject


Extracts only the measurements on the mean and standard deviation for each measurement:
---------------------------------------------------------------------------------------

1. A sub function is applied to extract only the columns which has mean() or std() as a part of its name.

2. This is done as we can obtain only the values of mean and std across different axes observations

3. The activity and subject columns are retained


Uses descriptive activity names to name the activities in the data set:
-----------------------------------------------------------------------

1. The activity number with description matching are present in the activity_lables.txt

2. With the help of the above file, the activities are labelled and descriptive values of it are obtained


Appropriately labels the data set with descriptive variable names:
-----------------------------------------------------------------

1. A dataframe caleed replace_df is created which maps the old value with the new value to be replaced

2. A gsub() function is used and all such values are replaced (eg, t-time, f-frequency etc)

3. All "-" values are converted to "_" as we wont be able to reference a column with names that contain "-" as R treats it as minus operator


Creates a second, independent tidy data set with the average of each variable for each activity and each subject: 
-----------------------------------------------------------------------------------------------------------------

1. This data is now made a long data with melt function having Activity and Subject as ids

2. This is now again converted to wide data by taking mean, which is the desired result

3. This data has 180 observarions with 68 variables


=================================================
How is the above obtained final data a tidy data?
=================================================

1. Each variable measured is in one column

2. Each different observation of these variables are in a different row

3. All the variable names are descriptive and human readable


========================