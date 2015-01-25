## README.md for Getting and cleaning data course project
### Introduction

The following text is from the README.txt that was included with the original project description.
I have updated the "UCI HAR Dataset\features_info.txt" to include improved variable names and descriptions. Following this introduction, is a description of the "run_analysis.R" and how it processes the data from the UCI HAR Dataset, as well as the environment that is needed to run the  run_analysis script.
###==================================================================
###Human Activity Recognition Using Smartphones Dataset
###Version 1.0
###==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit? degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
###==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

### For each record it is provided:
###======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

###The dataset includes the following files in the UCI HAR dataset folder:

- 'README.txt' (incorporated here)

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.
-  'myNewFeatures.txt' the 

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

The following files are in the dataset, but are not needed for this project
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

NEW FILES at the top leveldirectory
Course3ProjectTidyDataSet.txt CodeBook lists the 79 data variables and describes them
myNewFeatures.txt - the "pretty names" file that was written from run_analysis.R with the selected columns. that I subsequently edited in notepad++ to create THe pretty names of all the features with "mean" or "std" in the name.

### Notes: 

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

### License:

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

### Environment setup
Download the run_analysis.R file into the directory that contains the UCI HAR Dataset folder. 
Run the run_analysis.R script using the command. 
tidyData <- runAnalysis()

The following packages need to be installed
data.table
plyr
dplyr

It is also assumed that you have a UCI HAR Dataset folder with all the test and training data. I didn't upload them separately. Just in case you missed it, the run_analysis.R goes at the same level as the UCI HAR Dataset (not in it).

### Results
The results will be in a file called "Course3ProjectTidyData.txt" in the "UCI HAR Dataset" folder
You can look this file  in a good text editor, like Notepad++.
The tidy data table is also returned from the function
### Process
The process steps are noted in the run_analysis.R. The steps are largely in the order that 
was indicated in the problem description, but I have outlined them in detail here, in case there
was some ambiguity in the instructions

#### Step 1. Process the test data and test subjects
      1.a Read in the test data and make it into a data.table 
      1.b Read in the test subjects data, and label it
      1.c Add the test subjects data to the test data 
      1.d Read in the test activities data, and label it
      1.e Add the test subjects data to the test data
#### Step 2. Process the train data and train subjects      
      2.a Read in the train data and make it into a data.table 
      2.b Read in the train subjects data, and label it
      2.c Add the train subjects data to the train data 
      2.d Read in the train activities data, and label it
      2.e Add the train subjects data to the train data
      
#### Step 3. Combine test and train data by appending the train data at the bottom of the test data

#### Step 4. Read in the original features file that will be used to select the desired features 
      4.a I chose the desired features to be those with "mean" or "std" in the name using 'regexpr'. Note that I chose to only use values without capital letters. That means that I did not pick up the vectors obtained by averaging the signals in a signal window sample, as these had a 'M' in "Mean"

#### Step 5. (only once) Write the old features to a nice file where they can be fixed. 
I only used this once to facilitate making  pretty column names, so the filename in the write.table is a dummy. If you uncomoment the write.table line, you won't accidently overwrite my pretty names file which is called myNewFeatures.txt- remember that the desired columns are the names in the ROWS of the features data. After I wrote myNewFeatures.txt, I used notepad++ to make the pretty names.

#### Step 6. Create the reduced data set that has exactly desired columns (from allWantedCols) 
#### Step 7. Let's clean up those column names so they are pretty. 
Read in the edited names file 

#### Step 8. Read in the pretty names for the activities 
Use it to put column names on them so you can join it with your reduced data to replace the indexes of the activities that are there now with the correspondingput  pretty activity names (joining by Activity_ID). Then remove the Activity_ID column.Then remove the Activity_ID column and put the pretty names on as column names. This causes a warning, but it doesn't matter

#### Step 9. Finish up 
First make sure that your Subjects are factors. Not sure why, but they seem to prefer to be ints  Group the data set by the desired columns, summarize using the "mean" function and writing out the tidy data file. The function returns the tidydata because I decided that it should. 
     