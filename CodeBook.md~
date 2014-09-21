## CodeBook for run_analysis.R script

### Definition of variables used

run\_analysis.R uses the following files found in this repository to identify the feature variable names and human readable activity names

feature names: UCI HAR Dataset/features.txt
This is a 2 column white space delimited file
The first column is the index number of feature
The second column is the feature variable name

activity names: UCI HAR Dataset/activity_labels.txt
This is a 2 column white space delimited file
The first column is the activity key (integer 1 through 6)
The second column is the activity name

### Explanation of functions used
* load_and_merge_datasets() function

the load_and_merge_datasets() function will first load the feature and activity names and use them to generate the activity names and feature variable names

Note that the feature variable names in the final dataset are the exact literal feature names in features.txt and are therefore liberal

i.e. if using read.table(..., col.names = <features names>) will create non-liberal version of name, e.g. tBodyAcc-mean()-X would convert to tBodyAcc.mean...X which makes it harder to do some automation of column searching, see below

there are three datasets loaded per dataset group (\* = training, test):
subject_*_data: the subject id number associated to a feature vector measurement
y_*_data: the activity key number associated to a feature vector measurement
X_*_data: the 561 valued feature vector containing HAR data

Initial merging is a cbind of the subject data "subject.id", activity data "activity.number", and the actual feature vector data and outputs a merged data set merge_*_data

To apply labels, we use the merge function to combine the activity names by activity number to the merge_*_data

A final merge of the test and training data is achieved via rbind because of the identical column structure to generate "master_dataset"

The master_dataset is then further subsetted by using the grep function to dfind all mean() and std() columns as defined by the feature_info.txt file and this is the final return output of the load and merge function


* tidy_HAR(dataset) function

The subsetted master_dataset from the load and merge operation is fed to thetidy_HAR(dataset) function and a final resulting tidy_dataset is outputted that contains the mean of each variable grouped by subject and then by activity

* run_UCI_HAR_analysis() function

This is a wrapper function to execute both the load extract and transform functions on the data
