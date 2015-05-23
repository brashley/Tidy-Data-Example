---
title: "CodeBook"
author: "Richard A."
date: "Saturday, May 23, 2015"
output: html_document
---

This document describes the data and transofrmations used by `run_analysis.R` and the definition of variables in [tidy_data.csv](https://github.com/brashley/Tidy-Data-Example/blob/master/tidy_data.csv).

***

##Source Data
One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data used for this project represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##Data Used

The data used are from the following files:

File   | Discription
-------|------------------------------------
`features.txt` | contains the name of the features in the data set [the `columns`] 
`activity_labels.txt` | contains activities text lables for each activity ID
`subject_test.txt` | contains information on the subjects for each observation
`subject_train.txt` | contains information on the subjects for each observation
`X_train.txt`| contains measurements for feature are intended for training
`y_train.txt` | contains the activity IDs corresponding to `X_train.txt`
`X_test.txt` | contains measurements for feature that are intended for testing
`y_test.txt` | contains the activity IDs corresponding to `X_test.txt`


##Data Transformations

Following are the transformations that were performed on the input dataset:

###Feature Naming Convention
The **measures** selected for this database come from the accelerometer and gyroscope 3-axial raw signals `Acc` and `Gyro`. These time **domain** signals are prefix with `time`.  In addition, a Fast Fourier Transform (FFT) was applied to some of these signals producing `BodyAcc`, `BodyAccJerk`, `BodyGyro`. These frequency domain signals were prefixed with `freq`.  For this project, only the `Mean` and `Std` **statistics** of these measures were selected.  Each signal had a vector **component** in the `X`, `Y`, `Z` directions as well as a `Mag` component for the magnatude of the vector when appropriate. 

This provides the bassis for building the names of the features used. Each name consists of 4 elements `domain`.`measure`.`statistic`.`component`.  Examples would be: | Time.BodyAcc.Mean.X | Time.BodyAccJerk.Std.Z | Time.BodyGyro.Std.Mag | Freq.BodyGyro.Std.Z |

###Feature Selection
>Vectors obtained by averaging the signals in a signal window sample were ignored from this summarized data set. It was assumed that the `Mean` of these measures would not be used to show the central tendency for each subject/activity/features. Having the mean of a 'signal window sample' did not make sense.

Features were only selected from the original data set if they had a `mean()` or `std()`.  This allowed the explusion of the 'signal window samples' See above note:

###File Processing 
- `activity_labels.txt` is read into `activity.lables`
- `features.txt` is read into `features`
- `y_test.txt` is read into `test.activities`
- `y_train.txt` is read into `train.activities`
- The activities in training and test set data were merged in `activities`
- `subject_test.txt` is read into `test.subjects`
- `subject_train.txt` is read into `train.subjects`
- The subjects in training and test set data were merged in `subjects`
- `X_test.txt` is read into `test.data`
- `X_train.txt` is read into `train.data`
- The data in training and test were merged in `data`
- The column names of the features in `data` were set from `features`
- Acronyms in variable names in `data` for 't' and 'f' are replaced with descriptive labels of 'Time' and 'Freq
- Features with `Mag` had the Mag term moved to the back of the feature name to make the naming convintion standard. The last part of the name is the **component**
- Features with `BodyBody` were corrected to just `Body` for consistancy 
- `data`, `activity` and `subject` were merged to form `new.data`
- `activity.lables` were substituded for `activity.ID` in `new.data`
- Features without "Mean" or "Std" were removed, includeing the "meanFreq" columns
- `new.data` was grouped by acctivity and subject and then the `mean` was calculated for each feature and stored in `data.means`
- Finally, the data in `data.means` was written as a csv file into `tidy_data.csv`

##Output Data Set

The output data `tidy_data.csv` is a a comma-delimited value file. The header line contains the names of the variables. It contains the mean of the mean and standard deviation values for each subject and activity combination.  

The variables in the data file are given below. Units are self eplanitary by name of measure. All measures are the `mean` across all measurements grouped by subject/activity:

Variable List | Description
------------- |--------------------------------------------
subject | Subject ID
activity | Activity being performned
Time.BodyAcc.Mean.X | Mean by subject/activity for all these measures
Time.BodyAcc.Mean.Y | Mean by subject/activity for all these measures
Time.BodyAcc.Mean.Z | Mean by subject/activity for all these measures
Time.BodyAcc.Std.X | Mean by subject/activity for all these measures
Time.BodyAcc.Std.Y | Mean by subject/activity for all these measures
Time.BodyAcc.Std.Z | Mean by subject/activity for all these measures
Time.GravityAcc.Mean.X | Mean by subject/activity for all these measures
Time.GravityAcc.Mean.Y | Mean by subject/activity for all these measures
Time.GravityAcc.Mean.Z | Mean by subject/activity for all these measures
Time.GravityAcc.Std.X | Mean by subject/activity for all these measures
Time.GravityAcc.Std.Y | Mean by subject/activity for all these measures
Time.GravityAcc.Std.Z | Mean by subject/activity for all these measures
Time.BodyAccJerk.Mean.X | Mean by subject/activity for all these measures
Time.BodyAccJerk.Mean.Y | Mean by subject/activity for all these measures
Time.BodyAccJerk.Mean.Z | Mean by subject/activity for all these measures
Time.BodyAccJerk.Std.X | Mean by subject/activity for all these measures
Time.BodyAccJerk.Std.Y | Mean by subject/activity for all these measures
Time.BodyAccJerk.Std.Z | Mean by subject/activity for all these measures
Time.BodyGyro.Mean.X | Mean by subject/activity for all these measures
Time.BodyGyro.Mean.Y | Mean by subject/activity for all these measures
Time.BodyGyro.Mean.Z | Mean by subject/activity for all these measures
Time.BodyGyro.Std.X | Mean by subject/activity for all these measures
Time.BodyGyro.Std.Y | Mean by subject/activity for all these measures
Time.BodyGyro.Std.Z | Mean by subject/activity for all these measures
Time.BodyGyroJerk.Mean.X | Mean by subject/activity for all these measures
Time.BodyGyroJerk.Mean.Y | Mean by subject/activity for all these measures
Time.BodyGyroJerk.Mean.Z | Mean by subject/activity for all these measures
Time.BodyGyroJerk.Std.X | Mean by subject/activity for all these measures
Time.BodyGyroJerk.Std.Y | Mean by subject/activity for all these measures
Time.BodyGyroJerk.Std.Z | Mean by subject/activity for all these measures
Time.BodyAcc.Mean.Mag | Mean by subject/activity for all these measures
Time.BodyAcc.Std.Mag | Mean by subject/activity for all these measures
Time.GravityAcc.Mean.Mag | Mean by subject/activity for all these measures
Time.GravityAcc.Std.Mag | Mean by subject/activity for all these measures
Time.BodyAccJerk.Mean.Mag | Mean by subject/activity for all these measures
Time.BodyAccJerk.Std.Mag | Mean by subject/activity for all these measures
Time.BodyGyro.Mean.Mag | Mean by subject/activity for all these measures
Time.BodyGyro.Std.Mag | Mean by subject/activity for all these measures
Time.BodyGyroJerk.Mean.Mag | Mean by subject/activity for all these measures
Time.BodyGyroJerk.Std.Mag | Mean by subject/activity for all these measures
 Freq.BodyAcc.Mean.X | Mean by subject/activity for all these measures
Freq.BodyAcc.Mean.Y | Mean by subject/activity for all these measures
Freq.BodyAcc.Mean.Z | Mean by subject/activity for all these measures
Freq.BodyAcc.Std.X | Mean by subject/activity for all these measures
Freq.BodyAcc.Std.Y | Mean by subject/activity for all these measures
Freq.BodyAcc.Std.Z | Mean by subject/activity for all these measures
Freq.BodyAccJerk.Mean.X | Mean by subject/activity for all these measures
Freq.BodyAccJerk.Mean.Y | Mean by subject/activity for all these measures
Freq.BodyAccJerk.Mean.Z | Mean by subject/activity for all these measures
Freq.BodyAccJerk.Std.X | Mean by subject/activity for all these measures
 Freq.BodyAccJerk.Std.Y | Mean by subject/activity for all these measures
 Freq.BodyAccJerk.Std.Z | Mean by subject/activity for all these measures
Freq.BodyGyro.Mean.X | Mean by subject/activity for all these measures
 Freq.BodyGyro.Mean.Y | Mean by subject/activity for all these measures
Freq.BodyGyro.Mean.Z | Mean by subject/activity for all these measures
 Freq.BodyGyro.Std.X | Mean by subject/activity for all these measures
 Freq.BodyGyro.Std.Y | Mean by subject/activity for all these measures
 Freq.BodyGyro.Std.Z | Mean by subject/activity for all these measures
Freq.BodyAcc.Mean.Mag | Mean by subject/activity for all these measures
 Freq.BodyAcc.Std.Mag | Mean by subject/activity for all these measures
Freq.BodyAccJerk.Mean.Mag | Mean by subject/activity for all these measures
Freq.BodyAccJerk.Std.Mag | Mean by subject/activity for all these measures
Freq.BodyGyro.Mean.Mag | Mean by subject/activity for all these measures
Freq.BodyGyro.Std.Mag | Mean by subject/activity for all these measures
Freq.BodyGyroJerk.Mean.Mag | Mean by subject/activity for all these measures
Freq.BodyGyroJerk.Std.Mag | Mean by subject/activity for all these measures
