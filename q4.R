library(ggplot2)
library(dplyr)
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

#select coal combustion sources
coal <- SCC[grep("Coal", SCC$SCC.Level.Three), ]
coalCombustion <-coal[grep("Combustion", coal$SCC.Level.One), ]
coalCombustionSources <- coalCombustion$SCC


##extract rows related to coal combustion
ccRows <- NEI[NEI$SCC %in% coalCombustionSources,]

#calculate total emissions by year
totalEmissions <- ccRows %>% 
  group_by(year) %>% 
  summarise(Emissions = sum(Emissions))

png("q4.png" , width = 480, height = 480,units="px");
plot(totalEmissions$year, totalEmissions$Emissions,type='b', ylab = "Total emissions (tons)",xlab="",xaxt = "n", main="Coal combustion-related sources")
axis(side =1, at = totalEmissions$year)
dev.off()