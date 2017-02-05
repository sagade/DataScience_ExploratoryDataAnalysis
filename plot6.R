#' setup: load libraries
library(dplyr)
library(ggplot2)
library(cowplot)


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
  filter(grepl("Vehicle", Short.Name)) %>% 
  filter(fips == "24510" | fips == "06037") %>% 
  mutate(City = ifelse(fips == "24510", "Baltimore City", "Los Angeles")) %>% 
  group_by(City, year) %>% 
  summarize(Emissions = sum(Emissions, na.rm = T)) %>% 
  ungroup()
 
 
#' produce point/line plot of the PM2.5 emissions (vehicle related of the two cities)
pl1 <- NEI %>% 
  mutate(year = factor(year)) %>% 
  ggplot(aes(x = year, y = Emissions, group = City)) +
  geom_point(aes(color = City)) +
  geom_line(aes(color = City)) +
  xlab("Year") + ylab("Total PM2.5 vehicle related emission [tons]")

png("plot6.png", width = 600, height = 400)
print(pl1)
dev.off()



