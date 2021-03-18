# KNN Project 
# Get the Data
# Iris Data Set
# We'll use the famous iris data set for this project. It's a small data set with flower features that can be used to attempt to predict the species of an iris flower.

# Use the ISLR libary to get the iris data set. Check the head of the iris Data Frame.
library(ISLR)
print(head(iris))
print(str(iris))

# Standardize Data
# Lets go ahead and do this even though its not necessary for this data!
#   
# Use scale() to standardize the feature columns of the iris dataset. Set this standardized version of the data as a new variable.
standardized.iris <- scale(iris[1:4]) # pass in the col 1 to 4

# Check that the scaling worked by checking the variance of one of the new columns.
print(var(standardized.iris[,1])) # 1

# Join the standardized data with the response/target/label column (the column with the species names.
standard.data <- cbind(standardized.iris, iris[5]) # join as the 5th column
print(head(standard.data))

# Train and Test Splits
# Use the caTools library to split your standardized data into train and test sets. Use a 70/30 split.
library(caTools)
set.seed(101)

sample <- sample.split(standard.data$Species, SplitRatio = 0.70) # use the column we try to predict
train <-subset(standard.data, sample == TRUE)
test <-subset(standard.data, sample == FALSE)

# Build a KNN model.¶
# Call the class library.
library(class)

# Use the knn function to predict Species of the test set. Use k=1
# knn(train, test, cl-label of training data, k = 1, l = 0, prob = FALSE, use.all = TRUE)
predicted.species <- knn(train[1:4], test[1:4], train$Species, k=1)
print(predicted.species)

# What was your misclassification rate?
missclasification.rate <- mean(test$Species != predicted.species)
print(missclasification.rate)


#             Choosing a K Value
# Although our data is quite small for us to really get a feel for choosing a good K value, let's practice.
# 
# Create a plot of the error (misclassification) rate for k values ranging from 1 to 10.
predicted.species = NULL
error.rate = NULL

for(i in 1:10){
  set.seed(101)
  predicted.species = knn(train[1:4], test[1:4], train$Species, k=i)
  error.rate[i] = mean(test$Species != predicted.species)
}
print(error.rate)
print(min(error.rate))# 0.02222222

library(ggplot2)
k.values <-1:10
error.df <- data.frame(error.rate, k.values)

pl<- ggplot(error.df, aes(k.values, error.rate)) + geom_point()+ geom_line(lty='dotted', color='red')
print(pl)






