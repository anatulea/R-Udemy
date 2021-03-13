# Boxplots with ggplot2¶
# Boxplots are convenient way of graphically depicting groups of numerical data 
# through their quartiles. Box plots may also have lines extending vertically from 
# the boxes (whiskers) indicating variability outside the upper and lower quartiles,
# hence the terms box-and-whisker plot and box-and-whisker diagram. Outliers may be 
# plotted as individual points.

library(ggplot2)
df <- mtcars

pl <- ggplot(mtcars, aes(factor(cyl), mpg))
p1<-pl + geom_boxplot()
print(p1)

p2 <- pl + geom_boxplot() + coord_flip()
print(p2)

p3<-pl + geom_boxplot(aes(fill = factor(cyl)))
print(p3)

p4 <- pl + geom_boxplot(fill = "grey", color = "blue")
print(p4)