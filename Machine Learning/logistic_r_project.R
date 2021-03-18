# Logistic Regression Project
# n this project we will be working with the UCI adult dataset. We will be attempting to predict if people in the data set belong in a certain class by salary, either making <=50k or >50k per year.

# Get the Data
# Read in the adult_sal.csv file and set it to a data frame called adult.

adult <- read.csv('../CSV/adult_sal.csv')

#Check the head of adult
print(head(adult))
print(str(adult))

# You should notice the index has been repeated. Drop this column.
library(dplyr)
adult<- select(adult, -X)

# Check the head,str, and summary of the data now.
print(head(adult))
print(str(adult))
print(summary(adult))

# Data Cleaning 
# Notice that we have a lot of columns that are cateogrical factors, however a lot of these columns have too many factors than may be necessary. Try to clean these columns up by reducing the number of factors.

# type_employer column
# Use table() to check out the frequency of the type_employer column.

freq.type <- table(adult$type_employer)
print(freq.type)

# How many Null values are there for type_employer? What are the two smallest groups?
# 1836 
# Never-worked
# Without-pay



#Combine these two smallest groups into a single group called "Unemployed". There are lots of ways to do this, so feel free to get creative. Hint: It may be helpful to convert these objects into character data types (as.character() and then use sapply with a custom function)
unemployed <- function(type){
  newStatus <-type
  for(i in 1:length(type)){
    if(type[i]== "Never-worked" | type[i] == "Without-pay"){
      newStatus[i]<- "Unemployed"
    }else{
      newStatus[i]<- type[i]
    }
    return(newStatus)
  }
}

fixed.type <- sapply(adult$type_employer, unemployed)
adult$type_employer<-fixed.type
# check if it changed
print(table(adult$type_employer))

# What other columns are suitable for combining? Combine State and Local gov jobs into a category called SL-gov and combine self-employed jobs into a category called self-emp.

employement <- function(type){
  newType <-type
  for(i in 1:length(type)){
    if(type[i] == 'Local-gov' | type[i]== 'State-gov'){
      newType[i] <-'SL-gov'
    }else if(type[i] == 'Self-emp-inc' | type[i]== 'Self-emp-not-inc'){
      newType[i]<- 'self-emp'
    }else{
      newType[i] <- type[i]
    }
  }
  return(newType)
}

fixed.emp.group <- sapply(adult$type_employer, employement)
adult$type_employer<-fixed.emp.group

print(table(adult$type_employer))

# Marital Column
# Use table() to look at the marital column
#print(table(adult$marital))


#Reduce this to three groups:
    # Married
    # Not-Married
    # Never-Married
marital <- function(status){
  newStatus <- status
  for(i in 1:length(status)){
    if(status[i]=='Married-AF-spouse'| status[i]=='Married-civ-spouse'|status[i]=='Married-spouse-absent'){
      newStatus[i]<- 'Married'
    }else if(status[i]=='Divorced'| status[i]=='Separated'|status[i]=='Widowed'){
      newStatus[i]<- 'Not-Married'
    }else{
      newStatus[i]<-status[i]
    }
  }
  return(newStatus)
}

fixed.marriage <- sapply(adult$marital, marital)
adult$marital <- fixed.marriage
print(table(adult$marital))


# Country Column
# Check the country column using table()
# print(table(adult$country))

# Group these countries together however you see fit. You have flexibility here because there is no right/wrong way to do this, possibly group by continents. You should be able to reduce the number of groups here significantly though.

Asia <- c('China','Hong','India','Iran','Cambodia','Japan', 'Laos' ,
          'Philippines' ,'Vietnam' ,'Taiwan', 'Thailand')

North.America <- c('Canada','United-States','Puerto-Rico' )

Europe <- c('England' ,'France', 'Germany' ,'Greece','Holand-Netherlands','Hungary',
            'Ireland','Italy','Poland','Portugal','Scotland','Yugoslavia')

Latin.and.South.America <- c('Columbia','Cuba','Dominican-Republic','Ecuador',
                             'El-Salvador','Guatemala','Haiti','Honduras',
                             'Mexico','Nicaragua','Outlying-US(Guam-USVI-etc)','Peru',
                             'Jamaica','Trinadad&Tobago')
Other <- c('South')
group_country <- function(ctry){
  if (ctry %in% Asia){
    return('Asia')
  }else if (ctry %in% North.America){
    return('North.America')
  }else if (ctry %in% Europe){
    return('Europe')
  }else if (ctry %in% Latin.and.South.America){
    return('Latin.and.South.America')
  }else{
    return('Other')      
  }
}
adult$country <- sapply(adult$country,group_country)
print(table(adult$country))

# Check the str() of adult again. Make sure any of the columns we changed have factor levels with factor()
print(str(adult))
adult$type_employer <- sapply(adult$type_employer,factor)
adult$country <- sapply(adult$country,factor)
adult$marital <- sapply(adult$marital,factor)
adult$income <- sapply(adult$income,factor)
# You could have also done something like:
#             adult$type_employer <- factor(adult$type_employer)
print(str(adult))


# Missing Data
# Notice how we have data that is missing.
#install.packages('Amelia',repos = 'http://cran.us.r-project.org')

library(Amelia)
# Convert any cell with a '?' or a ' ?' value to a NA value. Hint: is.na() may be useful here or you can also use brackets with a conditional statement. Refer to the solutions if you can't figure this step out.
adult[adult=='?'] <-NA

#Using table() on a column with NA values should now not display those NA values, instead you'll just see 0 for ?. Optional: Refactor these columns (may take awhile). For example:
print(table(adult$type_employer))


#play around with the missmap function from the Amelia package. Can you figure out what its doing and how to use it?
missing.data <- missmap(adult,y.at=c(1),y.labels = c(''), main="Missing adult data", col=c('red', 'white'), legend = FALSE)
print(missing.data)
print(table(adult$occupation))

#Use na.omit() to omit NA data from the adult data frame. Note, it really depends on the situation and your data to judge whether or not this is a good decision. You shouldn't always just drop NA values.

adult <- na.omit(adult)

# Use missmap() to check that all the NA values were in fact dropped.
clean.data <- missmap(adult,y.at=c(1),y.labels = c(''), main="Clean adult data", col=c('yellow', 'black'), legend = FALSE)
print(clean.data)

# EDA
# Although we've cleaned the data, we still have explored it using visualization.
# 
# Check the str() of the data.
print(str(adult))

# Use ggplot2 to create a histogram of ages, colored by income.
library(ggplot2)
pl1<- ggplot(adult, aes(age)) + geom_histogram(aes(fill=income), binwidth=1, color='black' )+ theme_bw()
print(pl1)

#Plot a histogram of hours worked per week
pl2 <- ggplot(adult, aes(hr_per_week))+geom_histogram(fill='green', color='black',alpha=0.4, bins = 20,)
print(pl2)

# Rename the country column to region column to better reflect the factor levels.  
names(adult)[names(adult)=='country']<-'region'

# Create a barplot of region with the fill color defined by income class. Optional: Figure out how rotate the x axis text for readability
pl3 <- ggplot(adult, aes(region)) + geom_bar(position = "dodge",aes(fill=income),color='black')+theme_bw()+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
print(pl3)

# ---------------> Building a Model <------------------ # 
# Build a model to classify people into two groups: Above or Below 50k in Salary
# Logistic Regression is a type of classification model. In classification models, we attempt to predict the outcome of categorical dependent variables, using one or more independent variables. The independent variables can be either categorical or numerical.
# 
# Logistic regression is based on the logistic function, which always takes values between 0 and 1. Replacing the dependent variable of the logistic function with a linear combination of dependent variables we intend to use for regression, we arrive at the formula for logistic regression.


#Take a quick look at the head() of adult to make sure we have a good overview before going into building the model!
head(adult)

# Train Test Split
# Split the data into a train and test set using the caTools library as done in previous lectures. Reference previous solutions notebooks if you need a refresher.
library(caTools)
set.seed(101)

sample<- sample.split(adult$income, SplitRatio = 0.70)
train <- subset(adult, sample == TRUE)
test <- subset(adult, sample == FALSE)

# Use all the features to train a glm() model on the training data set, pass the argument family=binomial(logit) into the glm function.
# make sure income is Factor
model <-glm(formula= income~., family = binomial(link='logit'), data=train)
print(summary(model))

# Use new.model <- step(your.model.name) to use the step() function to create a new model.
new.model <- step(model)
#You should get a bunch of messages informing you of the process. Check the new.model by using summary()
print(summary(new.model))
#You should have noticed that the step() function kept all the features used previously! While we used the AIC criteria to compare models, there are other criteria we could have used.


# Create a confusion matrix using the predict function with type='response' as an argument inside of that function.
predicted.income <- predict(model, newdata = test, type='response')
confusion.matrix.table <- table(test$income, predicted.income>0.5)
print(confusion.matrix.table)

# What was the accuracy of our model?
accuracy<- (6372+1423)/(6372+1423+548+872)
print(accuracy)

# Calculate other measures of performance like, recall or precision.
recall <- 6732/(6372+548)

precision<- 6732/(6372+872)
print(paste('Recall',recall))
print(paste('Rrecision',precision))
