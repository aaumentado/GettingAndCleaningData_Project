## this is a wrapper function
## to execute necessary functions
## to obtain tidy data set

run_UCI_HAR_analysis <- function() {
	
	## obtain raw data
	raw_data <- load_and_merge_datasets()
	
	## transform raw_data to tidy data
	tidy_data <- tidy_HAR(raw_data)
	
	return(tidy_data)
}

## this function takes the UCI
## HAR training and test datasets
## and merges into one single dataset
## it will also subset the mean and stdev values
## from the feature vector and apply human readable labels
## to the activities and feature variables
load_and_merge_datasets <- function() {
	# load features variable name list for datasets
	# 1st column is the feature number and the 2nd column is the feature name
	feature_variables <- read.table("./UCI HAR Dataset/features.txt")
	
	# make human readable names
	names(feature_variables) <- c("feature.number","feature")
		
	# load activity labels for dataset
	# 1st column is the activity number and the 2nd column is the activity name
	activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
	names(activity_labels) <- c("activity.number","activity")
	
	## load and merge training set
	## note each read.table defaults work for proper loading of files
	
	# each row has a subject number, column name should be subject.number
	subject_training_data <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names="subject.number")
	
	# load in training data as numeric for computational purposes
	# each row is a 561 vector
	X_training_data <- read.table("./UCI HAR Dataset/train/X_train.txt",colClasses="numeric")
	
	# use liberal names for feature variable names
	# this is easier later on for selecting variables based on a feature list
	names(X_training_data) <- feature_variables$feature
	
	# each row has an activity label	
	Y_training_data <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names="activity.number")
	
	# combine data by columns
	merge_training_data <- cbind(subject_training_data, Y_training_data, X_training_data)
	
	# merge activity names and training data by activity number
	merge_training_data <- merge(activity_labels, merge_training_data, by.x="activity.number",by.y="activity.number")

	# load and merge test data set
	# analogous operations to training set load and merge
	subject_test_data <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names="subject.number")
	
	X_test_data <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names=feature_variables[,2], colClasses="numeric")
	names(X_test_data) <- feature_variables$feature
	
	Y_test_data <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names="activity.number")
	
	merge_test_data <- cbind(subject_test_data, Y_test_data, X_test_data)
	merge_test_data <- merge(activity_labels, merge_test_data, by.x="activity.number",by.y="activity.number")
	
	# generate master dataset using rbind
	master_dataset <- rbind(merge_test_data, merge_training_data)
#	print(names(master_dataset))
	
	# determine mean and std column numbers from features list
	# note '\\' is escape character to allow use of '(' and ')'	
	mean_variables_colnum <- grep("mean\\(\\)", feature_variables$feature)
	stdev_variables_colnum <- grep("std\\(\\)", feature_variables$feature)
	
	# need to convert to character from factor for some reason
	mean_variables_colnames <- as.character(feature_variables$feature[mean_variables_colnum])
	stdev_variables_colnames <- as.character(feature_variables$feature[stdev_variables_colnum])
	
	# subset master_dataset based on subject.number, activity.number, activity, mean and std deviation columns
	subset_master_dataset <- master_dataset[,c("activity", "activity.number", "subject.number", mean_variables_colnames, stdev_variables_colnames)]

	return(subset_master_dataset)
}

## tidy version of merge_dataset
## this function will take the dataset
## created in load_and_merge_datasets
## and generate a final dataset with average data
## by activity and subject
tidy_HAR <- function(dataset) {
	# access the plyr package
	library(plyr)
	
	## use ddply to do a mean over each numeric column
	## grouped by subject number and subgrouped by activity 
	tidy_dataset <- ddply(dataset, .(subject.number, activity), numcolwise(mean))
	
	return(tidy_dataset)
	
}

## helpful notes
## read in the data using "read.table" as is, delimiter is white space
## and is handled by default

## can use "grep" to find matches to the mean and std variables
## the returned vectors can be used to subset the data sets