# Guide to using tidyr¶
# Now that we've learned about dplyr we can begin to learn about tidyr which is a complementary 
# package that will help us create tidy data sets! So what do we mean when we say "tidy data"?
# 
# Tidy data is when we have a data set where every row is an observation and every column is a 
# variable, this way the data is organized in such a way where every cell is a value for a specific 
# variable of a specific observation. Having your data in this format will help build an understanding 
# of your data and allow you to analyze or visualize it quickly and efficiently.

# Data.frames versus data.tables
# All data.tables are also data.frames. Loosely speaking, you can think of data.tables as data.frames 
#with extra features.
# 
# data.frame is part of base R.

# So what are some of the practical differences? Here are a few:
#   - much faster and very intuitive by operations
#   - You won't accidentally print out a huge data.frame with the need to press Ctrl-C, data.table prevents 
#     this sort of accident
#   - faster and better file reading with fread
#   - the package also provides a number of other utility functions, like %between% or rbindlist that make life better
#   - pretty much faster for a lot of basic operations, since a lot of data.frame operations copy the entire thing needlessly

library(tidyr)
library(data.table)

comp <- c(1,1,1,2,2,2,3,3,3)
yr <- c(1998,1999,2000,1998,1999,2000,1998,1999,2000)
q1 <- runif(9, min=0, max=100)
q2 <- runif(9, min=0, max=100)
q3 <- runif(9, min=0, max=100)
q4 <- runif(9, min=0, max=100)

df <- data.frame(comp=comp,year=yr,Qtr1 = q1,Qtr2 = q2,Qtr3 = q3,Qtr4 = q4)

print(df)

#     gather()
# gather( data, key = "key", value = "value",  ..., na.rm = FALSE, convert = FALSE, factor_key = FALSE)
#  will collapse multiple columns into key-pair values
gathered <- gather(df, Quater, Revenue, Qtr1:Qtr4)
print(gathered)

# Using Pipe Operator
head(df %>% gather(Quarter,Revenue,Qtr1:Qtr4))


#     spread()
# This is the complement of gather(), which is why its called spread():
stocks <- data.frame(
  time = as.Date('2009-01-01') + 0:9,
  X = rnorm(10, 0, 1),
  Y = rnorm(10, 0, 2),
  Z = rnorm(10, 0, 4)
)
print(stocks)
stoks.gathered <- gather(stocks, stock, price, X, Y, Z)
print(head(stoks.gathered))

# Using Pipe Operator
stocksm <- stocks %>% gather(stock, price, -time)
print(stocksm) # returns the gathered table


#will spread the table back
stocksm <- stocksm %>% spread(stock, price)
print(stocksm)

#     separate()
# Given either regular expression or a vector of character positions, separate() turns
# a single character column into multiple columns.

df <- data.frame(x = c(NA, "a.x", "b.y", "c.z"))
print(df)
df.separated <-df %>% separate(x, c("ABC", "XYZ"))
print(df.separated)


#       unite()
# Unite is a convenience function to paste together multiple columns into one.
unite.mtcars<- unite_(mtcars, "vs.am", c("vs","am"),sep = '.')
print(head(unite.mtcars))

# Separate is the complement of unite
mtcars %>%
  unite(vs_am, vs, am) %>%
  separate(vs_am, c("vs", "am"))

print(head(mtcars))
