
library("tidyr")
library("dplyr")


### ---- read and build a tidy data set for each user and activity for all mean/std features ----
##
# This is an R script called run_analysis.R that does the following. 
#  1) Reads in the data sets (data folder "UCI HAR Dataset" assumed to be in you working dirrecotry)
#  2) Merges the training and the test sets to create one data set.
#  3) Uses descriptive activity names to name the activities in the data set. 
#  4) Extracts only the measurements on the mean and standard deviation for each measurement. 
#  5) Appropriately labels the data set with descriptive variable names. 
#  6) From the data set in step 5, creates a second, independent tidy data set 
#     with the average of each variable for each activity and each subject.
#
# Date is at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# it is assumed (per instructions) that the data folder resides in you current working dirrectory 
home.path <- getwd()

# build a path and read in activity lables
new.path <- file.path(home.path,"UCI HAR Dataset", "activity_labels.txt")
activity.lables <- read.table(new.path, header=FALSE, col.names=c("act.num","activity"))

# read in feature list, clean up and then store as a vectore for data set col names
new.path <- file.path(home.path, "UCI HAR Dataset", "features.txt")
features <- read.table(new.path, header=FALSE, col.names=c("feat.num","feature"),colClasses = "character")
features <- gsub("[()]","", features$feature)

# read train and test activity files and bind/stack together
new.path <- file.path(home.path, "UCI HAR Dataset", "train","y_train.txt")
train.activities <- read.table(new.path, header=FALSE, col.names="act.num")
new.path <- file.path(home.path, "UCI HAR Dataset", "test","y_test.txt")
test.activities <- read.table(new.path, header=FALSE, col.names="act.num")

activities <-rbind(train.activities, test.activities)

# read train and test subject files and bind/stack together
new.path <- file.path(home.path, "UCI HAR Dataset", "train","subject_train.txt")
train.subjects <- read.table(new.path, header=FALSE, col.names="subject")
new.path <- file.path(home.path, "UCI HAR Dataset", "test","subject_test.txt")
test.subjects <- read.table(new.path, header=FALSE, col.names="subject")

subjects <- rbind(train.subjects, test.subjects)

# read train and test data files and bind/bind together
new.path <- file.path(home.path,"UCI HAR Dataset", "train","x_train.txt")
train.data <- read.table(new.path, header=FALSE, col.names=features)
new.path <- file.path(home.path,"UCI HAR Dataset", "test","x_test.txt")
test.data <- read.table(new.path, header=FALSE, col.names=features)

data <- rbind(train.data, test.data)

# clean up the names of the features.  Move 'Mag' to the end [could have done this first]
names(data)<-gsub("^t", "Time.", names(data))
names(data)<-gsub("^f", "Freq.", names(data))
names(data)<-gsub("BodyBody", "Body", names(data))
names(data)<-gsub("mean", "Mean", names(data))
names(data)<-gsub("std", "Std", names(data))
names(data)[grepl("Mag",names(data))] <- sub("Mag","",paste0(names(data)[grepl("Mag",names(data))],".Mag"))

# substitute activity names and add activities/subjects to data set. Then select only mean/std features
new.data <- inner_join(activities, activity.lables, by="act.num") %>%
      select(activity) %>%
      bind_cols(subjects) %>%
      bind_cols(data) %>%
      select(matches("^[ft]|activity|subject")) %>%
      select(matches("*[Mm]ean*|*[Ss]td*|activity|subject")) %>%
      select(-matches("*meanFreq*"))

# select subject/activity for group by
new.data <- group_by(new.data, subject, activity)

# summaize the data by subject and activity and calc the mean for each feature
data.means <- new.data %>% summarise_each(funs(mean)) 

# save data as tidy data set
write.csv(data.means, file = "tidy_data.csv", row.names=FALSE)

# convert to long view - each domain/feature/stat has a vector of XYZ and magnitude
data.means.long <- data.means %>% 
                   gather(feature,measure,-c(subject,activity)) %>% 
                   separate(feature,c("domain","feature","statistic","vect")) %>%
                   spread(vect,measure) %>%
                   rename(magnitude=Mag)

write.csv(data.means.long, file = "tidy_data_long.csv", row.names=FALSE)

