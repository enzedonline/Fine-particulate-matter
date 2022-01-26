# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

library(dplyr)

# Read the data
NEI <- readRDS("./data/raw/summarySCC_PM25.rds")

# calculate total PM2.5 for each year for Baltimore
total_PM2.5_by_year <- NEI %>% 
  filter(fips == "24510") %>%
  group_by(year) %>% 
  summarise(total=sum(Emissions))

# use base bar plot, output to png
png('plot2.png', width = 480, height = 480) 

with(total_PM2.5_by_year,
     barplot(height=total, 
             names.arg=year,
             ylab = "PM2.5 emitted (tons)",
             main = "Baltimore total PM2.5 emission from all sources"
     )
)

dev.off()
