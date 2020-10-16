nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

install.packages('dplyr')
library(dplyr)

baltimore_data <- nei %>% filter(fips == "24510") %>% select(Emissions, year) %>% group_by(year) %>% summarize(Total = sum(Emissions,na.rm = TRUE))
baltimore_data$Total <- round(baltimore_data$Total/1000, digits = 1)

png("plot2.png",width=480,height=480,units="px",bg="transparent")

plot(baltimore_data$year, baltimore_data$Total, xlab = 'Year', ylab = 'Total Emissions in 10^3 tons', main = 'Total Emissions in Baltimore City by Year', xaxt = 'n', type = 'b', pch = 20)
ticks_year <- baltimore_data$year
axis(side = 1, at = ticks_year)
dev.off()