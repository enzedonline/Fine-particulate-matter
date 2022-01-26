# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# Note: this question is quite vague: 
# 1) Only those categories that relate to the phrase "motor vehicle"?
# 2) Everything to do with "vehicle" sources (including manufacture emissions etc)
# 3) Just to do with vehicles fuel combustion emissions?
#
# Without specifics, I've gone with #2

library(dplyr)

# Read the data
NEI <- readRDS("./data/raw/summarySCC_PM25.rds")
SCC <- readRDS("./data/raw/Source_Classification_Code.rds")

# Find all SCC codes from any of the coal sectors
sccVehicle <- subset(SCC, grepl('vehicle',EI.Sector, ignore.case = T), SCC)

# calculate total  US PM2.5 for each year (convert ton to kiloton) for
# vehicle related sources for Baltimore only
total_PM2.5_by_year <- NEI %>% 
  filter(SCC %in% sccVehicle$SCC, fips == "24510") %>%
  group_by(year) %>% 
  summarise(total=sum(Emissions))

# use base bar plot, output to png
png('plot5.png', width = 480, height = 480)

with(total_PM2.5_by_year,
     barplot(height=total, 
             names.arg=year,
             ylab = "PM2.5 emitted (tons)",
             main = "Vehicle Related PM2.5 Emissions for Baltimore"
     )
)

dev.off()
