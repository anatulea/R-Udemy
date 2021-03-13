# Histograms with ggplot2

 
`pl<- ggplot(df, aes(x=rating))`


`pl + geom_histogram()`

![Rplot_blank.png](img/Rplot_blank.png)

***

`pl + geom_histogram(binwidth=0.1, color='red', fill='pink', alpha=0.2)`

![Rplot_color.png](img/Rplot_color.png)

***

`pl + geom_histogram(binwidth=0.1,color='red',fill='pink') + xlab('Movie Ratings')+ ylab('Occurences') + ggtitle(' Movie Ratings')`

![Rplot_labels.png](img/Rplot_labels.png)

***

`pl  + geom_histogram(binwidth=0.1,fill='blue',alpha=0.4) + xlab('Movie Ratings')+ ylab('Occurences')`

![Rplot_blue.png](img/Rplot_blue.png)

***

`pl + geom_histogram(binwidth=0.1,color='blue',fill='pink',linetype='longdash') + xlab('Movie Ratings')+ ylab('Occurences')`

![Rplot_linetypes.png](img/Rplot_linetypes.png)

***

`pl + geom_histogram(binwidth=0.1,aes(fill=..count..)) + xlab('Movie Ratings')+ ylab('Occurences')`

![Rplot_fill.png](img/Rplot_fill.png)

***

`pl2 <- pl + geom_histogram(binwidth=0.1,aes(fill=..count..)) + xlab('Movie Ratings')+ ylab('Occurences')`
`pl2 + scale_fill_gradient('Count',low='blue',high='red')`

![Rplot_gradient.png](img/Rplot_gradient.png)