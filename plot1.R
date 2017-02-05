#' read in summary PM2.5 data file
NEI <- readRDS("summarySCC_PM25.rds")

#' get emissions for every year in a list
data_plot <- lapply(sort(unique(NEI$year)), function(xx) NEI$Emissions[NEI$year == xx])
names(data_plot) <- sort(unique(NEI$year))

#' plot emissions as a boxplot showing the spread and mean over all sources per year
#' and as a barplot showing the total (sum over all sources) PM2.5 emissions per year
png("plot1.png", width = 400, height = 500)
par(mfrow = c(2, 1))
boxplot(data_plot, outline = F, xlab = "Year", ylab = "PM2.5 emission [tons]")
barplot(sapply(data_plot, sum), xlab = "Year", ylab = "Total PM2.5 emission [tons]")
dev.off()



