library(ggplot2)
library(dplyr)
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

NEIBaltimore <- subset( NEI, fips=="24510")
NEILosAngeles <- subset( NEI, fips=="06037")

#select motor vehicle sources
mobileSources <- SCC[SCC$SCC.Level.One == 'Mobile Sources', ]
motorVehicles <- mobileSources[grep("Vehicles", mobileSources$SCC.Level.Two), ]
motorVehiclesSources <- motorVehicles$SCC


##extract rows related to motor vehicles
mvRowsBaltimore <- NEIBaltimore[NEIBaltimore$SCC %in% motorVehiclesSources,]
mvRowsLosAngeles <- NEILosAngeles[NEILosAngeles$SCC %in% motorVehiclesSources,]

#calculate total emissions by year
totalEmissionsBaltimore <- mvRowsBaltimore %>% 
  group_by(year, fips) %>% 
  summarise(Emissions = sum(Emissions))

totalEmissionsLosAngeles <- mvRowsLosAngeles %>% 
  group_by(year, fips) %>% 
  summarise(Emissions = sum(Emissions))


totalEmissions <- rbind(totalEmissionsBaltimore, totalEmissionsLosAngeles)
#Add column city for a nice legend
totalEmissions <- within(totalEmissions, {city = ifelse(fips == '24510', 'Baltimore', 'Los Angeles')})

g <-ggplot(totalEmissions, aes(year, Emissions, color=factor(city)))+geom_line()+geom_point()+theme(legend.title=element_blank())
g <- g+ ggtitle("Emissions from motor vehicle sources in Baltimore City and Los Angeles")


png("q6.png" , width = 480, height = 480,units="px");
print(g)
dev.off()