nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")


scc_source <- scc[grep('Coal', scc$Short.Name), "SCC"]
scc_source <- as.character(scc_source)


library(dplyr)

coal_comb_emmi <- nei %>% filter(SCC %in% scc_source) %>% select(Emissions,year) %>% group_by(year) %>% summarize(total = sum(Emissions/(10^5), na.rm = TRUE))
coal_comb_emmi$total <- round(coal_comb_emmi$total, digits = 1)
coal_comb_emmi$year <- as.factor(coal_comb_emmi$year)

library(ggplot2)

png("plot4.png",width=480,height=480,units="px",bg="transparent")

ggplot(coal_comb_emmi, aes(year, total)) + geom_bar(stat = 'identity') + labs(title = 'Coal Combustion Emissions 1999-2008',x = 'Year', y = 'Emissions in 10^5 tons')

dev.off()

