---
title: "README"
author: "Miguel"
date: "4 de octubre de 2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```


This is an R Markdown document. This part describes the variables, data and transformations.

The assignment has four parts:

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

3. Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.

4. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#### 1. Create dataset with training and test sets 

#### Procedure: Extract sets of Dataset

```{r eval=FALSE}
x_train <- read.table(file.path("UCI HAR Dataset","train","X_train.txt"), header = FALSE)
y_train <- read.table(file.path("UCI HAR Dataset","train","y_train.txt"), header = FALSE)
subject_train <- read.table(file.path("UCI HAR Dataset", "train", "subject_train.txt"), header = FALSE)
x_test <- read.table(file.path("UCI HAR Dataset","test","X_test.txt"), header = FALSE)
y_test <- read.table(file.path("UCI HAR Dataset","test","y_test.txt"), header = FALSE)
subject_test <- read.table(file.path("UCI HAR Dataset","test","subject_test.txt"), header = FALSE)
features <- read.table(file.path("UCI HAR Dataset","features.txt"), header = FALSE)
activity_labels <- read.table(file.path("UCI HAR Dataset","activity_labels.txt"), header = FALSE)
```
#### Description of variables
**x_train**: The Training set

**y_train**: The Training label

**subject_train**: this data identifies the subject who performed the activity. (1-30)

**x_test**: The Training set

**y_test**: The Training label

**subject_test**: this data identifies the subject who performed the activity. (1-30)

**feature**: List of all features.

**activity_label**: Links the class labels with their activity name

#### Procedure: Merges the training and the test sets

- The training sets are merging in a set called **merge_train** in order: subject_train, y_train and x_train.

- The test sets are merging in a set called **merge_test** in order: subject_test, y_test and x_test.

- Finally merge_train and merge_test are merging in one data called **alldata**.

```{r eval = FALSE}
merge_train <- cbind(subject_train, y_train, x_train)
merge_test <- cbind(subject_test, y_test, x_test)
alldata <- rbind(merge_train,merge_test)
```

#### 2. Extracts the measurements on the mean and standard deviation.

#### Procedure:
- Select in **features** data the columns of mean and standard deviation(std), in this part using function **grepl()**. This result (logical) is saved in **mean_std**.

-  Linking **mean_std** with **alldata**, this result is saved in **alldata_mean_std**.

```{r eval = FALSE}
mean_std <- grepl("mean", features[,2])|grepl("std", features[,2])
alldata_part <- alldata[,3:563]
alldata_part2 <- alldata_part[,mean_std == TRUE]
alldata_mean_std <- cbind(alldata[,1:2],alldata_part2)
```

#### 3. Include descriptive variable names to the data set

#### Procedure:

- Linked the first column is called **SubjectID**, the second **ActivityID** and Third is associated with **mean_std** in **features** data.

```{r eval = FALSE}
names(alldata_mean_std) <- "SubjectID"
names(alldata_mean_std)[2] <- "ActivityID"
names(alldata_mean_std)[3:81] <- features[mean_std == TRUE,2]
```

#### 4. Creates a independent tidy data set with the average of each variable for each activity and each subject

#### Procedure: Merge activity labels in data

- Merge **activity labels** with **alldata_mean_std_activity** according **SubjectID**.

- Change **ActivityID** with **activityType**, this data saved in **data_mean_std**

- Generate new data with average of each variable for each activity and each subject.

- Saved final data in **Tydi_data.csv**

```{r eval = FALSE}
colnames(activity_labels) <- c('ActivityID','activityType')
alldata_mean_std_activity <- merge(alldata_mean_std, activity_labels, by.y = "ActivityID")
data_mean_std <- alldata_mean_std_activity[,c(2,82,3:81)]
Tidy_data <- aggregate(.~ SubjectID + activityType, data = data_mean_std, FUN = mean)
write.csv(Tidy_data, "Tidy_data.csv", row.names = FALSE)
```

The end
