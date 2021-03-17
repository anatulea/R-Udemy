# Linear Regression Lecture
# Linear Regression is a supervised learning algorithm, meaning we'll have 
# labeled data and try to predict new labels on unlabeled data


# Get our Data
# Read CSV, note the delimiter (sep)
df<- read.csv('../CSV/student-mat.csv', sep =';')
print(df)

# Clean the Data
# Check for NA values
# Let's see if we have any NA values:
print(any(is.na(df))) #false

# Categorical Features
print(str(df))

# Exploratory Data Analysis
library(ggplot2)
library(ggthemes)
library(dplyr)

# Correlation and CorrPlots
# Correlation plots are a great way of exploring data and seeing if there are any interaction terms.

# Grab only numeric columns
num.cols <-sapply(df, is.numeric) # returns onlu numeric columns

# Filter to numeric columns for correlation
cor.data <- cor(df[,num.cols]) #used cor() function
print(cor.data)

# Visualize all this data

# install.packages('corrgram')
# install.packages('corrplot')

library(corrplot)
library(corrgram)

# USE CORRPLOT
pl1 <- corrplot(cor.data, method='color')
print(pl1)

#USE CORREGRAM
pl2 <- corrgram(df)
print(pl2)

pl3<-corrgram(df, order=TRUE, lower.panel = panel.shade, upper.panel = panel.pie, text.panel = panel.txt)
print(pl3) #blue positive correlation, red-negative


# USE GGPLOT2
pl4 <-ggplot(df, aes(G3)) + geom_histogram(bins=20, alpha=0.5, fill='blue')+theme_minimal()
print(pl4)


#         Building a Model
# Split the data into TRAIN and TEST set
# install.packages('caTools')
library(caTools)
# Set a random see so your "random" results are the same as this notebook
# set a seed
set.seed(101)

# Split up the sample, basically randomly assigns a booleans to a new column "sample"
sample <- sample.split(df$G3, SplitRatio = 0.7)

# Train data 70% of data
train <- subset(df, sample == TRUE)

# Test data 30% of data
test <-subset(df, sample == FALSE)


# Training our Model
# The general m0del formula of building a liniar regresion model in r

# ----->  model <- lm(y ~ X1 + X2, data)
# our model 
model <- lm(G3 ~., data = train) # lm() funct . is for all data

# interpret the model
print(summary(model))


# Visualize our Model
# Grab residuals
res <- residuals(model)

# Convert to DataFrame for gglpot
res <- as.data.frame(res)
print(head(res))


# Histogram of residuals
pl6 <- ggplot(res,aes(res)) +  geom_histogram(bins=20,fill='blue',alpha=0.5)
print(pl6)

print(plot(model)) # hit Return to see the rest of the plots


              # Predictions
# Let's test our model by predicting on our testing set:
G3.predictions <-predict(model, test)

# Now we can get the root mean squared error, a standardized measure of how off we were with our predicted values:
results <- cbind(G3.predictions, test$G3)
colnames(results) <- c('pred', 'real')
results <- as.data.frame(results)
print(head(results))

# let's take care of negative predictions
to_zero <- function(x){
  if(x<0){
    return (0)
  }else{
    return (x)
  }
}

#Apply zero function
results$pred <-sapply(results$pred, to_zero)

# Mean square error
mse <-mean((results$real-results$pred)^2)
print(mse)

#Or the root mean squared error:
print(mse^0.5)

# Or just the R-Squared Value for our model (just for the predictions)
SSE <- sum((results$pred - results$real)^2)
SST <- sum( (mean(df$G3) - results$real)^2)

R2 <- 1 - SSE/SST
print(R2)











