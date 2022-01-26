# Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999–2008?

library(dplyr)

# Read the data
NEI <- readRDS("./data/raw/summarySCC_PM25.rds")
SCC <- readRDS("./data/raw/Source_Classification_Code.rds")

# Find all SCC codes from any of the coal sectors
sccCoal <- subset(SCC, grepl('coal',EI.Sector, ignore.case = T), SCC)

# calculate total  US PM2.5 for each year (convert ton to kiloton) for
# coal related sources
total_PM2.5_by_year <- NEI %>% 
  filter(SCC %in% sccCoal$SCC) %>%
  group_by(year) %>% 
  summarise(total=sum(Emissions)/1e+03)

# use base bar plot, output to png
png('plot4.png', width = 480, height = 480)

with(total_PM2.5_by_year,
     barplot(height=total, 
             names.arg=year,
             ylab = "PM2.5 emitted (kilotons)",
             main = "US Total PM2.5 Emissions from \nCoal Related Sources"
     )
)

dev.off()
