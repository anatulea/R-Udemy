# Barplots are a useful way of displaying occurence counts when a histogram isn't 
# quite what you're looking for! 
# In ggplot2, there are two types of bar charts, 
# determined by what is mapped to bar height

library(ggplot2)
df <-mpg

# counts (or sums of weights)
g <- ggplot(df, aes(class))
# Number of cars in each class:
b1<- g + geom_bar()
print(b1)

# Bar charts are automatically stacked when multiple bars are placed
# at the same location
b2 <-g + geom_bar(aes(fill = drv))
print(b2)

b3 <- g + geom_bar(aes(fill = drv), position = "fill")
print(b3)

# You can instead dodge, or fill them
b4 <-g + geom_bar(aes(fill = drv), position = "dodge")
print(b4)