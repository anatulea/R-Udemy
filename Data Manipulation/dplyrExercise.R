# Dplyr Exercises
# Perform the following operations using only the dplyr library. We will be reviewing the following operations:
#   
#   filter() (and slice())
#   arrange()
#   select() (and rename())
#   distinct()
#   mutate() (and transmute())
#   summarise()
#   sample_n() and sample_frac()
library(dplyr)
df <- mtcars
print(head(df))

# Return rows of cars that have an mpg value greater than 20 and 6 cylinders.
filtered.cars <- filter(df, mpg>20, cyl ==6)
print(filtered.cars)


# Reorder the Data Frame by cyl first, then by descending wt.
reordered.df <- arrange(df, cyl, desc(wt))
print(head(reordered.df))

# Select the columns mpg and hp
selected.cols <- select(df, mpg, hp)
print(head(selected.cols))

# Select the distinct values of the gear column.
unique.gear <-distinct(select(df, gear))
print(unique.gear)

# Create a new column called "Performance" which is calculated by hp divided by wt.
performance.added <- mutate(df, performance = hp/wt)
print(head(performance.added))

# Find the mean mpg value using dplyr.
avg.mpg <- summarise(df ,mean(mpg, na.rm=TRUE))
print(avg.mpg)

# Use pipe operators to get the mean hp value for cars with 6 cylinders.
result <- df %>% filter(cyl == 6) %>% summarise(mean(hp))
print(result)
