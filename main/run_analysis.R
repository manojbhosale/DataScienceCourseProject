
# Read required files
x_trainf <- read.table("train\\X_train.txt")
x_testf <- read.table("test\\X_test.txt")
subjTRnames <- read.table("train\\subject_train.txt")
subjTEnames <- read.table("test\\subject_test.txt")
activityf <- read.table("activity_labels.txt", row.names = 1)
trainact <- read.table("train\\y_train.txt")
testact <- read.table("test\\y_test.txt")
allcolnames <- read.table("features.txt",row.names = 1)

# Extracts only the measurements on the mean and standard deviation column names with index
meanStdcols <- grep("\\-mean\\(\\)|std\\(\\)",allcolnames$V2,perl = TRUE)

# Clean the labels 
selectedVars <- allcolnames$V2[meanStdcols]
selectedVars  <- gsub("\\(\\)","",selectedVars ,perl = TRUE)
selectedVars  <- gsub("[-,]","_",selectedVars ,perl = TRUE)

#select only mean and standard deviation data collumns from the train and test data 
x_trainf <- x_trainf[,meanStdcols]
x_testf <- x_testf[,meanStdcols]
 
#Assign selected and cleaned variable names to the correspinding columns
colnames(x_trainf) <- selectedVars
colnames(x_testf) <- selectedVars
 
# Generate meaningful names from the subject IDs  
subjTRnames <- paste("PersonID_",subjTRnames$V1,sep ="" )
subjTEnames <- paste("PersonID_",subjTEnames$V1,sep ="" )

# Get activities for training data
BodyActivity <- as.vector(activityf[trainact$V1,])
x_trainf <- cbind(BodyActivity,x_trainf)
x_trainf$BodyActivity <- as.vector(x_trainf$BodyActivity)

# Get activities for test data 
BodyActivity <- as.vector(activityf[testact$V1,])
x_testf <- cbind(BodyActivity,x_testf)
x_testf$BodyActivity <- as.vector(x_testf$BodyActivity)

# Add subject names to the test data
x_testf <- cbind(subjTEnames,x_testf)
names(x_testf)[names(x_testf) == "subjTEnames"]<- "Person_Identifier"
x_testf$Person_Identifier <- as.vector(x_testf$Person_Identifier)

# Add subject names to the train data
x_trainf <- cbind(subjTRnames,x_trainf)
names(x_trainf)[names(x_trainf) == "subjTRnames"]<- "Person_Identifier"
x_trainf$Person_Identifier <- as.vector(x_trainf$Person_Identifier)


# result for step4
combinedFrame <- rbind(x_testf,x_trainf)   

# Get Subject Names and activities
SubjectName <- combinedFrame$Person_Identifier
Activities <- combinedFrame$BodyActivity

# Remove two columns
combinedFrame <- subset(combinedFrame, select = -c(Person_Identifier,BodyActivity) )

#Call aggregate function to create final results.
aggdata <- aggregate(x = combinedFrame, by=list(SubjectName,Activities),FUN=mean, na.rm=TRUE)
names(aggdata)[1] <- "Person_Identifier"
names(aggdata)[2] <- "Body_Activity"

#print finla results in a TEXT file
write.table(aggdata,"step5tidyData.txt",row.name = FALSE)

	
	
