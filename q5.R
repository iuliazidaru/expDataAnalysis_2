library(ggplot2)
library(dplyr)
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

NEIBaltimore <- subset( NEI, fips=="24510")


#select motor vehicle sources
mobileSources <- SCC[SCC$SCC.Level.One == 'Mobile Sources', ]
motorVehicles <- mobileSources[grep("Vehicles", mobileSources$SCC.Level.Two), ]
motorVehiclesSources <- motorVehicles$SCC


##extract rows related to motor vehicles
mvRowsBaltimore <- NEIBaltimore[NEIBaltimore$SCC %in% motorVehiclesSources,]

#calculate total emissions by year
totalEmissions <- mvRowsBaltimore %>% 
  group_by(year) %>% 
  summarise(Emissions = sum(Emissions))

png("q5.png" , width = 480, height = 480,units="px");
plot(totalEmissions$year, totalEmissions$Emissions,type='b', ylab = "Total emissions (tons)",xlab="",xaxt = "n", main="Emissions from motor vehicle source in Baltimore City")
axis(side =1, at = totalEmissions$year)
dev.off()