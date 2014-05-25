analysis <- function(){

    ## read the datas and row bind the data
    X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
    y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
    subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

    X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
    y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
    subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    
    X <- rbind(X_train,X_test)
    activity <- rbind(y_train,y_test)
    subject <- rbind(subject_train,subject_test)

    ## Replace the number in y_train and y_test with descriptive activity names
    ##activity <- gsub("1","Walking",activity)
    ##activity <- gsub("2","WalkingUpstairs",activity)
    ##activity <- gsub("3","WalkingDowntairs",activity)
   ## activity <- gsub("4","Siting",activity)
    ##activity <- gsub("5","Standing",activity)
    ##activity <- gsub("6","Laying",activity)

    ## names the data
    features <- read.table("./UCI HAR Dataset/features.txt")
    features <- gsub("-","",features[,2])
    features <- gsub("\\(", "",features, ignore.case = FALSE, perl = FALSE,fixed = FALSE, useBytes = FALSE)
    features <- gsub("\\)", "",features, ignore.case = FALSE, perl = FALSE,fixed = FALSE, useBytes = FALSE)
    features <- gsub(",","",features)

    names(X) <- features
    names(activity) <- "activity"
    names(subject) <- "subject"

    ## get the mean and standard deviation for each measurement and bind them 
    means <-  X[,grep("mean",names(X),fixed=TRUE)]
    std <-  X[,grep("std",names(X),fixed=TRUE)]
    data <- cbind(subject,activity,means,std)

    ##  Caculate average of each variable for each activity and each subject.
    library(reshape2)
    data_melt <- melt(data,id=c("subject","activity"))
    td <- dcast(data_melt,activity+subject ~ variable,mean)

    write.table(td,"tidyData.txt")
    


}