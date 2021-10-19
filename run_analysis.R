library(dplyr)

## load and combine the x, y, and subject test/train sets
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
total_y <- rbind(y_test, y_train)

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
total_X <- rbind(X_test, X_train)

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
total_subjects <- rbind(subject_test, subject_train)

# convert y values to factors, and rename using labels from activity_labels.txt
total_y$V1 <- factor(total_y$V1)
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
levels(total_y$V1) <- factor(activity_labels$V2)

# extract column indices of table x containing mean() or std()
features <- read.table("./UCI HAR Dataset/features.txt")
col_indices <- grep(".[Mm]ean\\(.|.std\\(.", features$V2)
subset_X <- select(total_X, col_indices)

# add subject/activity type to table containing measurement data
complete_X <- cbind(subset_X, total_subjects, total_y)

# rename feature columns with descriptive titles
features$V2 <- gsub('[-()]', '', features$V2)
features$V2 <- gsub('mean', 'Mean', features$V2)
features$V2 <- gsub('std', 'Std', features$V2)
features$V2 <- sub('^t','Time', features$V2)
features$V2 <- sub('^f','Freq', features$V2)
colnames(complete_X) <- c(features$V2[all_of(col_indices)], 
                                   'Subject', 
                                   'Activity')

# group aggregated data by subject and activity and calculate mean across all
# the different measurement columns
grouped_data <- complete_X %>% 
                group_by(Subject, Activity) %>%
                summarize_all(funs(mean))

