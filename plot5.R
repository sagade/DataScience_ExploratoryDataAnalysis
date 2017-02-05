#' setup: load libraries
library(dplyr)


#' read in both data files and filter for emissions
#' from coal related sources
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds") %>% 
  select(SCC, Short.Name) %>% 
  mutate(SCC = as.character(SCC),
         Short.Name = as.character(Short.Name)) %>% 
  unique()

#' Merge the NEI data with the short name of the sources
#' filter for the word 'Vehicle' in the short name of the
#' sources to get only vehicle related sources. In addition
#' filter for the city of baltimore
NEI <- NEI %>% 
  left_join(SCC) %>% 
  filter(grepl("Vehicle", Short.Name)) %>% 
  filter(fips == "24510")
  
#' Get for each year the emissions
data_plot <- lapply(sort(unique(NEI$year)), function(xx) NEI$Emissions[NEI$year == xx])
names(data_plot) <- sort(unique(NEI$year))

#' Plot a boxplot over showing all sources and a barplot showing the total sums over all sources
png("plot5.png", width = 400, height = 500)
par(mfrow = c(2, 1))
boxplot(data_plot, outline = F, xlab = "Year", ylab = "PM2.5 vehicle related emission in Baltimore City [tons]")
barplot(sapply(data_plot, sum), xlab = "Year", ylab = "Total PM2.5 vehicle related emission in Baltimore City [tons]")
dev.off()



