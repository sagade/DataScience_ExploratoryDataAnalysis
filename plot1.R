#' setup: 

#' read in both data files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


data_plot <- lapply(sort(unique(NEI$year)), function(xx) NEI$Emissions[NEI$year == xx])
names(data_plot) <- sort(unique(NEI$year))

par(mfrow = c(2, 1))
boxplot(data_plot, outline = F, xlab = "Year", ylab = "PM2.5 amount [tons]")
barplot(sapply(data_plot, sum), xlab = "Year", ylab = "Total PM2.5 amount [tons]", ylim = c(0, 1e7))
box()




