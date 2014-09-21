## Analysis on UCI Human Activity Recognition Data

###Scripts provided
The script provided, "run\_analysis.R", will specifically load human activity recognition (HAR) datasets obtained from UCI's Center for Machine Learning and Intelligent Systems Machine Learning Repository

source: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The script will output a tidy dataset containing mean and std. dev. values from a 561 variable "feature vector" summarized by subject and activity type, e.g. Subject ID 1, WALKING, \<variable value, e.g. "tBodyAcc-mean()-X"\>

The script is specific to the UCI HAR dataset and to the directory structure of this repo

To run the script in R do the following:
1) point to the cloned repo on your local machine
2) load script via > source("run\_analysis.R")
3) execute function via > run\_UCI\_HAR\_analysis\(\)
It is a lot of data for the command line so should store into a variable e.g. tidy\_HAR\_data to manage
