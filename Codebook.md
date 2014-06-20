##     Getting & Cleaning Data Project  Codebook 20.06.2014

Program written using version 3.0.3 of R, version 0.98.501 of R Studio
and the Windows 8 operating system.

###INPUT
Original data taken from the course assignment web-site at
https://class.coursera.org/getdata-004/human_grading/view/courses/972137/assessments/3/submissions
downloaded on 10.06.2014 and copied to the working directory. This in turn came from 
the accelerometers from the Samsung Galaxy S smartphone at
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
A full description of the original data is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones, I have not 
included this information here incase of duplication errors.

###OUTPUT
narrow_tidy_data.txt in the working directory, overwritten each time, this can be read into R using
	read.table("narrow_tidy_data.txt") providing it is in the working directory
 

####The files downloaded are:

*	The training data - subject_train.txt (subject ids), X_train.txt (movement vectors) y_train.txt (activity ids)
*	The test data - subject_test.txt (subject ids) X_test.txt (movement vectors) y_test.txt (activity ids)
*	Features.txt containing the list of variable names used for X_train and X_test, these 
	names were not changed during processing so that they can provide an audit trail back to the 
	original data and are found in the 'Movement_type' column of the output data.
*	Activities.txt provided the list of Activities and their level.

####libraries required
*	plyr
*	reshape2

####Variables used in the code:

Generally names kept as close to the original as possible.

The original data was read into the following data.frames
*	X_test - data from X_test.txt
*	y_test - data from y_test.txt
*	test_subject - data  from subject_test.txt
*	X_train - data from X_train.txt
*	y_train - data from y_train.txt
*	train_subject - data  from subject_train.txt
*	activities - data from activity_labels.txt
*	features - data from features.txt 

####Variables used during processing - 
each time the data was changed it was written to a different data set with a name reflecting the changes made

*	VarNames - list of character strings containing the names for the X_test and X_train data  
		taken from the second column of activities
*	train - data.frame containing the combined train data
*	test - data.frame containing the combined test data
*	all_data - data.frame containing the combined test and train data
*	m_data - data.frame containing the columns from all_data with 'mean' in the name
*	mean_data - data frame containing m_data with 'meanFreq' columns removed
	(This appeared to be the general consensus from the discussion forum)
*	std_data - data frame containing just the columns from all_data with 'std' in the name
*	tidy_data - data frame containing the combined subject, activity, mean_data and std_data
*	mtd - data frame containing the first melt of tidy_data into 679734 observations 
	of the 4 variables, subject, activity, variable and value
*	wide_tidy_data - data frame cast from mtd, containing the average data for each movement
	it has 180 observations of 68 variables, one row for each subject and activity, 
	with 66 measurements for each.
*	narrow_tidy_data - dataframe melted from wide_tidy_data, containing 
	11880 observations of 4 variables, one row for each subject, activity and measurement type

####Output

narrow_tidy_data.txt - text file containing the narrow_tidy_data dataframe, each output overwrites 
	the previous one
 
####Summary choices made

*	read.table() used to read all the data into the program from txt files
*	names() used to add the column names to subject_train, X_train, y_train, subject_test, X_test,
	y_test and to change column 3 and 4 names in the narrow_tidy_data dataframe 
*	cbind() used to combine the subject_train, X_train y_train to form train and the 
	subject_test X_test y_test to form test.
*	rbind() used to combine the test and train dataframes
*	grepl() used to extract the mean and std data from all_data
*	cbind() used to combine the subject, activity, mean and std dataframes
*	levels() used to name the activities
*	melt() used to create a long thin table to use dcast() on to get the means and to produce narrow_tidy_data
*	dcast() used with mean() to get the activity means
*	write.table() used to output the narrow_tidy_data.txt file into the working directory.





