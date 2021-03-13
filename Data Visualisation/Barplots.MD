# Barplots with ggplot2
## `g <- ggplot(df, aes(class))`

`g + geom_bar()`
![Rplot_b1.png](img/Rplot_b1.png)

***
`g + geom_bar(aes(fill = drv))`
![Rplot_b2.png](img/Rplot_b2.png)

***
`g + geom_bar(aes(fill = drv), position = "fill")`
![Rplot_b3.png](img/Rplot_b3.png)

***
`g + geom_bar(aes(fill = drv), position = "dodge")`
![Rplot_b4.png](img/Rplot_b4.png)

***