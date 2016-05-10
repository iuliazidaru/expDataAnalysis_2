
##load files
if(!exists("NEI")){
  NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
}

## Compare emissions from motor vehicle sources in Baltimore City with emissions 
## from motor vehicle sources in Los Angeles County, California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). 
## Which city has seen greater changes over time in motor vehicle emissions?

# merge data sets 
if(!exists("NEI_SCC")){
  NEI_SCC <- merge(NEI, SCC, by="SCC")
}

library(ggplot2)

subsetNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]

total_year_fips <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
total_year_fips$fips[total_year_fips$fips=="24510"] <- "Baltimore, MD"
total_year_fips$fips[total_year_fips$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png", width=1040, height=480)
g <- ggplot(total_year_fips, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
  xlab("Year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle("Total Motor Vehicle Emissions in Baltimore City vs Los Angeles: 1999 - 2008")
print(g)
dev.off()