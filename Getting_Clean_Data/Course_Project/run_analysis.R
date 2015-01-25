runAnalysis = function() {
     
    ## Step 1. (Process the test data and test subjects)
      ##1.a Read in the test data and make it into a data.table       
      myX_test <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt",header = FALSE, stringsAsFactors = FALSE )           
      myX_testTable <- data.table(myX_test)
      
      ##1.b Read in the test subjects data, and label it
      myX_test_subjects <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt",header = FALSE, stringsAsFactors = TRUE )
      names(myX_test_subjects) <-c("Subjects") 
      
      ##1.c Add the test subjects data to the test data      
      XTestSubs <- cbind(myX_testTable, myX_test_subjects)
      
      ##1.d Read in the test activities data, and label it
      myTestActivities <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt", header = FALSE, stringsAsFactors = TRUE )
      names(myTestActivities) <-c("Activity_ID") 
     
      ##1.e Add the test subjects data to the test data 
      myFull_testTable<- cbind( XTestSubs, myTestActivities)
    
      
   ## Step 2. (Process the train data and train subjects)
      ##2.a Read in the train data and make it into a data.table   
      
      myX_train <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt",header = FALSE, stringsAsFactors = FALSE  )
      myX_trainTable <- data.table(myX_train)
      
      ##2.b Read in the train subjects data, and label it
      myX_train_subjects <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt",header = FALSE , stringsAsFactors = TRUE)
      names(myX_train_subjects) <-c("Subjects") 
     
      ##2.c Add the train subjects data to the train data   
      XTrainSubs <- cbind(myX_trainTable, myX_train_subjects)
      
      ##2.d Read in the train activities data, and label it
      myTrainActivities <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt",header = FALSE , stringsAsFactors = TRUE)
      names(myTrainActivities) <-c("Activity_ID") 
     
      ##2.e Add the train subjects data to the train data 
     myFull_trainTable<- cbind(XTrainSubs, myTrainActivities)
    
   ### Step 3. (Combine test and train data by appending the train data at the bottom of the test data)   
     mergedData <- rbind(myFull_testTable,myFull_trainTable)
  
   ### Step 4.(Read in the original features file that will be used to select the desired features)  
   
      featuresX <-read.csv(".\\UCI HAR Dataset\\features.txt", header=FALSE, sep=" ", stringsAsFactors = FALSE)
     
   ##4.a Select all the columns that have the word "mean" or "std" in them using regexpr. This will give you the column
      ## numbers of the desired columns.
   allWantedCols<- c(which((regexpr("mean",featuresX[1:561,2])>0) | (regexpr("std",featuresX[1:561,2])>0)),562,563)
   
   ##Step 5 (only once)write the old features to a nice file where they can be fixed. I only used this once to 
      ##facilitate making    ## pretty column names, so the filename in the write.table is a dummy so
      ## that if you uncomoment the write.table line, you don't accidently overwrite my pretty names
      ## file which is called myNewFeatures.txt- remember that the desired columns are the names in the ROWS of the features data
      ## prettyNames <-featuresX[allWantedCols,2]
      ##write.table(prettyNames,".\\UCI HAR Dataset\\checkIfWriteWorks.txt", row.names = FALSE)
    
   ##Step 6 Create the reduced data set that has exactly desired columns (from allWantedCols)               
      reducedData <-select(mergedData,allWantedCols)
   
   ##Step 7 let's clean up those column names so they are pretty -read in the edited names file and 
   ## pull out the new names from the second column (the first column is the index). I've also included 
   ## SUbjects and Activity in the list for convenience
   
   newFeatureNames <-read.csv(".\\UCI HAR Dataset\\myNewFeatures.txt", header=TRUE, sep=" ", stringsAsFactors = FALSE)
   
 ##  newNames <-c(newFeatureNames[,2])      
   
   ##Step 8 Read in the pretty names for the activities and put column names on them so you can  join
 ## it with your reduced data to replace the indexes of the activities that are there now with the 
 ##correspondingput  pretty activity names (joining by Activity_ID). Then remove the Activity_ID column
 ## and put the pretty names on as column names. This causes a warning, but it doesn't matter
 
   myActivityLabels <- read.table(".\\UCI HAR Dataset\\activity_labels.txt",header = FALSE )
   names(myActivityLabels) <-c("Activity_ID","Activity")
 
  reducedWActivityNames <- join(reducedData, myActivityLabels)
  desiredData <-select(reducedWActivityNames,-Activity_ID)
  names(desiredData)<- c(newFeatureNames[,2])
  
      ##Step 9 Finish up 
       ##First make sure that your Subjects are factors. Not sure why, but they seem to prefer to be ints  
      ## Group the reduced output by the desired columns, summarizing using the "mean" function and writing 
      ## out the tidy data file. The function returns the tidydata because I decided that it should.
         ##Step 9.a 
      desiredData$Subjects = as.factor(desiredData$Subjects)
      ## now you have the data how you want it, and we want to do the summarizing
      ## first group by subject and Activity
 
      mySubjects <- group_by(desiredData, Subjects, Activity)

      tidyData <-mySubjects %>% summarise_each(funs(mean))

      write.table(tidyData,".\\UCI HAR Dataset\\Course3ProjectTidyData.txt", row.names = FALSE)
      tidyData
                                 
                              
           
  
}