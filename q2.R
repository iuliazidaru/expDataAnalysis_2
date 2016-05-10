library(dplyr)
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

NEIBaltimore <- subset( NEI, fips=="24510")

#calculate total emissions by year
totalEmissions <- NEIBaltimore %>% 
  group_by(year) %>% 
  summarise(Emissions = sum(Emissions))

png("q2.png" , width = 480, height = 480,units="px");
plot(totalEmissions$year, totalEmissions$Emissions,type='b', ylab = "Total emissions (tons)",xlab="",xaxt = "n", main="The total PM2.5 emission in Baltimore City, Maryland")
axis(side =1, at = totalEmissions$year)
dev.off()

