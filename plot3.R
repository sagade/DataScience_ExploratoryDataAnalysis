#' setup: load libraries
library(dplyr)
library(ggplot2)


#' read in both data files and filter for emissions
#' from Baltimore city (fips 24510)
NEI <- readRDS("summarySCC_PM25.rds") %>% 
  filter(fips == "24510")

#' plot emissions as a boxplot showing the spread and mean over all sources per year
#' and as a barplot showing the total (sum over all sources) PM2.5 emissions per year
pl <- ggplot(data = NEI, aes(x = factor(year), y = Emissions)) +
  geom_bar(stat = 'sum') +
  facet_wrap(~type) +
  xlab("Year") + ylab("Total PM2.5 emission in Baltimore City [tons]") +
  scale_size(guide = FALSE)

png("plot3.png", width = 400, height = 400)
print(pl)
dev.off()



