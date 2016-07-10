## This script is in fulfilment of assignment 4 in the "Getting and Cleaning Data
## course which is part of the John Hopkins University Data Science specialization

## This scripts reads in sensor data collected from Samsung S phones and performs
## merge and clean operations

library("dplyr") # load the dplyr library for easier manipulation of data

#change directory to the data folder
setwd("/media/NewVolume/Coursera/JHUDataScienceSpecialization/gettingandcleaningdata/assignment4/UCI HAR Dataset/")

#load the train data
trainx <- read.table("./train/X_train.txt", sep = "",header = FALSE)

#load the test data
testx <- read.table("./test/X_test.txt", sep = "",header = FALSE)

# load the column names
colNames <- read.csv("features.txt", sep=" ",header = F)

#load the activity name mapping
activities <- read.csv("activity_labels.txt", sep=" ",header = F)

#read the train subject data
subject_train <- read.csv("train/subject_train.txt", header = F)

#read the test subject data
subject_test <- read.csv("test/subject_test.txt", header = F)

#combine the subject data with the train and test datasets
trainx <- cbind(subject_train, trainx)

testx <- cbind(subject_test, testx)

#we remove the numbering column from the column names which is not required
colNames <- colNames[,2]

#replace all activity numbers in the column names with their mapped names
for (i in 1:6)
  {colNames <- sub(paste0("[)|,]", activities[i,1], "$"), activities[i,2], colNames)}

#The names are in a mess. Assign clean unique names
colNames <- make.names(colNames, unique=TRUE, allow_ = TRUE)

#merge the train and test datasets
dat <- rbind(trainx, testx)

#convert to a tbl_df for dplyr operations
dat <- tbl_df(dat)

#name the data column names with the names from the columns data
names(dat) <- colNames

# select only fields relating to mean or standard deviation
# i.e. that have mean or std in them
dtMeanStd <- dplyr::select(dat, matches("mean|std"))

#check the name of the subject column
names(dtMeanStd)[1] <- "subject"
  
#Calculate averages for each variable for each activity and each subject
dtSubj <- split(dtMeanStd, dtMeanStd$subject)

#calculate the column means for each subject
dtSubjMeans <- sapply(dtSubj, colMeans)

dtSubjMeans <- t(dtSubjMeans)

write.table(dtSubjMeans, "output.csv", row.names = F, sep = ",")
