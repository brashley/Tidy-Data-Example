
library("tidyr")
library("dplyr")

home.path <- getwd()
new.path <- file.path(home.path,"UCI HAR Dataset", "activity_labels.txt")
activity.lables <- read.table(new.path, header=FALSE, col.names=c("act.num","activity"))

new.path <- file.path(home.path, "UCI HAR Dataset", "features.txt")
features <- read.table(new.path, header=FALSE, col.names=c("fet.num","feature"))

new.path <- file.path(home.path, "UCI HAR Dataset", "train","y_train.txt")
train.activities <- read.table(new.path, header=FALSE, col.names="act.num")

new.path <- file.path(home.path, "UCI HAR Dataset", "train","subject_train.txt")
train.subject <- read.table(new.path, header=FALSE, col.names="subject")
      

new.path <- file.path(home.path,"UCI HAR Dataset", "train","x_train.txt")
data <- read.table(new.path, header=FALSE, col.names=features$feature)

colnames(data) <- gsub("\\.+","\\.", colnames(data))

new.data <- select(data,matches("*[Mm]ean*|*[Ss]td*"))

new.data <- inner_join(train.activities, activity.lables, by="act.num") %>%
      select(activity) %>%
      bind_cols(train.subject) %>%
      bind_cols(data) %>%
      select(matches("*[Mm]ean*|*[Ss]td*|activity|subject"))
      
