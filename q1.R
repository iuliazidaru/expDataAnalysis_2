library(dplyr)
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")


#calculate total emissions by year
totalEmissions <- NEI %>% 
  group_by(year) %>% 
  summarise(Emissions = sum(Emissions))

png("q1.png" , width = 480, height = 480,units="px");
plot(totalEmissions$year, totalEmissions$Emissions,type='b', ylab = "Total emissions (tons)",xlab="",xaxt = "n", main="The total PM2.5 emission from all sources")
axis(side =1, at = totalEmissions$year)
dev.off()

