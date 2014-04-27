## Coursera: Getting and Cleaning Data
### Peer Assessment Assignment 01
===============

#### Introduction

This file provide the detailed steps of how I combined dataset from different source files, labeled the columns, selected the columns (features). The original datasets themselves are very clean. There is no `NA`, `NaN`, or `NULL`. And the column numbers were matched correctly.

This document has been divided into three parts: the pre-processing, steps following the project instruction, and a peek on the final running results.

#### Pre-processing

Create working directory and set it as current working directory:

```
if (!file.exists("C03A01")) dir.create("./C03A01")
setwd("./C03A01")
```

Download the file from internet:
```
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("rawdata.zip")) download.file(fileurl, "./rawdata.zip", mode="wb")
```

Unzip the dataset at local working directory:
```
unzip("./rawdata.zip")
```

Read the dataset (subject,feature(X),activity(y))
```
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
```

Read feature names
```
featureNames <- read.table("./UCI HAR Dataset/features.txt")
```

Assign the new column name to the data frames
```
names(X_train) <- featureNames$V2
names(X_test) <- featureNames$V2

names(y_train) <- "ActNum"
names(y_test) <- "ActNum"

names(subject_train) <- "Subject"
names(subject_test) <- "Subject"
```

Read the activity labels
```
actLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
```

Assign the labels to the activity numbers
```
y_train_label <- merge(y_train,actLabels,by.x="ActNum",by.y="V1",sort=FALSE)
y_test_label <- merge(y_test,actLabels,by.x="ActNum",by.y="V1",sort=FALSE)

names(y_train_label) <- c("ActNum","ActName")
names(y_test_label) <- c("ActNum","ActName")
```

Use "grep" command to scan through the feature names and return the index for column selection
```
indexMeanStd <- grep("mean\\(\\)|std\\(\\)", featureNames$V2, value=FALSE)
```

#### Following the steps given by the instructor

##### Step 1: "Merges the training and the test sets to create one data set."
```
All_train <- cbind(subject_train, y_train_label, X_train)
All_test <- cbind(subject_test, y_test_label, X_test)
All_Data <- rbind(All_train, All_test)
```

##### Step 2: "Extracts only the measurements on the mean and standard deviation for each measurement."
```
dataMeanStd <- All_Data[, c(1,2,3,(indexMeanStd + 3))]
```

##### Step 3: "Uses descriptive activity names to name the activities in the data set."
HAS BEEN DONE IN PREPROCESSING


##### Step 4: "Appropriately labels the data set with descriptive activity names."
HAS BEEN DONE IN PREPROCESSING

##### Step 5: "Creates a second, independent tidy data set with the average of each variable for each activity and each subject." 

Combine column "subject" and "ActName" to a new column "subAct"
```
subAct <- paste(dataMeanStd$Subject,dataMeanStd$ActName, sep=" ")
dataMeanStd <- cbind(dataMeanStd, subAct)
```
Split the dataset "dataMeanStd" according the levels of "subAct"
```
sDataMeanStd <- split(dataMeanStd[,4:69], dataMeanStd$subAct)
```

Get measurement means for every "subAct"
```
sDataMeasMean <- lapply(sDataMeanStd, colMeans)
```

Unlist the splitted dataset and form a data frame
```
dataMeasMean <- NULL
for (idx in 1:length(sDataMeasMean)) {
	dataMeasMean <- rbind(dataMeasMean, sDataMeasMean[[idx]])
}
```
Convert the matrix to data.frame
```
dfData <- data.frame(dataMeasMean)
```

Add the subject activity names
```
dfData <- cbind(names(sDataMeasMean), dfData)
```

Final revision on the column name "Subject Activity"
```
colnames(dfData)[1] <- "Subject Activity"
```

Save the final result "dfData" data.frame
```
write.csv(dfData,"./tidyData.csv")
```


#### Running results of script "run_analysis.R"

	> source.with.encoding('./Git_local/MOOCJJC/C03PeerAssign01/run_analysis.R', encoding='UTF-8')
	trying URL 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
	Content type 'application/zip' length 62556944 bytes (59.7 Mb)
	opened URL
	downloaded 59.7 Mb
	
	> dfData[1:10,1:4]
	        Subject Activity tBodyAcc.mean...X tBodyAcc.mean...Y tBodyAcc.mean...Z
	1             1 STANDING         0.2656969       -0.01829817        -0.1078457
	2              10 LAYING         0.2761672       -0.01635976        -0.1108960
	3             10 SITTING         0.2778939       -0.02010073        -0.1119239
	4             11 SITTING         0.2765853       -0.01912725        -0.1089418
	5              12 LAYING         0.2736087       -0.01833720        -0.1066491
	6              13 LAYING         0.2753313       -0.01381421        -0.1027438
	7             13 WALKING         0.2759723       -0.01816997        -0.1100008
	8             14 SITTING         0.2701846       -0.01625482        -0.1009859
	9              15 LAYING         0.2767741       -0.01824301        -0.1123075
	10            15 SITTING         0.2808090       -0.01325707        -0.1130254
	>
 