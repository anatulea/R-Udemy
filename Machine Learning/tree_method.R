# Decision Trees and Random Forests
# Growing a Decision Tree
#install.packages('rpart')
library(rpart)
print(str(kyphosis))

print(head(kyphosis))
tree <- rpart(Kyphosis~., method='class', data=kyphosis)

# Examining Results of the Tree Model
printcp(tree)

# Tree Visualization
plot(tree, uniform = T, main="Kyphosis Tree")
text(tree, use.n=T, all=T)

# The rpart.plot library package makes these visualizations much better.
# install.packages('rpart.plot')
library(rpart.plot)
prp(tree)

#           Random Forests
# Random forests improve predictive accuracy by generating a large number of bootstrapped trees (based on random samples of variables), classifying a case using each tree in this new "forest", and deciding a final predicted outcome by combining the results across all of the trees (an average in regression, a majority vote in classification).

# install.packages('randomForest')
library(randomForest)

rf.model <- randomForest(Kyphosis~., data=kyphosis)
print(rf.model)

importance <-importance(rf.model) # importance of each predictor
print(importance)
