# Regular Expressions
# Regular expressions is a general term which covers the idea of pattern searching, typically in a string (or a vector of strings).
# 
# For now we'll learn about two useful functions for regular expressions and pattern searching (we'll go deeper into this topic in general later on):
#   
#   grepl(), which returns a logical indicating if the pattern was found
# 
#  grep(), which returns a vector of index locations of matching pattern instances
text <- "Hi there, do you know who you are voting for?"
print(grepl('voting',text)) # true
print(grepl('Sammy',text))# false

v <- c('a','b','c','d')
print(grep('a',v)) #1
print(grep('c',v)) #3