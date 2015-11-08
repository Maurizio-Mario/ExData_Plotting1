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

## Plot3 and saving in png format as plot3.png

date_time <- paste(pa1_dat$Date, pa1_dat$Time)

pa1_dat$date_time <- as.POSIXct(date_time)

png(filename = "plot3.png", height = 480, width = 480)
with(pa1_dat, {
        plot(Sub_metering_1 ~ date_time, type="l",
             ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2 ~ date_time, col='Red')
        lines(Sub_metering_3 ~ date_time, col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
axis(1, c(0, 1440, 2880), c("Thu", "Fri", "Sat"))
dev.off()
