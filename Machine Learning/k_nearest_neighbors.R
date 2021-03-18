# K Nearest Neighbors or KNN

# Get Data
# We'll use the ISLR package to get the data, you can download it with the code below. Remember to call the library as well.

# Training Algorithm
#   1. Store all the Data
# 
# Prediction Algorithm
#   1. Calculate the distance from point x to all points in your data
#   2. Sort the points in your data by increasing distance from x
#   3. Predict the majority label of 'k' closest points

# install.packages('ISLR')
library(ISLR)
# print(head(Caravan))

print(summary(Caravan$Purchase))


# Cleaning Data
print(any(is.na(Caravan)))

# Standardize Variables
# The scale of the variables matters. Any variables that are on a large scale will have a much larger effect on the distance between the observations, and hence on the KNN classifier, than variables that are on a small scale.
print(var(Caravan[,1])) # 165.0378
print(var(Caravan[,2])) # 0.1647078

# We are now going to standarize all the X variables except Y (Purchase). The Purchase variable is in column 86 of our dataset, so let’s save it in a separate variable because the knn() function needs it as a separate argument.

# save the Purchase column in a separate variable
purchase <- Caravan[,86]

# Standarize the dataset using "scale()" R function
standardized.Caravan <- scale(Caravan[,-86])

# Let's check the variance again:
print(var(standardized.Caravan[,1])) # 1
print(var(standardized.Caravan[,2])) # 1

# Divide our dataset into testing and training data

# First 100 rows for test set
test.index <- 1:1000
test.data <- standardized.Caravan[test.index,]
test.purchase <- purchase[test.index]

# Rest of data for training
train.data <- standardized.Caravan[-test.index,]
train.purchase <- purchase[-test.index]


# Using KNN -we are trying to come up with a model to predict whether someone will purchase or not
library(class)
set.seed(101)
# knn(train, test, cl, k = 1, l = 0, prob = FALSE, use.all = TRUE)
predicted.purchase <- knn(train.data,test.data,train.purchase, k=1)
print(head(predicted.purchase))

# Now let’s evaluate the model we trained and see our misclassification error rate.

missclass.error <- mean(test.purchase != predicted.purchase)
print(missclass.error) #0.116 


# Choosing K Value
# If we change the value of k in the knn function we can get better missclass.error results
# will create a function to chose the best k value

predicted.purchase= NULL
error.rate = NULL

for (i in 1:20){
  set.seed(101)
  predicted.purchase = knn(train.data,test.data,train.purchase, k=i)
  error.rate[i] = mean(test.purchase != predicted.purchase)
}
print(error.rate)
print(min(error.rate))# 0.058

library(ggplot2)
k.values <- 1:20
error.df <- data.frame(error.rate,k.values)

pl <- ggplot(error.df,aes(x=k.values,y=error.rate)) + geom_point()+ geom_line(lty="dotted",color='red')
print(pl)
