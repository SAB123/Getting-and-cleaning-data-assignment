datasciencecoursera
===================

Created for Get and Clean Data course

#     Getting & Cleaning Data Project  Readme.md 20.06.2014

    Written using version 3.0.3 of R, version 0.98.501 of R Studio
    and the Windows 8 operating system.

###	 INPUT
Original data taken from the course assignment web-site at
https://class.coursera.org/getdata-004/hman_grading/view/courses/972137/assessments/3/submissions
and copied to the working directory. This in turn came from 
the accelerometers from the Samsung Galaxy S smartphone at
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

###	 OUTPUT
	 narrow_tidy_data.txt in the working directory
	 


This contains a general description of the processing of the data as per Community PA 
Scott Von Kleeck's posting in Readme and Codebook.


###   read in the data - assumes files are in working directory

Use read.table() to get training data from subject_train.txt, trainy_train.txt, 
the test data from subject_test.txt X_test.txt y_test.txt and the list of 
variable names for X_train and X_test from Features.txt.
Extract the variable names as character strings to use to make the data.frame names.

Use variable names to name all the columns in the X_test and X_train data sets to 
enable the later data processing, make header for y_train & y_test Activity and 
make header for train_subject and test_subject Subject.

Combine the train and test data to form seperate training and test data frames. The 
test data.frame contains 2947 observations of 563 variables, the training data.frame 
contains 7352 observations of 563. Then combine them both into the all_data data.frame
containing 10299 observations and 563 variables.


### get just columns with names containing mean or std, excluding meanFreq

Use grepl to extract all data columns with 'mean' in the name, this is why
the columns needed variable names early on. This results in a data.frame with 46 
variables or columns. Remove all the columns with meanFreq in the name, leaving 33 columns.
Extract all data columns with std in the name, giving 33 columns of data.
Combine std and mean data and as subject and activity removed add those too.
Now have the first tidy data.frame with 10299 obs and 68 variables


### Give the activity column names rather than numbers

Cast the activities column into factors rather than integers, then change the 
factor numbers to activities in activities.txt - only 6 so do individually 
rather than programmatically. 

Order the data using the columns subject and activity


### Get the average for each activity per subject 

Reorder the data using melt() to get long thin table with 679734 observations of the 
4 variables, subject, activity, measurement and value.

Get the mean of the measurement data for each activity for each subject reducing 
the data to a wide tidy data set of 180 observations of 68 variables - one row for 
each subject and activity, each with many measurements. At this point I chose to 
leave variable names as they are for this data frame rather than make them more 
readable as they will provide an audit trail back to the original data.

Reorder the data again using melt() to get a long thin tidy data set with
11880 observations of 4 variables one row for each subject, activity and measurement type.
Not sure whether to use the wide or narrow data set, but both are available if
required. The header names for columns 3 and 4 are now no longer meaningful so change them
to measurement_type and measurement.

Use write.table() to write the narrow data frame to the file narrow_tidy_data.txt 
in the working directory.
