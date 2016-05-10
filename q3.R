library(ggplot2)
library(dplyr)
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

NEIBaltimore <- subset( NEI, fips=="24510")
totalEmissions <- NEIBaltimore %>% 
  group_by(year, type) %>% 
  summarise(Emissions = sum(Emissions))

g <-ggplot(totalEmissions, aes(year, Emissions, color=factor(type)))+geom_line()+geom_point()+theme(legend.title=element_blank())
g <- g+ ggtitle("Emissions evolution by type in Baltimore city")
# geom_smooth()  my be used for a smoother graph

png("q3.png" , width = 480, height = 480,units="px");
print(g)
dev.off()