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
NEI <- NEI %>% 
  left_join(SCC) %>% 
  filter(grepl("Coal", Short.Name))

#' Get emissions per year
data_plot <- lapply(sort(unique(NEI$year)), function(xx) NEI$Emissions[NEI$year == xx])
names(data_plot) <- sort(unique(NEI$year))

#' plot emissions as a boxplot showing the spread and mean over all coal related sources per year
#' and as a barplot showing the total (sum over all sources) coal related PM2.5 emissions per year
png("plot4.png", width = 400, height = 500)
par(mfrow = c(2, 1))
boxplot(data_plot, outline = F, xlab = "Year", ylab = "PM2.5 coal related emission [tons]")
barplot(sapply(data_plot, sum), xlab = "Year", ylab = "Total PM2.5 coal related emission [tons]")
dev.off()



