# Use R to open the Batting.csv file and assign it to a dataframe called batting using read.csv
batting <- read.csv('./CSV/Batting.csv')

# Use head() to check out the batting
print(head(batting))

# Use str() to check the structure. Pay close attention to how columns that start with a number 
# get an 'X' in front of them! You'll need to know this to call those columns!
print(str(batting))

# Make sure you understand how to call the columns by using the $ symbol.
# Call the head() of the first five rows of AB (At Bats) column
print(head(batting$AB[1:5]))

# Call the head of the doubles (X2B) column
print(head(batting$X2B))

# Create a new column called BA and add it to our data frame
batting$BA <- batting$H / batting$AB
print(tail(batting$BA,5))

# Now do the same for some new columns! On Base Percentage (OBP) and Slugging Percentage (SLG). 
# Hint: For SLG, you need 1B (Singles), this isn't in your data frame. However you can calculate 
# it by subtracting doubles,triples, and home runs from total hits (H): 1B = H-2B-3B-HR

# On Base Percentage
batting$OBP <- (batting$H + batting$BB + batting$HBP)/(batting$AB + batting$BB + batting$HBP + batting$SF)

# Creating X1B (Singles)
batting$X1B <- batting$H - batting$X2B - batting$X3B - batting$HR

# Creating Slugging Average (SLG)
batting$SLG <- ((1 * batting$X1B) + (2 * batting$X2B) + (3 * batting$X3B) + (4 * batting$HR) ) / batting$AB
print(str(batting))

# Load the Salaries.csv file into a dataframe called sal using read.csv
sal <- read.csv('./CSV/Salaries.csv')

# Use summary to get a summary of the batting data frame and notice the minimum year in the yearID column.
# Our batting data goes back to 1871! Our salary data starts at 1985, meaning we need to remove the batting
# data that occured before 1985
print(summary(sal))

# Use subset() to reassign batting to only contain data from 1985 and onwards
batting <- subset(batting, yearID >= 1985)
# Now use summary again to make sure the subset reassignment worked, your yearID min should be 1985
print(summary(batting))

# Use the merge() function to merge the batting and sal data frames by c('playerID','yearID'). Call the new data frame combo
combo <- merge(batting,sal,by=c('playerID','yearID'))
print(summary(combo))


# Use the subset() function to get a data frame called lost_players from the combo data frame consisting of those 3 players. 
# Hint: Try to figure out how to use %in% to avoid a bunch of or statements!
lost_players <- subset(combo,playerID %in% c('giambja01','damonjo01','saenzol01') )
print(lost_players)


# Use subset again to only grab the rows where the yearID was 2001. 
lost_players <- subset(lost_players,yearID == 2001)


# Reduce the lost_players data frame to the following columns: playerID,H,X2B,X3B,HR,OBP,SLG,BA,AB

lost_players <- lost_players[,c('playerID','H','X2B','X3B','HR','OBP','SLG','BA','AB')]
print(head(lost_players))


library(dplyr)
avail.players <- filter(combo,yearID==2001)

library(ggplot2)
pl <- ggplot(avail.players,aes(x=OBP,y=salary)) + geom_point()
print(pl)

avail.players <- filter(avail.players,salary<8000000,OBP>0)

# The total AB of the lost players is 1469. This is about 1500, meaning I should probably cut off my avail.players at 1500/3= 500 AB.
avail.players <- filter(avail.players,AB >= 500)

possible <- head(arrange(avail.players,desc(OBP)),10)

possible <- possible[,c('playerID','OBP','AB','salary')]
print(possible)
print(possible[2:4,])
