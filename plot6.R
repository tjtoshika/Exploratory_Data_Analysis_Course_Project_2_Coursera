scc_source <- scc[grep('Highway Veh', scc$Short.Name), "SCC"]
scc_source <- as.character(scc_source)
library(dplyr)
motor_veh_emis <- nei %>% filter((fips == "24510" | fips == "06037")  & SCC %in% scc_source) %>% select(Emissions, year,fips) %>% group_by(fips,year) %>% summarize(total = sum(Emissions, na.rm = TRUE))

motor_veh_emis$total <- round(motor_veh_emis$total, digits = 1)
motor_veh_emis_1$fips <- sub('06037', 'Los Angeles', motor_veh_emis_1$fips)
motor_veh_emis_1$fips <- sub('24510', 'Baltimore', motor_veh_emis_1$fips)
motor_veh_emis_1$year <- as.factor(motor_veh_emis_1$year)

library(ggplot2)

png("plot6.png",width=1080,height=480,units="px",bg="transparent")
ggplot(motor_veh_emis_1, aes(year, total, fill = fips)) + geom_bar(stat = 'identity')+facet_wrap(~fips) + theme(strip.background = element_blank(), strip.text = element_blank()) + labs(title = 'Comparison of Emissions of Los Angeles and Baltimore from Motor Vehicle Sources 1999-2008', x = 'Year', y = 'Emissions in tons', fill = 'City')
dev.off()
