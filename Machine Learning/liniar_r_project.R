# Read in bikeshare.csv file and set it to a dataframe called bike.
bike <-read.csv('../CSV/bikeshare.csv')

# Check the head of df
print(head(bike))

# Exploratory Data Analysis
# Create a scatter plot of count vs temp. Set a good alpha value.
library(ggplot2)
pl <- ggplot(bike, aes(x=temp, y=count)) + geom_point(aes(color=temp), alpha=0.3)
print(pl)

# Plot count versus datetime as a scatterplot with a color gradient based on temperature. 
# You'll need to convert the datetime column into POSIXct before plotting.

bike$datetime <- as.POSIXct(bike$datetime)

pl2 <-ggplot(bike, aes(x=datetime, y=count)) + geom_point(aes(color=temp), alpha=0.3)+ scale_color_continuous(low='blue', high='red')+theme_bw()
print(pl2)

# What is the correlation between temp and count?
corellation.data <- cor(bike[, c('temp', 'count')])
print(corellation.data)

#Create a boxplot, with the y axis indicating count and the x axis begin a box for each season.

pl3 <- ggplot(bike, aes(x=season, y=count))+ geom_boxplot(aes(color=factor(season)))
print(pl3)

# Create an "hour" column that takes the hour from the datetime column. 
# You'll probably need to apply some function to the entire datetime column and reassign it. Hint:
# 
# time.stamp <- bike$datetime[4]
# format(time.stamp, "%H")

bike$hour <-sapply(bike$datetime,function(x){format(x,'%H')} )
print(bike$hour)

# Now create a scatterplot of count versus hour, with color scale based on temp. 
# Only use bike data where workingday==1.

pl4 <- ggplot(bike, aes(x=hour, y=count))+ geom_point(aes(color=hour), alpha=0.3)
print(pl4)

# - Use the additional layer: scale_color_gradientn(colors=c('color1',color2,etc..)) 
#     where the colors argument is a vector gradient of colors you choose, not just high and low.
# - Use position=position_jitter(w=1, h=0) inside of geom_point() and check out what it does.
library(dplyr)
pl5 <- ggplot(filter(bike, workingday==1), aes(hour, count)) + geom_point(position = position_jitter(w=1, h=0), aes(color=temp), alpha=0.5)+ theme_bw() # + scale_color_gradient(colours=c('dark blue', 'blue','light blue','light green','yellow', 'orange' ,'red'))
print(pl5)
                                                                                                                                                                   
# Now create the same plot for non working days:                                                                                                                                                                
pl6<- ggplot(filter(bike, workingday==0), aes(hour, count)) + geom_point(position = position_jitter(w=1, h=0), aes(color=temp), alpha=0.7)+ theme_bw() # + scale_color_gradient(colours=c('dark blue', 'blue','light blue','light green','yellow', 'orange' ,'red'))
print(pl6)


# Building the Model
#Use lm() to build a model that predicts count based solely on the temp feature, name it temp.model
temp.model <- lm(count~temp, bike)
print(summary(model))


# How many bike rentals would we predict if the temperature was 25 degrees Celsius? Calculate this two ways:
#   
#   Using the values we just got above
# Using the predict() function
# You should get around 235.3 bikes.

# Method 1 
bike.rentals <- 6.0462 + 9.1705 *25 
print(bike.rentals)

# Method 2 
temp.test<- data.frame(temp=c(25))
result <- predict(temp.model, temp.test)
print(result)


# Use sapply() and as.numeric to change the hour column to a column of numeric values.

bike$hour <- sapply(bike$hour, as.numeric)

# Finally build a model that attempts to predict count based off of the following features. Figure out if theres a way to not have to pass/write all these variables into the lm() function. Hint: StackOverflow or Google may be quicker than the documentation.

model <- lm(count ~ . -casual -registered -datetime -atemp, bike)
print(summary(model))




