# CodeBook - Getting and Cleaning Data Course Project

## Files

File                | Description (dims)
--------------------|-------------------------------------------
y_test.txt          | integer representing which activity is being performed (2947 x 1)
X_test.txt          | matrix of floats between -1 and 1 with accelerometer measurements (2947 x 561)
subject_test.txt    | integers listing which subject performed activity (2947 x 1)
y_train.txt         | integer representing which activity is being performed (7352 x 1)
X_train.txt         | matrix of floats between -1 and 1 with accelerometer measurements (7352 x 561)
subject_train.txt   | integers listing which subject performed activity (7352 x 1)
activity_labels.txt | contains integer/label pairings for activities (6 x 2)
features.txt        | list of column numbers and measurement labels for X_test/train (561 X 2)

## Variables

Variable       | Description
---------------|-------------
y_test         | list of activities for the testing set of data
y_train        | list of activities for the training set of data 
total_y        | total set of activities types (test + training)
X_test         | accelerometer measurements for set of testing data
X_train        | accelerometer measurements for set of training data
total_X        | total set of measurements (test + training)
subject_test   | list of subject performing activities for testing set
subject_train  | list of subject performing activities for training set
total_subjects | total set of subjects (test + training)
activity_labels| description of activity performed, used with total_y
features       | list of measurement labels for total_X columns
col_indices    | vector of column indices where label contains either mean() or std()
subset_X       | subset of total_X, but only with desired columns containing mean() or std()
complete_X     | subset of X, plus subject and activity columns
grouped_data   | mean values of aggregated complete_X

## Transformations

Variable   | Transformation
-----------|-----------------
total_y      | converted labels to factors and then replaced integer with activity description from activity_labels.txt
subset_X     | select columns of total_X where column names contains mean() or std()
complete_X   | column bind subset_X with total_subjects and total_y, rename columns with descriptions from features.txt
features     | remove non-alphanumeric characters and capitalize Mean/Std to make columns more readable
grouped_data | aggregated data by subject/activity type and then calculated average for each measurement
