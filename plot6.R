# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

library(dplyr)
library(ggplot2)

# Read the data
NEI <- readRDS("./data/raw/summarySCC_PM25.rds")
SCC <- readRDS("./data/raw/Source_Classification_Code.rds")

# Find all SCC codes from any of the coal sectors
sccVehicle <- subset(SCC, grepl('vehicle',EI.Sector, ignore.case = T), SCC)

# calculate total  US PM2.5 for each year (convert ton to kiloton) for
# vehicle related sources for Baltimore & Los Angeles county
total_PM2.5_by_year <- NEI %>% 
  filter(SCC %in% sccVehicle$SCC, fips == "24510" | fips == "06037") %>%
  group_by(year, fips) %>% 
  summarise(total=sum(Emissions)) %>%
  mutate(fips = recode(fips, "06037"="Los Angeles County", "24510"="Baltimore"))

# use ggplot col graph, grid 2 wide, graphs grouped by fip, each graph own scale
# output to png
png('plot6.png', width = 480, height = 480)

ggplot(total_PM2.5_by_year, aes(as.factor(year), total)) +
  facet_wrap(. ~ fips, ncol = 2, scales="free") +
  geom_col() +
  labs(title = "Vehicle Related PM2.5 Emissions") +
  labs(x = "Year", y = "PM2.5 Emissions (tons)")

dev.off()
