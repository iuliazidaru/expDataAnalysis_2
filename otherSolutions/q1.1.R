
##load files
if(!exists("NEI")){
  NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
}

## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from all
## sources for each of the years 1999, 2002, 2005, and 2008.
yeartotal<- aggregate(Emissions ~ year, NEI, sum)
png('plot1.png')
par(mar=c(5,6,4,2)) ## adjust margins
barplot(height=yeartotal$Emissions,
        names.arg=yeartotal$year,
        xlab = "Year", 
        ylab = expression('Total PM'[2.5]*' emission'),
        main = expression('US Yearly PM'[2.5]*' emissions'))
dev.off()
