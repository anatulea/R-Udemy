library(rvest)
demo(package = 'rvest')
lego_movie <- read_html("http://www.imdb.com/title/tt1490017/")
lego_movie
View(lego_movie)