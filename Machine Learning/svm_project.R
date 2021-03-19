# Support Vector Machines Project
# For this project we will be exploring publicly available data from LendingClub.com. Lending Club connects people who need money (borrowers) with people who have money (investors). Hopefully, as an investor you would want to invest in people who showed a profile of having a high probability of paying you back. We will try to create a model that will help predict this.

# Data
# Open the loan_data.csv file and save it as a dataframe called loans.
loans <- read.csv('../CSV/loan_data.csv')
print(head(loans))

# Check the summary and structure of loans.
print(summary(loans))
print(str(loans))

# Convert the following columns to categorical data using factor()
loans$inq.last.6mths <-sapply(loans$inq.last.6mths,factor)
loans$delinq.2yrs <-sapply(loans$delinq.2yrs,factor)
loans$pub.rec <-sapply(loans$pub.rec,factor)
loans$not.fully.paid <-sapply(loans$not.fully.paid,factor)
loans$credit.policy <-sapply(loans$credit.policy,factor)
print(str(loans))


# EDA
# Let's use ggplot 2 to visualize the data!
# Create a histogram of fico scores colored by not.fully.paid
library(ggplot2)
pl <- ggplot(loans, aes(fico))+ geom_histogram(aes(fill=factor(not.fully.paid)), color='black')
print(pl)

# Create a barplot of purpose counts, colored by not.fully.paid. Use position=dodge in the geom_bar argument
pl2 <- ggplot(loans, aes(purpose))+ geom_bar(bins = 10, aes(fill=not.fully.paid), position = 'dodge', )+ theme(axis.text.x = element_text(angle = 90))
print(pl2)

# Create a scatterplot of fico score versus int.rate. Does the trend make sense? Play around with the color scheme if you want.

pl3 <- ggplot(loans, aes(fico, int.rate))+ geom_point(aes(color=not.fully.paid), alpha=0.5)+theme_bw()
print(pl3)


# Building the Model
# Now its time to build a model!
#   
#   Train and Test Sets
# Split your data into training and test sets using the caTools library.
library(caTools)

sample <- sample.split(loans$not.fully.paid, SplitRatio = 0.70)

train <- subset(loans, sample == T)
test <- subset(loans, sample == F)

# Call the e1071 library as shown in the lecture.
library(e1071)

# Now use the svm() function to train a model on your training set.
model <- svm(not.fully.paid~., data = train)
print(summary(model))

# Use predict to predict new values from the test set using your model. Refer to the lecture on how to do this if you don't remember :)
predict.vals <- predict(model, test[1:13])
print(table(predict.vals, test$not.fully.paid))

# Tuning the Model
# Use the tune() function to test out different cost and gamma values. In the lecture we showed how to do this by using train.x and train.y, but its usually simpler to just pass a formula
tune.results <- tune(svm,train.x=not.fully.paid~., data=train,kernel='radial', ranges=list(cost=c(1,10), gamma=c(0.1,1)))

print(summary(tune.results))

svm.model <- svm(not.fully.paid~., data =  train, cost = 10, gamma =0.1)
pred.vals <- predict(svm.model, test)
print(table(pred.vals,test$not.fully.paid))
