########################################################

#### prelims --------------------------------------------------------------------------------------------------------------
library(tidyverse)

getwd()
setwd('/Users/collnell/Dropbox/Projects/canada/pheno')
list.files()

#### read in data ---------------------------------------------------------------------------------------------------------

## collection dates for 15 species
dia<-read.csv('pheno_data.csv')
sp<-read.csv('pheno_sp.csv') # taxonomy info
sp

long<-read_csv('pheno_long.csv')

## 
dia%>%
  group_by(HERB_sp_2019)%>%
  summarize(n=sum(Larvae)+sum(Pupae))
dia

long%>%distinct(MOTH_id, MOTH_sp)


## quebec and ontario localities
loc_ont<-grep('Ont',unique(long$Locality_clean), value=TRUE)
loc_que<-grep('Que',unique(long$Locality_clean), value=TRUE)

## collection frequency over time for HYCU
hycu<-long%>%
  filter(Locality_clean %in% loc_ont | Locality_clean %in% loc_que, !(Year %in% c(1936, 1937, 1938)))%>%
  mutate(date = yday(as.Date(paste0(Year,'/',Month,'/',Day))),
         locale = case_when(Locality_clean %in% loc_ont ~ 'Ontario',
                            Locality_clean %in% loc_que ~ 'Quebec'),
         Larvae = as.numeric(Larvae))
str(hycu)


## calculate abundance by date and locality 
hycu.dia<-hycu%>%
  group_by(MOTH_sp, locale, Year, date)%>%
  summarize(n = sum(Larvae, na.rm=TRUE))

ggplot(hycu.dia, aes(date))+geom_density(aes(fill=locale), alpha=.5)+
  facet_grid(Year~MOTH_sp, scales='free_y')

## date of 50% occurence happens

## do this for multiple species
