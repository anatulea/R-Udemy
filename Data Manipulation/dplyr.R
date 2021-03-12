# Guide to using dplyr
# We'll be covering the following functions:
# 
#     filter() (and slice())
#     arrange()
#     select() (and rename())
#     distinct()
#     mutate() (and transmute())
#     summarise()
#     sample_n() and sample_frac()

library(dplyr)
library(nycflights13)
print(head(flights))

#      filter()
# filter() allows you to select a subset of rows in a data frame. The first argument is the name of the data frame.
# The second and subsequent arguments are the expressions that filter the data frame
filtered.flights <- head(filter(flights,month==11,day==3,carrier=='AA'))
print(filtered.flights)

# using bracket notation instead of filter 
head(flights[flights$month == 11 & flights$day == 3 & flights$carrier == 'AA', ])


#     slice()
# We can select rows by position using slice()
sliced.flights <-slice(flights, 1:10)
print(sliced.flights)


#     arrange()
# arrange() works similarly to filter() except that instead of filtering or selecting rows,
# it reorders them. It takes a data frame, and a set of column names (or more complicated
# expressions) to order by. If you provide more than one column name, each additional 
# column will be used to break ties in the values of preceding columns:
arranged.flights <- head(arrange(flights,year,month,day,air_time))
print(arranged.flights) # arranges by the year first, then month, then day, and last airtime in asceniding order

arrange.desc <- head(arrange(flights,desc(dep_delay)))
print(arrange.desc)

#      select()
# Often you work with large datasets with many columns but only a few are actually of interest to you. 
# select() allows you to rapidly zoom in on a useful subset using operations that usually only work on 
# numeric variable positions:
carriers.col <- head(select(flights,carrier))
print(carriers.col)
carriers.cols <- head(select(flights,carrier, dep_time))
print(carriers.cols)

#       rename()
# You can use rename() to rename columns, note this is not "in-place" you'll need to reassign the 
# renamed data structures.
renamed.carrier <-head(rename(flights,airline_car = carrier))
print(renamed.carrier)


#       distinct()
# A common use of select() is to find the values of a set of variables. This is particularly useful 
# in conjunction with the distinct() verb which only returns the unique values in a table
unique.carriers <-distinct(select(flights,carrier))
print(unique.carriers)


#       mutate()
# Besides selecting sets of existing columns, it’s often useful to add new columns 
# that are functions of existing columns. This is the job of mutate():
added.new.col <- head(mutate(flights, new_col = arr_delay-dep_delay))
print(added.new.col)


#     transmute()
# Use transmute if you only want the new columns:
return.only.new.col <- head(transmute(flights, new_col = arr_delay-dep_delay))
print(return.only.new.col)


#      summarise()
# You can use summarise() to quickly collapse data frames into single rows using functions that
# aggregate results. Remember to use na.rm=TRUE to remove NA values.
summarise.avg.air.time <-summarise(flights,avg_air_time=mean(air_time,na.rm=TRUE))
print(summarise.avg.air.time)



#     sample_n() and sample_frac()
# You can use sample_n() and sample_frac() to take a random sample of rows: use sample_n() for 
# a fixed number and sample_frac() for a fixed fraction.

my.sample <-sample_n(flights,10)
print(my.sample)

# .005% of the data
myfrac<- sample_frac(flights,0.00005) # USE replace=TRUE for bootstrap sampling
print(myfrac)


