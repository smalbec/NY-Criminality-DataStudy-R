install.packages('tidyverse')
install.packages("ggplot2")
install.packages("ggExtra")
install.packages('psych')
install.packages("dplyr")
install.packages('RColorBrewer')
library("tidyverse")
library('psych')
library("dplyr")  
library('ggplot2')
library('RColorBrewer')
library('ggExtra')

data = read.csv('data/cleanedData.csv', stringsAsFactors = FALSE)

describe.by(data) 


options(scipen=10000)
average = data %>% group_by(County) %>% summarise(AidAmountMean = mean(AidAmount)) %>%
  ggplot(aes(x = reorder(County, -AidAmountMean), y = AidAmountMean))  +
  geom_bar(stat = "identity", color = 'blue') +
  theme_classic() +
  labs(
    title = paste(
      "Average Amount of Education Aid per County"
    ), x="Counties"
  ) + theme(axis.text.x = element_text(angle = 90, hjust = 1))

average

rel = data %>% group_by(County) %>% summarise(AidAmountMean = mean(AidAmount), CrimesReportedMean = mean(CrimesReported)) %>%
  ggplot(aes(x = AidAmountMean, y = CrimesReportedMean, )) + geom_point(color='darkred') 

rel
 


perCap = data %>% group_by(County) %>% 
  summarise(AidAmountMean = mean(AidAmount),PopulationMean = mean(Population), CrimesReportedMean = mean(CrimesReported))

perCap = mutate(perCap, PerCapita = AidAmountMean / PopulationMean) %>%
  ggplot(aes(x = PerCapita, y = CrimesReportedMean, )) + geom_point(color='blue') 

p2 <- ggMarginal(perCap, type="histogram", fill = "slateblue", xparams = list(  bins=10))

p2


CrimeTrend = data %>% group_by(Year) %>% summarise(CrimeSum = sum(CrimesReported)) %>%
  ggplot(aes(x = Year, y = CrimeSum, )) + geom_line(color='black') +
  labs(
    title = paste(
      "Crimes reported rend towards the years"
    ))
CrimeTrend

JailTrend = data %>% group_by(Year) %>% summarise(JailSum = sum(JailPopulation)) %>%
  ggplot(aes(x = Year, y = JailSum, )) + geom_line(color='salmon')+
  labs(
    title = paste(
      "Jail Population Trend towards the years"
    ))
JailTrend

