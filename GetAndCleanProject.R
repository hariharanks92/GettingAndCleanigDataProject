
# Reading the files from Working directory
activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")
subject_test <- read.table("subject_test.txt")
subject_train <- read.table("subject_train.txt")
x_train <- read.table("X_train.txt")
x_test <- read.table("X_test.txt")
y_train <- read.table("Y_train.txt")
y_test <- read.table("Y_test.txt")


# Changing column names so that it becomes easy to do cbind, rbind 
colnames(y_test) <- "Activity"
colnames(y_train) <- "Activity"

# Assigning appropriate column names to x_test and train files from the features file
colnames(x_test) <- features$V2
colnames(x_train) <- features$V2

# Doing cbind, rbind to get a complete dataset
# STEP1 - Merges the training and the test sets to create one data set.
test_full <- cbind(y_test, x_test)
train_full <- cbind(y_train, x_train)
test_train <- rbind(test_full, train_full)

subject_full <- rbind(subject_test, subject_train)
colnames(subject_full) <- "Subject"
test_train_v1 <- cbind(subject_full, test_train)

# Removing files to free memory and RAM
rm(features, subject_test, subject_train, x_test, x_train, y_test, y_train, test_full, train_full, subject_full)
rm(test_train)

# STEP2 - Extracts only the measurements on the mean and standard deviation for each measurement
test_train_mean_std_v2 <- test_train_v1[,grep(pattern="mean[(][)]|std[(][)]|Subject|Activity", x=colnames(test_train_v1), ignore.case= TRUE)]

# STEP3 - Uses descriptive activity names to name the activities in the data set
test_train_mean_std_v2$Activity <- factor(test_train_mean_std_v2$Activity, labels=activity_labels[,2])


# Creating a dataframr that has a set of replace values to rename the column names
# in a descriptive way
replace_df <- data.frame("from" = c("BodyBody",
                                    "tBodyAcc-",
                                    "tGravityAcc-",
                                    "tBodyAccJerk-",
                                    "tBodyGyro-",
                                    "tBodyGyroJerk-",
                                    "tBodyAccMag-",
                                    "tGravityAccMag-",
                                    "tBodyAccJerkMag-",
                                    "tBodyGyroMag-",
                                    "tBodyGyroJerkMag-",
                                    "fBodyAcc-",
                                    "fBodyAccJerk-",
                                    "fBodyGyro-",
                                    "fBodyAccMag-",
                                    "fBodyAccJerkMag-",
                                    "fBodyGyroMag-",
                                    "fBodyGyroJerkMag-",
                                    "[(][)]",
                                    "-"
), "to" = c("Body",
            "time_Body_Accelerometer_",
            "time_Gravity_Accelerometer_",
            "time_Body_Accelerometer_Jerk_",
            "time_Body_Gyroscope_",
            "time_Body_Gyroscope_Jerk_",
            "time_Body_Accelerometer_Magnitude_",
            "time_Gravity_Accelerometer_Magnitude_",
            "time_Body_Accelerometer_Jerk_Magnitude_",
            "time_Body_Gyroscope_Magnitude_",
            "time_Body_Gyroscope_Jerk_Magnitude_",
            "frequency_Body_Accelerometer_",
            "frequency_Body_Accelerometer_Jerk_",
            "frequency_Body_Gyroscope_",
            "frequency_Body_Accelerometer_Magnitude_",
            "frequency_Body_Accelerometer_Jerk_Magnitude_",
            "frequency_Body_Gyroscope_Magnitude_",
            "frequency_Body_Gyroscope_Jerk_Magnitude_",
            "",
            "_"
))


# STEP4 - Appropriately labels the data set with descriptive variable names. 
for(i in 1:nrow(replace_df)) {
    colnames(test_train_mean_std_v2) <- gsub(pattern=replace_df[i,1], replacement=replace_df[i,2], x=names(test_train_mean_std_v2))      
}

rm(activity_labels,i)

# STEP5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
test_train_final_v3 <- melt(data=test_train_mean_std_v2, id.vars=colnames(test_train_mean_std_v2)[1:2])
test_train_final_v3 <- dcast(data=test_train_final_v3, Activity + Subject ~ variable, fun.aggregate=mean)

# final tidy dataset - test_trial_final_v3

# Writing to txt file

write.table(x=test_train_final_v3, file="output.txt", sep=",")

# Read the output file
# file_name <- read.table(file="output.txt", sep=",")