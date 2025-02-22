# Ex 1: Recreate the following dataframe by creating vectors and using the data.frame function:

Age <- c(22,25,26)
Weight <- c(150, 165, 120)
Sex <- c('M', 'M', 'F')
name <- c('Sam', 'Frank', 'Amy')
df <- data.frame(row.names=name ,Age, Weight, Sex)
print(df)

rownames(df)<-c('A','B','C')
print(df)
#    Age Weight Sex
# A  22    150   M
# B  25    165   M
# C  26    120   F


#Ex 2: Check if mtcars is a dataframe using is.data.frame()
print(is.data.frame(mtcars))

# Ex 3: Use as.data.frame() to convert a matrix into a dataframe:
mat <- matrix(1:25, nrow=5)
mat <- as.data.frame(mat)
print(is.data.frame(mat))

# Ex 4: Set the built-in data frame mtcars as a variable df. 
# We'll use this df variable for the rest of the exercises.
df <- mtcars

# Ex 5: Display the first 6 rows of df
six.rows <- df[1:6,]
print(six.rows)

# Ex 6: What is the average mpg value for all the cars?
avreage.mpg <- mean(df$mpg)
print(avreage.mpg)

# Ex 7: Select the rows where all cars have 6 cylinders (cyl column)
six.cylinders <- subset(df, cyl== 6)
print('------------')
print(six.cylinders)
print(df[df$cyl ==6, ]) # other method


# Ex 8: Select the columns am,gear, and carb.
select.cols <- df[, c('am', 'gear', 'carb')]
print(select.cols)

# Ex 9: Create a new column called performance, which is calculated by hp/wt.
df$performance <- df$hp/df$wt
print(head(df))

# Ex 10: Your performance column will have several decimal place precision.
# Figure out how to use round() (check help(round)) to reduce this accuracy to only 2 decimal places.
df$performance  <- round(df$performance, digits = 2)
print(head(df))


# Ex 11: What is the average mpg for cars that have more than 100 hp AND a wt value of more than 2.5.
average.mpg <- mean(subset(df, hp >100 & wt >2.5)$mpg)
print(average.mpg)

# Ex 12: What is the mpg of the Hornet Sportabout?
hornet.sportabout <- df['Hornet Sportabout', 'mpg']
print(hornet.sportabout)
print(df$mpg['Hornet Sportabout']) # should work but it doesn't



