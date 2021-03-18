# Logistic Regression Lecture
# Logistic Regression is a type of classification model. In classification models, we attempt to predict the outcome of categorical dependent variables, using one or more independent variables. The independent variables can be either categorical or numerical.
# 
# Logistic regression is based on the logistic function, which always takes values between 0 and 1. Replacing the dependent variable of the logistic function with a linear combination of dependent variables we intend to use for regression, we arrive at the formula for logistic regression.


df.train <- read.csv('../CSV/titanic_train.csv')
print(head(df.train))

# install.packages('Amelia') 
library(Amelia)

missing.data <- missmap(df.train, main ='Missing Map', col=c('yellow', 'black'), legend = FALSE)
print(missing.data) 
# we can see that we have a lot of missing data for age

# Data Visualization with ggplot2
library(ggplot2)
pl<- ggplot(df.train, aes(Survived))+ geom_bar()
print(pl)

pl2<- ggplot(df.train, aes(Pclass))+ geom_bar(aes(fill=factor(Pclass)))
print(pl2)

pl3<- ggplot(df.train, aes(Sex))+ geom_bar(aes(fill=factor(Sex)))
print(pl3)


pl4 <-ggplot(df.train, aes(Age))+ geom_histogram(bins=20, alpha=0.5, fill="blue")
print(pl4)

pl5 <- ggplot(df.train, aes(SibSp)) + geom_bar()
print(pl5)

pl6 <- ggplot(df.train, aes(Fare)) + geom_histogram(fill="green", color="black", alpha=0.5, bins=20)
print(pl6)

# Data Cleaning
# We want to fill in missing age data instead of just dropping the missing age data rows. One way to do this is by filling in the mean age of all the passengers (imputation).
# 
# However we can be smarter about this and check the average age by passenger class

pl7 <- ggplot(df.train, aes(Pclass, Age)) + geom_boxplot(aes(group =Pclass, fill=factor(Pclass), alpha=0.4)) +scale_y_continuous(breaks = seq(min(0), max(80), by=2)) +theme_bw()
print(pl7)

# We can see the wealthier passengers in the higher classes tend to be older, which makes sense. We'll use these average age values to impute based on Pclass for Age.

impute_age <- function(age,class){
  out <- age
  for (i in 1:length(age)){
    
    if (is.na(age[i])){
      
      if (class[i] == 1){
        out[i] <- 37
        
      }else if (class[i] == 2){
        out[i] <- 29
        
      }else{
        out[i] <- 24
      }
    }else{
      out[i]<-age[i]
    }
  }
  return(out)
}

fixed.ages <- impute_age(df.train$Age,df.train$Pclass)
df.train$Age <- fixed.ages

# Now let's check to see if it worked:
missing2 <- missmap(df.train, main="Titanic Training Data - Missings Map", 
                    col=c("yellow", "black"), legend=FALSE)
print(missing2)

# Building a Logistic Regression Model
library(dplyr)
# Let's select the relevant columns for training:
df.train <- select(df.train, -PassengerId, -Name, -Ticket, -Cabin)
print(head(df.train))

df.train$Survived <- factor(df.train$Survived)
df.train$Pclass <- factor(df.train$Pclass)
df.train$Parch <- factor(df.train$Parch)
df.train$SibSp <- factor(df.train$SibSp)


#       Train the Model
log.model <- glm(formula=Survived ~., family = binomial(link='logit'), data=df.train)
# we are trying to predict the survived based on all the other columns
print(summary(log.model))

# Predicting using Test Cases
# Let's make a test set out of our training set, retrain on the smaller version of our training set and check it against the test subset.
library(caTools)
set.seed(101)
split <- sample.split(df.train$Survived, SplitRatio =0.7)
final.train <- subset(df.train, split == TRUE)
final.test <- subset(df.train, split == FALSE)

final.log.model <-glm(Survived~. , family= binomial(link='logit'), data=final.train)
print(summary(final.log.model))


fitted.probabilities <- predict(final.log.model,newdata=final.test,type='response')
fitted.results <- ifelse(fitted.probabilities > 0.5,1,0) # if else short function

misClasificError <- mean(fitted.results != final.test$Survived)
print(paste('Accuracy',1-misClasificError))

#  We were able to achieve around 80% accuracy, where as random guessing would have just been 50% accuracy. Let's see the confusion matrix:
confusion.matrix <- table(final.test$Survived, fitted.probabilities > 0.5)
print(confusion.matrix)



###### Extra Practice
df <- read.csv('../CSV/titanic_test.csv')
print('-------------------------------------')
print(head(df))

# find the missing data
missing.test<- missmap(df, main='Titanic missing test data', col=c('red', 'white'), legend = FALSE)
print(missing.test)



#           Data Cleaning
# check the average age by class
pl.test<- ggplot(df, aes(Pclass, Age))+ geom_boxplot(aes(group=Pclass, fill = factor(Pclass), alpha =0.5)) + scale_y_continuous(breaks = seq(min(0), max(80), by = 2))
print(pl.test)

# create function to replace the missing ages with average ages

impute_age_test <- function(age,class){
  out <- age
  for (i in 1:length(age)){
    
    if (is.na(age[i])){
      
      if (class[i] == 1){
        out[i] <- 42
        
      }else if (class[i] == 2){
        out[i] <- 26
        
      }else{
        out[i] <- 24
      }
    }else{
      out[i]<-age[i]
    }
  }
  return(out)
}

# correct the missing fare data
impute_fare <- function(fare){
  new_fare <- fare
  for(i in 1:length(fare)){
    if(is.na(fare[i])){
      new_fare[i]<- 35
    }else{
      new_fare[i]<-fare[i]
    }
  }
  return(new_fare)
}

# use function for all the age column
corrected.ages <- impute_age_test(df$Age, df$Pclass)
df$Age <-corrected.ages

#use function for the fare column 
corrected.fare <-impute_fare(df$Fare)
df$Fare <-corrected.fare

missing.test.fix<- missmap(df, main='Titanic missing test data', col=c('red', 'white'), legend = FALSE)
print(missing.test.fix)




# Select relevant columns for our model
df <- select(df, -PassengerId,-Name,-Ticket,-Cabin)
print(head(df))

#set factor columns
df$Pclass <- factor(df$Pclass)
df$Parch <- factor(df$Parch)
df$SibSp <- factor(df$SibSp)


# TRAIN THE MODEL
# Predict the class based on the rest of the data
test.model <- glm(formula=Pclass~., family= binomial(link='logit'), data=df)
print(summary(test.model))
# we can see that the fare and age ate the most significant features


#   Predicting using Test Cases
set.seed(101)
test.split <- sample.split(df$Pclass, SplitRatio= 0.70)

test.train <- subset(df, split=TRUE)
test.test <- subset(df, split =FALSE)

log.test.model <- glm(formula= Pclass~. , family=binomial(link='logit'), data=test.train)
print(summary(log.test.model))

# check prediction accuracy
fit.test.prob <- predict(test.model, newdata=test.test, type='response')

fit.results <- ifelse(fit.test.prob>0.5,1,0)
accuracy.errors<- mean(fit.results != test.test$Pclass)

print(paste('Accuracy',1-accuracy.errors))


# create the confusion matrix table
accuracy.table <- table(test.test$Pclass, fit.test.prob>0.5)
print(accuracy.table)

