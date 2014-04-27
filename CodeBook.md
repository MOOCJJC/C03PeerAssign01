## Human Activity Data from Samsung Smartphones

### Introduction

The original datasets were separated into two groups: train datasets and test datasets. It's a supervised learning problem with `X` as the into feature vectors and `y` is the output variable that needs to be predicted. Because the measurements were performed by different people, there is another input feature called `subject` that identifies the people.

The task of this script is to combine the train and test datasets into a complete dataset `All_Data` and also extract the measurement means and standard deviation forming `dataMeanStd`. The final output data frame `dfData` stored the average values of all the columns in `dataMeanStd` for each activity and each subject.

The detailed description of all the processes and transformation of data can be referred to the document `README.md`.

### Description of `All_Data`

#### `Subject`

Description: Subject identifier

Type: Numeric

Data Range: 1~30

#### `ActNum`

Description: Activity identifier

Type: Numeric

Data Range: 1~6

1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING 

#### `ActNames`

Description: Activity Names

Type: Character

Data Range: 

"WALKING"

"WALKING_UPSTAIRS"

"WALKING_DOWNSTAIRS"

"SITTING"

"STANDING"

"LAYING"

#### Others
Description: Measurement results

Type: Numeric

### Description of `dataMeanStd`

#### `Subject`

Description: Subject identifier

Type: Numeric

Data Range: 1~30

#### `ActNum`

Description: Activity identifier

Type: Numeric

Data Range: 1~6

1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING 

#### `ActNames`

Description: Activity Names

Type: Character

Data Range: 

"WALKING"

"WALKING_UPSTAIRS"

"WALKING_DOWNSTAIRS"

"SITTING"

"STANDING"

"LAYING"

#### Others
Description: Measurement results

Type: Numeric

### Description of `dfData`

#### `Subject Activity`

Description: unique identifier for subject who performed specific activity

Type: Factor

Data Range: Number in the string identify the subject and the activity names identify the performed activity

#### Others
Description: Means of measurement results

Type: Numeric
 