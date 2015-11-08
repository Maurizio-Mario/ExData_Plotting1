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

## Plot2 and saving of plot2 as PNG file

png(filename = "plot2.png", height = 480, width = 480)
plot(pa1_dat$Global_active_power, xaxt = "n", type = "l", ylab = "Global Active Power (kilowatts)") 
axis(1, c(0, 1440, 2880), c("Thu", "Fri", "Sat"))
dev.off()
