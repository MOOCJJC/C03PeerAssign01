## Create working directory and set it as current working directory
if (!file.exists("C03A01")) dir.create("./C03A01")
setwd("./C03A01")

## download the file from internet
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("rawdata.zip")) download.file(fileurl, "./rawdata.zip", mode="wb")

## unzip the dataset
unzip("./rawdata.zip")

## read the dataset (subject,feature(X),activity(y))
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

## read feature names
featureNames <- read.table("./UCI HAR Dataset/features.txt")

## Assign the new column name to the data frames
names(X_train) <- featureNames$V2
names(X_test) <- featureNames$V2

names(y_train) <- "ActNum"
names(y_test) <- "ActNum"

names(subject_train) <- "Subject"
names(subject_test) <- "Subject"

## read the activity labels
actLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")

## Assign the labels to the activity numbers
y_train_label <- merge(y_train,actLabels,by.x="ActNum",by.y="V1",sort=FALSE)
y_test_label <- merge(y_test,actLabels,by.x="ActNum",by.y="V1",sort=FALSE)

names(y_train_label) <- c("ActNum","ActName")
names(y_test_label) <- c("ActNum","ActName")

## Use "grep" command to scan through the feature names and return the index for
## column selection
indexMeanStd <- grep("mean\\(\\)|std\\(\\)", featureNames$V2, value=FALSE)

## Step 1: "Merges the training and the test sets to create one data set."
All_train <- cbind(subject_train, y_train_label, X_train)
All_test <- cbind(subject_test, y_test_label, X_test)
All_Data <- rbind(All_train, All_test)

## Step 2: "Extracts only the measurements on the mean and standard deviation
##          for each measurement."
dataMeanStd <- All_Data[, c(1,2,3,(indexMeanStd + 3))]

## Step 3: "Uses descriptive activity names to name the activities in the data set."
## HAS BEEN DONE IN PREPROCESSING

## Step 4: "Appropriately labels the data set with descriptive activity names."
## HAS BEEN DONE IN PREPROCESSING

## Step 5: "Creates a second, independent tidy data set with the average of 
##          each variable for each activity and each subject." 

## Combine column "subject" and "ActName" to a new column "subAct"
subAct <- paste(dataMeanStd$Subject,dataMeanStd$ActName, sep=" ")
dataMeanStd <- cbind(dataMeanStd, subAct)

## Split the dataset "dataMeanStd" according the levels of "subAct"
sDataMeanStd <- split(dataMeanStd[,4:69], dataMeanStd$subAct)

## Get measurement means for every "subAct"
sDataMeasMean <- lapply(sDataMeanStd, colMeans)

## unlist the splitted dataset and form a data frame
dataMeasMean <- NULL
for (idx in 1:length(sDataMeasMean)) {
	dataMeasMean <- rbind(dataMeasMean, sDataMeasMean[[idx]])
}

## Convert the matrix to data.frame
dfData <- data.frame(dataMeasMean)

## Add the subject activity names
dfData <- cbind(names(sDataMeasMean), dfData)

## Final revision on the column name "Subject Activity"
colnames(dfData)[1] <- "Subject Activity"

## Save the final result "dfData" data.frame
write.csv(dfData,"./tidyData.csv")



