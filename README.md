---
title: "README"
author: "Richard Ashley"
date: "Saturday, May 23, 2015"
output: html_document
---

# Getting and Cleaning Data 
## The Course Assignment

The purpose of this project is to demonstrate our ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. It is required that we submit: 

1) a tidy data set as described below, 
2) a link to a Github repository with your script for performing the analysis 
3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 
4) a README.md (this file) in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

## The Source Data
One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data used for this project represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## The Script
I created one R script called `run_analysis.R` that does the following. 

1) Reads in the data sets (data folder "UCI HAR Dataset" assumed to be in you working dirrecotry)
2) Merges the training and the test sets to create one data set.
3) Uses descriptive activity names to name the activities in the data set. 
4) Extracts only the measurements on the mean and standard deviation for each measurement. 
5) Appropriately labels the data set with descriptive variable names. 
6) From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Only full features with *Mean* and *Std* were used. Vectors obtained by averaging the signals in a signal window sample were ignored from this summarized data set. It was assumed that the `Mean` of these measures would be used to show the central tendency for each subject/activity/features. Having the mean of a 'signal window sample' did not make sense. 

## The Output Tidy Data Set

I tidy data set was created using the above script and meating the project requirement. 

A `Code Book` for this resulting *tidy* data set can be found in this repo at [link](https://github.com/brashley/Tidy-Data-Example/blob/master/Codebook.md)

For it was assumened that the **Wide** data format was more appropriate for the subsequent analysis [that is unknown] would be prefered.  The wide data file is here XXXXX

A second **long** version of the file was also created as a back up.  In this second file the features were broken up by domain, feature, statistic, and each with 4 measures for magnitude and the XYZ vector components. A code book was not created for this version.  The long data file is here XXXX
