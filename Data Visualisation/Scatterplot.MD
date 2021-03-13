# Scatterplots with ggplot2

Scatter plots allow us to place points that let us see possible correlations between two features of a data set. Let's see how we can create them with ggplot!




## `pl <- ggplot(data=df,aes(x = wt,y=mpg)) `


`pl + geom_point()`

![Rplot_p1.png](img/Rplot_p1.png)

***

`pl + geom_point(aes(color=cyl), alpha= 0.5, size= 3)`

![Rplot_p2.png](img/Rplot_p2.png)

***

`pl + geom_point((aes(size=hp, color=factor(cyl))))`

![Rplot_p3.png](img/Rplot_p3.png)

***

`pl + geom_point(aes(shape=factor(cyl)))`

![Rplot_p4.png](img/Rplot_p4.png)

***

`pl + geom_point(aes(colour = hp),size=4) + scale_colour_gradient(high='red',low = "blue")`

![Rplot_p6.png](img/Rplot_p6.png)

