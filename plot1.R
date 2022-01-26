# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

library(dplyr)

# Read the data
NEI <- readRDS("./data/raw/summarySCC_PM25.rds")

# calculate total PM2.5 for each year (convert ton to megaton)
total_PM2.5_by_year <- NEI %>% 
  group_by(year) %>% 
  summarise(total=sum(Emissions)/1e+06)

# use base bar plot, output to png
png('plot1.png', width = 480, height = 480)

with(total_PM2.5_by_year,
     barplot(height=total, 
             names.arg=year,
             ylab = "PM2.5 emitted (megatons)",
             main = "US total PM2.5 emission from all sources"
             )
)

dev.off()

