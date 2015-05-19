
library("tidyr")
library("dplyr")

home.path <- getwd()

new.path <- file.path(home.path,"UCI HAR Dataset", "activity_labels.txt")
activity.lables <- read.table(new.path, header=FALSE, col.names=c("act.num","activity"))

new.path <- file.path(home.path, "UCI HAR Dataset", "features.txt")
features <- read.table(new.path, header=FALSE, col.names=c("fet.num","feature"),colClasses = "character")
features <- gsub("[()]","", features$feature)


new.path <- file.path(home.path, "UCI HAR Dataset", "train","y_train.txt")
train.activities <- read.table(new.path, header=FALSE, col.names="act.num")
new.path <- file.path(home.path, "UCI HAR Dataset", "test","y_test.txt")
test.activities <- read.table(new.path, header=FALSE, col.names="act.num")

activities <-rbind(train.activities, test.activities)

new.path <- file.path(home.path, "UCI HAR Dataset", "train","subject_train.txt")
train.subjects <- read.table(new.path, header=FALSE, col.names="subject")

new.path <- file.path(home.path, "UCI HAR Dataset", "test","subject_test.txt")
test.subjects <- read.table(new.path, header=FALSE, col.names="subject")

subjects <- rbind(train.subjects, test.subjects)

new.path <- file.path(home.path,"UCI HAR Dataset", "train","x_train.txt")
train.data <- read.table(new.path, header=FALSE, col.names=features)

new.path <- file.path(home.path,"UCI HAR Dataset", "test","x_test.txt")
test.data <- read.table(new.path, header=FALSE, col.names=features)

data <- rbind(train.data, test.data)


new.data <- inner_join(activities, activity.lables, by="act.num") %>%
      select(activity) %>%
      bind_cols(subjects) %>%
      bind_cols(data) %>%
      select(matches("^[ft]|activity|subject")) %>%
      select(matches("*[Mm]ean*|*[Ss]td*|activity|subject")) %>%
      select(-matches("*meanFreq*"))

new.data <- group_by(new.data, subject, activity)

# summaize the data.frame by subject and activity and calc the mean
data.means <- new.data %>% summarise_each(funs(mean))

write.table(data.means, file = "tidy_data.txt", row.names=TRUE)

