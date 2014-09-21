DataScienceCourseProject
========================
1) Input files
	Script requires folowing input files to work
	Files in "train" folder
	 "X_train.txt"
	 "subject_train.txt"
	 "y_train.txt"

	Files in "test" folder
	 "X_test.txt"
	 "subject_test.txt"
	 "y_test.txt"

	Files in the working directory.
	 "activity_labels.txt"
	 "features.txt"
	 
	**"train" and "test" folders will be in working directory along with the "run_analysis.R"	script
	
	Above mentioned files were read with read.table() and stoere in corresponding objects for use.
	
2) Extracts only the measurements on the mean and standard deviation column names with index.
	grep() fuction was used with perl like regular expression. Indices of such colums were stored in object "meanStdcols"
	
3) Clean the labels 
	These feature names were transformed in such a way that the function icons like "()","-" were replaced with either space or the underscrore("_"). 
	gsub() was used to replace the unnecessary characters.
	
4) select only mean and standard deviation data collumns from the train and test data.
	with the help of indexes extracted in step 3 corresponding columns from the train and test data were extracted.
	
5) Assign selected and cleaned variable names to the correspinding columns
	with colnames() function cleaned names were assigned back to the data.

6) Generate readable and meaningful names from the subject IDs  
	with paste() function readable names were created with "PersonID_" prefix and subject ids.

7) Get activities for training and test data 
	Based on the index of th activities the IDs were converted to the corresponding string representation. cbind() was used to combine the new string activity column with the test and train data.

8) Add subject names to the test data
	Similar to step 7 subject ids were converted to the correponding "PersonID_" and cbind() was used to combine it with the data.
	
9) Tidy data from step 4
	Data frames in step 8 for train and test were combined to get tidy data asked in step 4 of the question.

10) Tidy data with mean for combined data frame to get mean of every column for each combination of the PersonID_ and BodyActivity.
	Called aggregate function on combined data frame with PersonID_ and BodyActivity columsn data combination. This resulted in the final result asked in step 5
	
11) Print final results in a TEXT file
	Finally the data  frame was writtent to the TEXT file with write.table() function having row.name argument.as FALSE.
	Code will finally create a file "step5tidyData.txt" and will be the final output.
