# lapply()
# lapply() will apply a function over a list or vector:
#   
#   lapply(X, FUN, ...)
# where X is your list/vector and FUN is your function. 

# sample just 1 random number between 1 and 10
print(sample(x = 1:10,1)) #8 




# vector
v <- c(1,2,3,4,5)
# our custom function
addrand <- function(x){
  # Get a random number
  ran <-sample(x=1:10,1)
  # return x plus the random number
  return(x+ran)
}

# lapply()
result <- lapply(v,addrand)
print(result) # returns a list

sresult <- sapply(v,addrand)
print(sresult) # returns a vector  8  5 13 13 13

#     Anonymous Functions
# So you noticed that in the last example we had to write out an entire function to apply to the vector, 
# but in reality that function is just doing something pretty simple, adding a random number. 
# Do we really want to have to formally define an entire function for this? We don't want to, especially 
# if we only plan to use this function a single time!
# 
# To address this issue, we can create an anonymous function (called this because we won't ever name it). 
# Here's the syntax for an anonymous function in R:
# 
# function(a){code here}
# This is a similar idea to lambda expressions in Python. So for example we can rewrite the previous function
# as an anonymous function and use lapply() with it:

# Anon func with lapply() and sapply
a1 <- sapply(v, function(a){a+sample(x=1:10,1)})
print(a1)

# adds two to every element
a2 <- sapply(v,function(x){x+2})
print(a2)


add_choice <- function(num,choice){
  return(num+choice)
}

add_choice(2,3)

a3 <- sapply(v,add_choice,choice=10)
print(a3)

# sapply() limitations
# sapply() won't be able to automatically return a vector if your applied function doesn't return something for 
# all elements in that vector. For example:

# Checks for even numbers
even <- function(x) {
  return(x[(x %% 2 == 0)])
}

nums <- c(1,2,3,4,5)

c1<- sapply(nums,even)
print(c1)
