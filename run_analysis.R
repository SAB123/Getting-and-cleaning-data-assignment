########################################################
####     Getting & Cleaning Data Project
########################################################
getwd()
setwd("GCD_Assignment")
getwd()

########################################################
###   read in the data - assumes files are in working directory
########################################################

### get training data
train_subject<-read.table("./Data/train/subject_train.txt", quote = "\"'", 
               na.strings = "NA",blank.lines.skip = TRUE)
X_train<-read.table("./Data/train/X_train.txt")
y_train<-read.table("./Data/train/y_train.txt")

### get test data
test_subject<-read.table("./Data/test/subject_test.txt")
X_test<-read.table("./Data/test/X_test.txt")
y_test<-read.table("./Data/test/y_test.txt")

## get Features.txt for X_train/test variable names
features<-read.table("features.txt",header = FALSE, sep = "", quote = "\"'" )

## get just names and convert to character 
VarNames<-as.character(features[,2])

## get activities
activities<-read.table("activity_labels.txt")


########################################################
### Merge data to form training and test data then all data
### Giving columns names is done here
########################################################

## add headers from features.txt the column names in x_train & test
names(X_train)<-VarNames
names(X_test)<-VarNames

## header for y_train & test
names(y_test)<- "Activity"
names(y_train)<- "Activity"

## header for subject 
names(train_subject) <- "Subject"
names(test_subject) <- "Subject"

## combine all test data test contains 2947 obs. of 563 var
test<-cbind(test_subject,y_test,X_test, deparse.level=1)

## combine all the training data
train<-cbind(train_subject,y_train,X_train, deparse.level=1)

## combine training and test data
all_data<-rbind(train,test)

## should now have a data frame with 563 variables and 10 299 observations

########################################################
## now get just columns with names containing mean or std
########################################################

## 46 variables
m_data<-all_data[grepl("mean", names(all_data), ignore.case = FALSE, perl = FALSE,
                                 fixed = FALSE, useBytes = FALSE)]
## removes meanFreq variables - 33 variables
mean_data<-m_data[!grepl("meanFreq", names(m_data), ignore.case = FALSE, perl = FALSE,
                               fixed = FALSE, useBytes = FALSE)]

## 33 variables
std_data<-all_data[grepl("std", names(all_data), ignore.case = FALSE, perl = FALSE,
                               fixed = FALSE, useBytes = FALSE)]

## combine std and mean data n.b. subject and activity removed so also have to add those too

tidy_data<-cbind(all_data[,1:2], mean_data, std_data)  ## 10299 obs of 68 variables

########################################################
### Give the activity column names rather than numbers
########################################################

## make activities column into factors
tidy_data[,2]<- as.factor(tidy_data[,2])

## change the factor numbers to activities - only 6 so do individually
levels(tidy_data[,2])[1] <- "WALKING"
levels(tidy_data[,2])[2] <- "WALKING_UPSTAIRS"
levels(tidy_data[,2])[3] <- "WALKING_DOWNSTAIRS"
levels(tidy_data[,2])[4] <- "SITTING"
levels(tidy_data[,2])[5] <- "STANDING"
levels(tidy_data[,2])[6] <- "LYING"

## order the data using subject and activity
library(plyr)
tidy_data<-arrange(tidy_data, Subject, Activity)

########################################################
## Get the average for each activity per subject - 30 x 5 rows
########################################################
library(reshape2)

## melt data to get long thin table with 4 var (subject activity, measurement and value)
mtd<-melt(tidy_data, id=c("Subject", "Activity"))

## get the mean of the measurement data - 
## 180 obs of 68 variables - one row for each subject and activity, with many measurements
## leave variable names as they are
wide_tidy_data<-dcast(mtd, Subject + Activity ~ variable, mean)


# 11880 obs of 4 var one row for each subject, activity and measurement type
narrow_tidy_data <- melt(wide_tidy_data, id=c("Subject", "Activity"))

# change names of variables to make them more meaningful
names(narrow_tidy_data)[3]<- "measurement_type"
names(narrow_tidy_data)[4]<- "measurement"

## write the narrow data set to file for project, row_names=FALSE stops the rows being numbered 
write.table(narrow_tidy_data,file="narrow_tidy_data.txt", row.names= FALSE, append=FALSE)

