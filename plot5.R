nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")


scc_source <- scc[grep('Highway Veh', scc$Short.Name), "SCC"]
scc_source <- as.character(scc_source)
library(dplyr)
motor_veh_emis <- nei %>% filter(fips == "24510" & SCC %in% scc_source) %>% select(Emissions, year) %>% group_by(year) %>% summarize(total = sum(Emissions, na.rm = TRUE))

motor_veh_emis$total <- round(motor_veh_emis$total, digits = 1)

motor_veh_emis$year <- as.factor(motor_veh_emis$year)
library(ggplot2)

png("plot5.png",width=480,height=480,units="px",bg="transparent")
ggplot(motor_veh_emis, aes(year, total)) + geom_bar(stat = 'identity') + labs(title = 'Motor Vehicle Emissions of Baltimore city 1999-2008',x = 'Year', y = 'Emissions in tons')

dev.off()
