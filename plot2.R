#' setup: load libraries
library(dplyr)

#' read in data file and filter for emissions
#' from Baltimore city (fips 24510)
NEI <- readRDS("summarySCC_PM25.rds") %>% 
  filter(fips == "24510")

#' get emissions for every year in a list
data_plot <- lapply(sort(unique(NEI$year)), function(xx) NEI$Emissions[NEI$year == xx])
names(data_plot) <- sort(unique(NEI$year))

#' plot emissions as a boxplot showing the spread and mean over all sources per year
#' and as a barplot showing the total (sum over all sources) PM2.5 emissions per year
png("plot2.png", width = 400, height = 500)
par(mfrow = c(2, 1))
boxplot(data_plot, outline = F, xlab = "Year", ylab = "PM2.5 emission in Baltimore City [tons]")
barplot(sapply(data_plot, sum), xlab = "Year", ylab = "Total PM2.5 emission in Baltimore City [tons]")
dev.off()



