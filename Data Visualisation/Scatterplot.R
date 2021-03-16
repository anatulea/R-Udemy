# Scatterplots with ggplot2
# Scatter plots allow us to place points that let us see possible correlations 
# between two features of a data set

library('ggplot2')
df <- mtcars
print(head(df))


pl <- ggplot(df, aes(x=wt, y=mpg))
p1 <- pl + geom_point()
print(p1)

# Adding 3rd feature
p2 <- pl + geom_point(aes(color=cyl), alpha= 0.5, size= 3)
print(p2)

# increased the size of the dots based on hp and changed the color based on the cyl
p3 <- pl + geom_point((aes(size=hp, color=factor(cyl))))
print(p3)


# With Shapes
pl <- ggplot(data=df,aes(x = wt,y=mpg))
p4 <- pl + geom_point(aes(shape=factor(cyl)))
print(p4)


# Better version
# With Shapes
pl <- ggplot(data=df,aes(x = wt,y=mpg))
p5 <- pl + geom_point(aes(shape=factor(cyl),color=factor(cyl)),size=4,alpha=0.6)
print(p5)

# Gradient Scales
p6 <- pl + geom_point(aes(colour = hp),size=4) + scale_colour_gradient(high='red',low = "blue")
print(p6)








