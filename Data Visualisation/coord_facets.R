library(ggplot2)
pl <- ggplot(mpg, aes(x=displ, y=hwy)) + geom_point()
print(pl)

# Setting x and y limits
pl2 <- pl + coord_cartesian(xlim=c(1,4), ylim = c(15, 30))
print(pl2)

#Aspect Ratios
pl3 <- pl+ coord_fixed(ratio =1/3)
print(pl3)

#Lay out panels in a grid
p4 <-pl + facet_grid(. ~ cyl) # by x
print(p4)

p5 <- pl + facet_grid(drv ~ .) # by y
print(p5)

p6 <- pl + facet_grid(drv ~ cyl) # by x and y
print(p6)