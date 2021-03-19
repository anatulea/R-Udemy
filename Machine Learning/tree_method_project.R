# Tree Methods Project
# For this project we will be exploring the use of tree methods to classify schools as Private or Public based off their features.

# Get the Data
# Call the ISLR library and check the head of College (a built-in data frame with ISLR, use data() to check this.) Then reassign College to a dataframe called df
library(ISLR)
# print(head(College))
df <- College

# EDA
# Let's explore the data!
# Create a scatterplot of Grad.Rate versus Room.Board, colored by the Private column.

library(ggplot2)
pl<-ggplot(df, aes(Grad.Rate, Room.Board))+ geom_point(aes(color=Private))
print(pl)

# Create a histogram of full time undergrad students, color by Private.
pl2 <- ggplot(df, aes(F.Undergrad)) + geom_histogram(aes(fill=Private), color='black', bins=50)
print(pl2)

# Create a histogram of Grad.Rate colored by Private. You should see something odd here.
pl3 <- ggplot(df, aes(Grad.Rate)) +geom_histogram(aes(fill=Private), color='black', bins=50)
print(pl3)

# What college had a Graduation Rate of above 100% ?
# a private one
print(subset(df,Grad.Rate > 100))

# Change that college's grad rate to 100% 
df['Cazenovia College','Grad.Rate'] <- 100
print(subset(df,Grad.Rate == 100))

# now the graph is ok
pl4 <- ggplot(df, aes(Grad.Rate)) +geom_histogram(aes(fill=Private), color='black', bins=50)
print(pl4)

# Train Test Split
# Split your data into training and testing sets 70/30. Use the caTools library to do this.
library(caTools)
set.seed(101)

sample <- sample.split(df$Private, SplitRatio = 0.70)

train<- subset(df, sample ==T)
test <-subset(df, sample == F)

# Decision Tree
# Use the rpart library to build a decision tree to predict whether or not a school is Private. Remember to only build your tree off the training data.
library(rpart)
ds.tree <- rpart(Private~., method='class', data= train)
printcp(ds.tree)

# Use predict() to predict the Private label on the test data.
tree.prediction <- predict(ds.tree, test)
# Check the Head of the predicted values. You should notice that you actually have two columns with the probabilities.
print(head(tree.prediction))


# Turn these two columns into one column to match the original Yes/No Label for a Private column.
tree.prediction <- as.data.frame(tree.prediction)


joinCols <- function(col){
  if(col >=0.5){
    return('Yes')
  }else{
    return('No')
  }
}

tree.prediction$Private <- sapply(tree.prediction$Yes, joinCols)
print(head(tree.prediction))

# Now use table() to create a confusion matrix of your tree model.
confussion.matrix <- table(tree.prediction$Private, test$Private)
print(confussion.matrix)

# Use the rpart.plot library and the prp() function to plot out your tree model.
library(rpart.plot)
prp(ds.tree)



#           Random Forest
# Now let's build out a random forest model!
# 
# Call the randomForest package library
library(randomForest)
rf.model<- randomForest(Private~., data = train, importance=T)

# What was your model's confusion matrix on its own training set? Use model$confusion.
print(rf.model$confusion)

# Grab the feature importance with model$importance. Refer to the reading for more info on what Gini[1] means.[2]
print(rf.model$importance)

# Predictions
# Now use your random forest model to predict on your test set!
p<- predict(rf.model, test)
print(table(p, test$Private))

