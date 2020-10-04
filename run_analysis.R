# Title : Final Assignment
# Course: Getting and cleaning data
#
#
# Unzip(zipfile = "Dataset.zip")
# Load and Unzip files
files <- list.files("UCI HAR Dataset", recursive = TRUE)
#
#Extract set of unzipped files about test and train
x_train <- read.table(file.path("UCI HAR Dataset","train","X_train.txt"), header = FALSE)
y_train <- read.table(file.path("UCI HAR Dataset","train","y_train.txt"), header = FALSE)
subject_train <- read.table(file.path("UCI HAR Dataset","train","subject_train.txt"), header = FALSE)
x_test <- read.table(file.path("UCI HAR Dataset","test","X_test.txt"), header = FALSE)
y_test <- read.table(file.path("UCI HAR Dataset","test","y_test.txt"), header = FALSE)
subject_test <- read.table(file.path("UCI HAR Dataset","test","subject_test.txt"), header = FALSE)
features <- read.table(file.path("UCI HAR Dataset","features.txt"), header = FALSE)
activity_labels <- read.table(file.path("UCI HAR Dataset","activity_labels.txt"), header = FALSE)
#
# 1. Merging this data to create one data set called "alldata"
merge_train <- cbind(subject_train, y_train, x_train)
merge_test <- cbind(subject_test, y_test, x_test)
alldata <- rbind(merge_train,merge_test)
#
# 2. Extracts only measure about mean and standard deviation 
mean_std <- grepl("mean", features[,2])|grepl("std", features[,2])
alldata_part <- alldata[,3:563]
alldata_part2 <- alldata_part[,mean_std == TRUE]
alldata_mean_std <- cbind(alldata[,1:2],alldata_part2)
#
# 3. Include descriptive variable names to the data set
names(alldata_mean_std) <- "SubjectID"
names(alldata_mean_std)[2] <- "ActivityID"
names(alldata_mean_std)[3:81] <- features[mean_std == TRUE,2]
#
# 4. Creates a data with the average of each variable for each activity and each subject
colnames(activity_labels) <- c('ActivityID','activityType')
alldata_mean_std_activity <- merge(alldata_mean_std, activity_labels, by.y = "ActivityID")
data_mean_std <- alldata_mean_std_activity[,c(2,82,3:81)]
Tidy_data <- aggregate(.~ SubjectID + activityType, data = data_mean_std, FUN = mean)
#
write.table(Tidy_data, "Tidy_data.txt", row.name=FALSE)
# Thanks