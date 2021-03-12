# Built-in R Features - Math
# We've talked a bit about some of the built-in math functions and features in R, but let's have one more look at a few of them:
#   
#   abs(): computes the absolute value.
#   sum(): returns the sum of all the values present in the input.
#   mean(): computes the arithmetic mean.
#   round(): rounds values (additional arguments to nearest)

v <- c(-1,0,1,2,3,4,5)

print(abs(-2)) # 2
print(abs(v)) # 1 0 1 2 3 4 5
print(sum(v)) #14
print(mean(v))#2
print(round(23.1231))#23
print(round(23.1231234,2))#23.12
