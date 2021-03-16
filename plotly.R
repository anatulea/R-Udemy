library(plotly)
library(ggplot2)
pl <- ggplot(mtcars, aes(mpg, wt)) +geom_point()
print(pl)

gpl <- ggplotly(pl)

print(gpl)
# https://plotly.com/ggplot2/