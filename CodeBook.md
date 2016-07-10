!!Codebook for assignment 4

This assignment combines all train and test data from the Samsung S wearables project including subject data and feature data. It also takes activity mapping and performs replacement of the variable names containing activity numbers with their names.

The assignment4.R script selects only columns pertaining to the mean or standard deviation of instrument measurements and performs averaging across all these measurements for each subject.  The resulting output.csv then contains a tidied version of this data using the dplyr package in R.
