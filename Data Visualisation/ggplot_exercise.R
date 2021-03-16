library(ggplot2)
library(ggthemes)

# Histogram of hwy mpg values:
print(head(mpg))
pl <- ggplot(mpg, aes(x=hwy)) + geom_histogram(aes(fill= 'red'), bins = 20)
print(pl)

# Barplot of car counts per manufacturer with color fill defined by cyl count
pl2 <- ggplot(mpg, aes(x= manufacturer)) + geom_bar(aes( fill=factor(cyl)))
print(pl2)

# Switch now to use the txhousing dataset that comes with ggplot2
tx <- txhousing
# Create a scatterplot of volume versus sales. Afterwards play 
# around with alpha and color arguments to clarify information.

p3 <-ggplot(tx, aes(x=sales, y=volume)) + geom_point(alpha=0.3, color ="blue")
print(p3)

# Add a smooth fit line to the scatterplot from above. 
# Hint: You may need to look up geom_smooth()
p4 <-ggplot(tx, aes(x=sales, y=volume)) + geom_point(alpha=0.3, color ="blue")+geom_smooth(color='red')
print(p4)