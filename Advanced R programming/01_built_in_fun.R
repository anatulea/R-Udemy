# Built-in R Features - Data Structures
# R contains quite a few useful built-in functions to work with data structures. Here are some of the key functions to know:
#   
#   seq(): Create sequences
#   sort(): Sort a vector
#   rev(): Reverse elements in object
#   str(): Show the structure of an object
#   append(): Merge objects together (works on vectors and lists)

# seq(start,end,step size)
print(seq(0, 100, by = 3)) #  0  3  6  9 12 15 18 21 24 27 30 33 36 39 42 45 48 51 54 57 60 63 66 69 72 75 78 81 84 87 90 93 96 99

v <- c(1,4,6,7,2,13,2)
print(sort(v)) # 1  2  2  4  6  7 13
print(sort(v,decreasing = TRUE)) # 13  7  6  4  2  2  1


#   rev(): Reverse elements in object
v2 <- c(1,2,3,4,5)
print(rev(v2)) # 5 4 3 2 1

#   str(): Show the structure of an object
print(str(v)) # num [1:7] 1 4 6 7 2 13 2

#   append(): Merge objects together (works on vectors and lists)
print(append(v,v2)) # 1  4  6  7  2 13  2  1  2  3  4  5
print(sort(append(v,v2))) # 1  1  2  2  2  3  4  4  5  6  7 13


# Data Types
#     is.*(): Check the class of an R object
#     as.*(): Convert R objects
v <- c(1,2,3)
print(is.vector(v)) # TRUE
print(is.list(v)) # FALSE

print(as.list(v))
print(as.matrix(v))

