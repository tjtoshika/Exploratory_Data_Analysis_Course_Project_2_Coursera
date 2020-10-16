nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

install.packages('dplyr')
library(dplyr)
install.packages('ggplot2')
library(ggplot2)

data <- baltimore_data %>% group_by(type, year) 
data1 <- data %>% summarize(total = sum(Emissions))
data1$year <- as.factor(data1$year)

png("plot3.png",width=480,height=480,units="px",bg="transparent")

ggplot(data1, aes(year, total, fill = type)) + geom_bar(stat = 'identity')+facet_wrap(~type) + theme(strip.background = element_blank(), strip.text = element_blank()) + labs(title = 'PM2.5 Emissions of Baltimore City 1999-2008 by Source type', x = 'Year', y = 'PM2.5 Emissions', fill = 'Source Type')

dev.off()