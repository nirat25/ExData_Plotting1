## The script below is divided in two parts, getting and formatting the data and then 
## plotting the data as required

# GETTING AND FORMATTING DATA

                ## Using read.table and skipping first 66637 rows i.e. minutes in 16/12/2006 17:24:00 to 02/07/2007 
                ## and reading only 2880 rows which is 2 days * 24 hours * 60 minutes
                ## Also to retain header names Assign the col.names by reading first row of the same file
        
rawdata <- read.table("household_power_consumption.txt",skip = 66637, nrow = 2880,sep = ";",col.names = colnames(read.table("household_power_consumption.txt",nrow = 1,header = TRUE, sep=";")),as.is = TRUE, na.strings = "?")

        retainnames <- names(rawdata)                                            # Store the header names for future use

rawdata1 <- cbind(as.Date(rawdata[,1],"%d/%m/%Y"),rawdata[,-1])                  # convert the date column from character to R date format
        names(rawdata1) <-  retainnames                                          #Assign proper names by using the stored header names

extracttime <- paste(rawdata1[,1],rawdata1[,2])                                  #Get the time and date as one entity

        extracttime <- strptime(extracttime, "%Y-%m-%d %H:%M:%S")                #Convert the single entity into R time and date format using strptime() funciton

plotdata <- cbind(rawdata1[,1],extracttime,rawdata1[,c(-1,-2)],extracttime)      #Get the final dataframe with required date and time format and a new column of single "datetime" entity with correct R format
        names(plotdata) <- c(retainnames,"datetime")                             #Assign correct header names

# PLOTTING THE DATA

png(filename = "plot2.png")                                                      #Open PNG graphics device 

                ## Plot the data with required annotations and type of plot

with(plotdata, plot(datetime,Global_active_power, type ="l",xlab = "", ylab = "Global Active Power (kilowatts)"))

dev.off()                                                                        #Close the PNG graphics device

