# Neural Nets
# The Data
# We will use the popular Boston dataset from the MASS package, which describes some features for houses in Boston in 1978.
library(MASS)
set.seed(101)
data <- Boston
print(head(data))

# Neural Net Model
# First you'll need to install the neural net library:
# install.packages('neuralnet')
library(neuralnet)


#       Training the Model
# As a first step, we are going to address data preprocessing. It is good practice to normalize your data before training a neural network. Depending on your dataset, avoiding normalization may lead to useless results or to a very difficult training process (most of the times the algorithm will not converge before the number of maximum iterations allowed). You can choose different methods to scale the data (z-normalization, min-max scale, etc…). Usually scaling in the intervals [0,1] or [-1,1] tends to give better results. We therefore scale and split the data before moving on:

maxs <- apply(data, 2, max) 
mins <- apply(data, 2, min)

print(maxs)
print(mins)

#Normalize the data
scaled <- as.data.frame(scale(data, center = mins, scale = maxs - mins))
print(head(scaled))

# Train and Test Sets
# Now with our standardized data, let's split it:
library(caTools)
split = sample.split(scaled$medv, SplitRatio = 0.70)

train = subset(scaled, split == TRUE)
test = subset(scaled, split == FALSE)

# Training the Model
# Call package
library(neuralnet)

# Formula for Neural Net
# For some odd reasons, the neuralnet() function won't accept a formula in the form: y~. that we are used to using. Instead you have to call all the columns added together. Here is some convience code to help quickly create that formula:

# Get column names
n <- names(train)
print(n)

# Paste together
f <- as.formula(paste("medv ~", paste(n[!n %in% "medv"], collapse = " + ")))
print(f)


nn <- neuralnet(f,data=train,hidden=c(5,3),linear.output=TRUE)

# Neural Net Visualization
#plot(nn)

# Predictions using the Model
# Compute Predictions off Test Set
predicted.nn.values <- compute(nn,test[1:13])

# Its a list returned
print(str(predicted.nn.values))

# Convert back to non-scaled predictions
true.predictions <- predicted.nn.values$net.result*(max(data$medv)-min(data$medv))+min(data$medv)

# Convert the test data
test.r <- (test$medv)*(max(data$medv)-min(data$medv))+min(data$medv)

# Check the Mean Squared Error
MSE.nn <- sum((test.r - true.predictions)^2)/nrow(test)

print(MSE.nn)s

# Visualize Error
error.df <- data.frame(test.r,true.predictions)

print(head(error.df))


library(ggplot2)
pl <-ggplot(error.df,aes(x=test.r,y=true.predictions)) + geom_point() + stat_smooth()
print(pl)
