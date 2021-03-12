library(dplyr)
df <- mtcars

# Nesting
result<- arrange(sample_n(filter(df,mpg>20), size=5),desc(mpg))
print(result)

# Multiple Assignments
a<- filter(df,mpg>20)
b<- sample_n(a,size=5)
result2 <- arrange(b, desc(mpg))
print(result2)

# Use the PIPE OPERATOR
# Data %>% op1 %>% op2 %>% op3
result3 <- df %>% filter(mpg>20) %>% sample_n(size=5)  %>% arrange(desc(mpg))
print(result3)