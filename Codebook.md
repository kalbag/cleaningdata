# Code Book for Human Activity Recognition Using Smartphones Dataset

## Description of Experiment
One of the most exciting areas in all of data science right now is wearable computing - see for example this article.
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.
These experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years.
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and
3-axial angular velocity were captured at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually.
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the
training data and 30% the test data.  A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Location of Input Datasets
The data for the project were downloaded from the website below:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## How the Tidy Data Set is Created

A script called run_analysis.R, also provided in this Github repository, manipulates the input datasets taken from the downloaded zip file
as follows:

### Step 0
The script run_analysis.R assumes all files are in the current working directory.
It reads all files into tables as the initial step.

### Step 1 
It then combines the training and test data sets, using rbind, to create a table with all rows from both the training and test data sets.

### Step 2
It then builds a reduced set of columns by selecting only columns whose names represent a "mean" or "std" (standard deviation) as requested.
It does not select columns such as (559) angle(X,gravityMean), where it is a bit ambiguous whether this observation represents a mean.
It does this by building a vector of column indices with the requested features, and then subsetting the data frame by those columns.

### Step 3
Next, it creates activity labels to name the activities in the data set.
It merges the two tables containing the activity names and the activity numbers, using the numbers column.

### Step 4
Next it applies column names using descriptive feature names from the selected features.
After this, it uses the transform function to add Activity and Subject columns to the reduced set.

### Step 5
It uses the dplyr and tidyr libraries to create a table from the data frame, use the group_by function
to group the reduced column variables by Subject and Activity and then summarize_each to apply the mean to each group.
Finally, it writes the summarized table out to a file called "output_tidyset.txt".
