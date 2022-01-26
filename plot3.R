# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999–2008 
# for Baltimore City? Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

library(dplyr)
library(ggplot2)

# Read the data
NEI <- readRDS("./data/raw/summarySCC_PM25.rds")

# calculate total PM2.5 for each source type by year for Baltimore
total_PM2.5_by_year <- NEI %>% 
  filter(fips == "24510") %>%
  group_by(year, type) %>% 
  summarise(total=sum(Emissions))

# use ggplot col graph, grid 2 wide, graphs grouped by type, each graph own scale
# output to png
png('plot3.png', width = 480, height = 480)

ggplot(total_PM2.5_by_year, aes(as.factor(year), total)) +
  facet_wrap(. ~ type, ncol = 2, scales="free") +
  geom_col() +
  labs(title = "Baltimore Total PM2.5 Emissions by Source Type") +
  labs(x = "Year", y = "PM2.5 Emissions (tons)")

dev.off()
