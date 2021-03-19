# K Means Clustering Project
# Usually when dealing with an unsupervised learning problem, its difficult to get a good measure of how well the model performed. For this project, we will use data from the UCI archive based off of red and white wines (this is a very commonly used data set in ML).

# We will then add a label to the a combined data set, we'll bring this label back later to see how well we can cluster the wine into groups.

# Use read.csv to open both data sets and set them as df1 and df2. Pay attention to what the separator (sep) is.
df1<- read.csv('../CSV/winequality-red.csv', sep= ';')
df2<- read.csv('../CSV/winequality-white.csv', sep=';')
print(head(df2))

df1$label <- 'red'
df2$label <- 'white'
# Using sapply with anon functions
# df1$label <- sapply(df1$pH,function(x){'red'})
# df2$label <- sapply(df2$pH,function(x){'white'})
print(head(df2))


# Combine df1 and df2 into a single data frame called wine.
wine <-rbind(df1, df2)
print(str(wine))

# EDA
# Create a Histogram of residual sugar from the wine data. Color by red and white wines.
library(ggplot2)
pl <- ggplot(wine, aes(residual.sugar)) + geom_histogram(aes(fill=label),color='black',bins=50) + scale_fill_manual(values = c('#ae4554','#faf7ea')) + theme_bw()

print(pl)

# Create a Histogram of citric.acid from the wine data. Color by red and white wines.
pl2 <- ggplot(wine, aes(citric.acid))+geom_histogram(aes(fill=label),color='black',bins=50)+ scale_fill_manual(values = c('#ae4554','#faf7ea')) + theme_bw()
print(pl2)
# Create a Histogram of alcohol from the wine data. Color by red and white wines.
pl3 <- ggplot(wine, aes(alcohol))+geom_histogram(aes(fill=label),color='black',bins=50)+ scale_fill_manual(values = c('#ae4554','#faf7ea')) + theme_bw()
print(pl3)

# Create a scatterplot of residual.sugar versus citric.acid, color by red and white wine.
pl4 <- ggplot(wine, aes(citric.acid,residual.sugar ))+geom_point(aes(color=factor(label)), alpha= 0.4)+ scale_color_manual(values = c('#ae4554','#faf7ea')) +theme_dark()
print(pl4)

# Create a scatterplot of volatile.acidity versus residual.sugar, color by red and white wine.
pl5 <- ggplot(wine, aes(volatile.acidity,residual.sugar ))+geom_point(aes(color=factor(label)), alpha= 0.4)+ scale_color_manual(values = c('#ae4554','#faf7ea')) +theme_dark()
print(pl5)

# Grab the wine data without the label and call it clus.data
library(dplyr)
clus.data<- select(wine, -label)
# clus.data <- wine[,1:12]s
print(head(clus.data))

# Building the Clusters
# Call the kmeans function on clus.data and assign the results to wine.cluster.
wine.cluster <-kmeans(clus.data[, 1:12], 2)
print(wine.cluster$centers)


# Evaluating the Clusters
#You usually won't have the luxury of labeled data with KMeans, but let's go ahead and see how we did!
  
#Use the table() function to compare your cluster results to the real results. Which is easier to correctly group, red or white wines?
print(table(wine.cluster$cluster,wine$label ))





