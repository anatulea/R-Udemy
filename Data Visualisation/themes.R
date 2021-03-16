library(ggplot2)
library(ggthemes)

# There are a lot of built-in themes in ggplot and you can use them in two ways,
# by stating before your plot to set the theme:
#   
#   theme_set(theme_bw())
# 
# or by adding them to your plot directly:
#   
#   my_plot + theme_bw()

theme_set(theme_minimal())

pl <- ggplot(mtcars, aes(x=wt, y=mpg)) +geom_point()
print(pl)

# install.packages('ggthemes')
print(pl + theme_wsj())
print(pl + theme_economist())