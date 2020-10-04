---
title: "CodeBook"
author: "Miguel"
date: "4 de octubre de 2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```


In this document the description of variables, data and transformations are divided according to the sequence of the assignment.


#### Selection of training and test sets 

**x_train**: The Training set

**y_train**: The Training label

**subject_train**: this data identifies the subject who performed the activity. (1-30)

**x_test**: The Training set

**y_test**: The Training label

**subject_test**: this data identifies the subject who performed the activity. (1-30)

**feature**: List of all features.

**activity_label**: Links the class labels with their activity name



#### Merges the training and the test sets


- The training sets are merging in a set called **merge_train** in order: subject_train, y_train and x_train.

- The test sets are merging in a set called **merge_test** in order: subject_test, y_test and x_test.

- Finally merge_train and merge_test are merging in one data called **alldata**.



#### Extracts the measurements on the mean and standard deviation.


- Select in **features** data the columns of mean and standard deviation(std), in this part using function **grepl()**. This result (logical) is saved in **mean_std**.

-  Linking **mean_std** with **alldata**, this result is saved in **alldata_mean_std**.




#### Include descriptive variable names to the data set


- Linked the first column is called **SubjectID**, the second **ActivityID** and Third is associated with **mean_std** in **features** data.



#### Creates a independent tidy data set with the average of each variable for each activity and each subject


- Merge **activity labels** with **alldata_mean_std_activity** according **SubjectID**.

- Change **ActivityID** with **activityType**, this data saved in **data_mean_std**

- Generate new data with average of each variable for each activity and each subject.

- Saved final data in **Tydi_data.csv**


Thanks
