 # Support Vector Machines 
library(ISLR)

print(head(iris))

# Building the Model
# We'll need the e1071 library
#install.packages('e1071')
library(e1071)
# help('svm')
# svm is used to train a support vector machine. It can be used to carry out general regression and classification (of nu and epsilon-type), as well as density-estimation. 
model <- svm(Species~.,data=iris)
print(summary(model))

# Example Predictions
predicted.values<- predict(model, iris[1:4])
print(table(predicted.values, iris[,5]))

# Advanced - Tuning
# We can try to tune parameters to attempt to improve our model, you can refer to the help() documentation to understand what each of these parameters stands for. We use the tune function:
# Tune for combos of gamma 0.5,1,2
# and costs 1/10 , 10 , 100


tune.results <- tune(svm,train.x=iris[1:4],train.y=iris[,5],kernel='radial',ranges=list(cost=10^(-1:2), gamma=c(.5,1,2)))
print(summary(tune.results))

# We can now see that the best performance occurs with cost=1 and gamma=0.5. You could try to train the model again with these specific parameters in hopes of having a better model:
tuned.svm <- svm(Species ~ ., data=iris, kernel="radial", cost=1, gamma=0.5)
print('summary(tuned.svm)------------------>')
print(summary(tuned.svm))


tuned.predicted.values <- predict(tuned.svm,iris[1:4])
print('table(tuned.predicted.values)------------------>')
print(table(tuned.predicted.values,iris[,5]))


