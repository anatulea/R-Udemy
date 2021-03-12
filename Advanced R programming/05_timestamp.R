# Timestamps
#   R gives us a variety of tools for working with timestamp information. Let's start off by exploring the Date object:
#   
#   Dates
#     You can use the as.Date() function to convert a character string to a Date object, which will allow it to contain
#     more time information. The string will need to be in a standard time format. We can ask for today's date by asking 
#     the system (Sys.) for the Date:

today <- Sys.Date()
print(today) #"2021-03-11"


# Using Format
as.Date("Nov-03-90",format="%b-%d-%y")

# Using Format
as.Date("November-03-1990",format="%B-%d-%Y")

as.POSIXct("11:02:03",format="%H:%M:%S")

as.POSIXct("November-03-1990 11:02:03",format="%B-%d-%Y %H:%M:%S")

strptime("11:02:03",format="%H:%M:%S")