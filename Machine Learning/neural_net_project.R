
# Get the Data
# Use read.csv to read the bank_note_data.csv file.

df <- read.csv('../CSV/bank_note_data.csv')
print(head(df))

# Train Test Split
# Use the caTools library to split the data into training and testing sets.
library(caTools)

sample <- sample.split(df$Class,SplitRatio = 0.70)

train <- subset(df, sample ==T)
test <- subset(df, sample ==F)

# Check the structure of the train data and note that Class is still an int data type. We won't convert it to a factor for now because the neural net requires all numeric information.
print(str(train))

# Building the Neural Net
# Call the neuralnet library
library(neuralnet)

# Use the neuralnet function to train a neural net, set linear.output=FALSe and choose 10 hidden neurons (hidden=10)

nn <- neuralnet(Class~ Image.Var + Image.Curt + Entropy, data = train, hidden =10, linear.output=F)

# Predictions
# Use compute() to grab predictions useing your nn model on the test set. Reference the lecture on how to do this.
predicted.nn.values <- compute(nn, test[,1:4])

# Check the head of the predicted values. You should notice that they are still probabilities.
print(head(predicted.nn.values$net.result))

# Apply the round function to the predicted values so you only 0s and 1s as your predicted classes.
predictions <- sapply(predicted.nn.values$net.result, round)
print(head(predictions))

# Use table() to create a confusion matrix of your predictions versus the real values

print(table(predictions,test$Class))


# Comparing Models
# Call the randomForest library

library(randomForest)
df$Class <- factor(df$Class)
library(caTools)
set.seed(101)
split = sample.split(df$Class, SplitRatio = 0.70)

train = subset(df, split == TRUE)
test = subset(df, split == FALSE)


# Create a randomForest model with the new adjusted training data.
model <- randomForest(Class ~ Image.Var + Image.Skew + Image.Curt + Entropy,data=train)

#Use predict() to get the predicted values from your rf model.
rf.pred <- predict(model,test)

#Use table() to create the confusion matrix.
print(table(rf.pred,test$Class))


