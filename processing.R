#install.packages('tidyverse')
library("tidyverse")

population = read.csv('data/raw/Annual_Population_Estimates_for_New_York_State_and_Counties__Beginning_1970.csv', stringsAsFactors = FALSE)

school_aid = read.csv("data/raw/New_York_State_School_Aid__Beginning_School_Year_1996-97.csv", stringsAsFactors = FALSE)

jail = read.csv("data/raw/Jail_Population_By_County__Beginning_1997.csv", stringsAsFactors = FALSE)

crimes = read.csv("data/raw/Index_Crimes_by_County_and_Agency__Beginning_1990.csv", stringsAsFactors = FALSE)



population = select(population, -FIPS.Code)

school_aid = select(school_aid, -BEDS.Code, -District, -Base.Year, -Change, -X..Change)

jail = select(jail, -Boarded.Out,-Boarded.In, -in.House.Census, -Sentenced, -Civil, -Federal, -Technical.Parole.Violators, -State.Readies, -Other.Unsentenced)

crimes = select(crimes,-Months.Reported,-Violent.Total, -Murder, -Rape, -Robbery, -Aggravated.Assault, -Property.Total, -Region)


population = filter(population, Program.Type == "Postcensal Population Estimate")

population = select(population, -Program.Type)

school_aid = select(school_aid, -Aid.Category)

school_aid = filter(school_aid, Year >= 2010, Year <= 2019)

jail = filter(jail, Facility.Name != "All Non-NYC Facilities", Facility.Name != "All NYC Facilities", Year >= 2010, Year <= 2019)

crimes = filter(crimes,Agency == "County Total", Year >= 2010, Year <= 2019)

crimes = select(crimes, -Agency)


population = rename(population, County = Geography)

school_aid = rename(school_aid, Year = Event, Aid.Amount = School.Year) # 'Event': 'Year', 'School Year': 'Aid Amount'}, axis = 1)

jail = rename(jail, County = Facility.Name, Jail.Population = Census) #'Facility Name': 'County', 'Census': 'Jail Population'}, axis = 1)


population = drop_na(population)

school_aid = drop_na(school_aid)

jail = drop_na(jail)

crimes = drop_na(crimes)


jail <- jail %>% mutate(County = str_replace(County, " .*", ""))

population <- population %>% mutate(County = str_replace(County, " .*", ""))

school_aid <- school_aid %>% mutate(Year = str_replace(Year, "-.*", ""))


write.csv(population,"data/processedData/population.csv", row.names = FALSE)

write.csv(nschool_aid,"data/processedData/school_aid.csv", row.names = FALSE)

write.csv(jail,"data/processedData/jail.csv", row.names = FALSE)

write.csv(crimes,"data/processedData/crimes.csv", row.names = FALSE)
