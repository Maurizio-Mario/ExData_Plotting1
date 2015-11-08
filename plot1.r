# Transform path backslashes to forward slashes. path and path2 object created via readline()

back.to.slash <- function(x) {gsub(" \\ ", "/", x)}
path2 <- back.to.slash(path)
path2
path

## read in the complete dataset. "Date" variable converted in as.Date object.

pa1_dat <- read.table(path2, header = TRUE, sep = ";", dec = ".", stringsAsFactors = FALSE, na.strings = "?")

pa1_dat$Date <- as.Date(pa1_dat$Date)

# I try to create a function which can isolate part of the dataframe according to two inputs.
sub_dates <- function(x, y) {pa1_dat[pa1_dat$Date >= x & pa1_dat$Date <= y,]}

## Subset according to dates from 2007-02-01 to 2007-02-02. Clean memory from the complete (and heavy) dataset.
pa1_dat <- sub_dates("2007-02-01", "2007-02-02")
sum(is.na(pa1_dat))
gc()

## Plot 1 and saving of plot 1 as PNG file

png(filename = "plot1.png", width = 480, height = 480)
hist(pa1_dat$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = 2)
dev.off()





