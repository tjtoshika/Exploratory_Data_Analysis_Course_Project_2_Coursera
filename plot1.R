nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
install.packages('dplyr')
library(dplyr)
total_pm25_by_year <- select(nei, c(Emissions, year))
new_data <- total_pm25_by_year %>% group_by(year) %>% summarize(Total = sum(Emissions, na.rm = TRUE))
new_data$Total <- new_data$Total/(10^6)

png("plot1.png",width=480,height=480,units="px",bg="transparent")


plot(new_data, xlab = 'Year', ylab = 'Total Emissions(in 10^6 tons)', axes = FALSE, type = 'b', pch = 20, main = 'Total PM2.5 Emissions by Year')
ticks_year <- new_data$year
axis(side = 1 , at = ticks_year)
axis(side = 2, at = seq(3,7.5, by = 1), las = 1)
box()

dev.off()
