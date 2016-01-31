# setwd("/Users/ashwinkalbag/Coursera/Getting and Cleaning Data/final")

# Step 0: Read all files into tables
features <- read.table("features.txt")
activity.labels <- read.table("activity_labels.txt")
training.set <- read.table("train/X_train.txt")
training.set <- training.set[, ]
training.labels <- read.table("train/y_train.txt")
training.subjects <- read.table("train/subject_train.txt")
test.set <- read.table("test/X_test.txt")
test.labels <- read.table("test/y_test.txt")
test.subjects <- read.table("test/subject_test.txt")

# Step 1: Combine rows for training and test sets, labels and subjects
combined.set <- rbind(training.set, test.set)
combined.labels <- rbind(training.labels, test.labels)
combined.subjects <- rbind(training.subjects, test.subjects)

# Step 2: Extract mean and standard deviation measurements
selected.features <- grep('mean|std', features$V2)
reduced.set <- combined.set[, selected.features]

# Step 3: Create labels to name activities in the data set
labels <- merge(combined.labels, activity.labels, sort=FALSE)

# Step 4: Apply descriptive variable names
colnames(reduced.set) <- features$V2[selected.features]

# Transform the reduced set, adding activities and subject columns
reduced.set <- transform(reduced.set, Activity=labels$V2, Subject=combined.subjects$V1)

# Step 5: Create a second tidy dataset from the above, with the average of each variable for each activity and each subject
library("dplyr")
library("tidyr")
tbl <- tbl_df(reduced.set)
tbl <- tbl %>% group_by(Subject, Activity) %>% summarize_each(funs(mean(., na.rm=TRUE)))

# Step 6: Write out the tidy dataset
write.table(tbl, "output_tidyset.txt", row.names=FALSE)