library(ggplot2)
library(ggplot2movies)
#> install.packages("ggplot2movies")
df <- movies <- movies[sample(nrow(movies), 1000), ]
#print(head(df))

# DATA and AESTHETICS
pl<- ggplot(df, aes(x=rating))

# GEOMETRY LAYER
histo <- pl + geom_histogram()
print(histo)

# Adding Color
histo <- pl + geom_histogram(binwidth=0.1, color='red', fill='pink', alpha=0.2)
print(histo)

# Adding Labels
pl <- ggplot(df,aes(x=rating))
histo <- pl + geom_histogram(binwidth=0.1,color='red',fill='pink') + xlab('Movie Ratings')+ ylab('Occurences') + ggtitle(' Movie Ratings')
print(histo)

# Change Alpha (Transparency)
pl <- ggplot(df,aes(x=rating))
histo.blue<- pl  + geom_histogram(binwidth=0.1,fill='blue',alpha=0.4) + xlab('Movie Ratings')+ ylab('Occurences')
print(histo.blue)

#Linetypes
# We have the options: "blank", "solid", "dashed", "dotted", "dotdash", "longdash", and "twodash". 
# You would never really use these with a histogram, but just to show your options:

pl <- ggplot(df,aes(x=rating))
linetypes.histo <- pl + geom_histogram(binwidth=0.1,color='blue',fill='pink',linetype='longdash') + xlab('Movie Ratings')+ ylab('Occurences')
print(linetypes.histo)


# Advanced Aesthetics
# We can add a aes() argument to the geom_histogram for some more advanced features.
# Adding Labels
pl <- ggplot(df,aes(x=rating))
fill.histo <- pl + geom_histogram(binwidth=0.1,aes(fill=..count..)) + xlab('Movie Ratings')+ ylab('Occurences')
print(fill.histo)

# You can further edit this by adding the scale_fill_gradient() function to your ggplot objects:
# Adding Labels
pl <- ggplot(df,aes(x=rating))
pl2 <- pl + geom_histogram(binwidth=0.1,aes(fill=..count..)) + xlab('Movie Ratings')+ ylab('Occurences')
# scale_fill_gradient('Label',low=color1,high=color2)
grad.histo <- pl2 + scale_fill_gradient('Count',low='blue',high='red')
print(grad.histo)
