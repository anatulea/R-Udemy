library(ggplot2)
library(ggthemes)
# Import the ggplot2 data.table libraries and use fread to load the csv file 
# 'Economist_Assignment_Data.csv' into a dataframe called df (Hint: use drop=1
#  to skip the first column)
df <- read.csv('./Economist_Assignment_Data.csv',header = T, sep = ",", row.names = 1)

# Use ggplot() + geom_point() to create a scatter plot object called pl. 
# You will need to specify x=CPI and y=HDI and color=Region as aesthetics

pl <- ggplot(df,aes(x=CPI, y=HDI)) + geom_point( aes(color=factor(Region)))
# print(pl)

# Change the points to be larger empty circles. (You'll have to go back and add arguments
# to geom_point() and reassign it to pl.) You'll need to figure out what shape= and size=
pl <- ggplot(df,aes(x=CPI, y=HDI, color =Region)) + geom_point( size= 3, shape =1)
# print(pl)

# Add geom_smooth(aes(group=1)) to add a trend line
pl <- ggplot(df,aes(x=CPI, y=HDI, color =Region)) + geom_point( size= 3, shape =1)+ geom_smooth(aes(group=1), method ='lm', formula = y~log(x), se =FALSE, color='red') 
# print(pl)

# Add geom_text(aes(label=Country)) to pl2 and see what happens. (Hint: It should be way too many labels)
pl <- ggplot(df,aes(x=CPI, y=HDI, color =Region)) + geom_point( size= 3, shape =1)+ geom_smooth(aes(group=1), method ='lm', formula = y~log(x), se =FALSE, color='red')+ geom_text(aes(label=Country)) 
# print(pl)

pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

pl2 <- pl + geom_text(aes(label = Country), color = "gray20", data = subset(df, Country %in% pointsToLabel), check_overlap = TRUE)

#print(pl2)
# Add theme_bw() to your plot and save this to pl4

pl4 <-pl2+theme_bw()

# Add scale_x_continuous() and set the following arguments:
#   name = Same x axis as the Economist Plot
#   limits = Pass a vector of appropriate x limits
#   breaks = 1:10
pl5 <- pl4 + scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)", limits = c(.9, 10.5),breaks=1:10) 
# print(pl5)

# Now use scale_y_continuous to do similar operations to the y axis!
pl6 <- pl5 + scale_y_continuous(name = "Human Development Index, 2011 (1=Best)",
                                limits = c(0.2, 1.0))
# print(pl6)

# Finally use ggtitle() to add a string as a title.
pl7 <-pl6 + ggtitle("Corruption and Human development")

library(ggthemes)
pl8<- pl7 + theme_economist_white()
print(pl8)