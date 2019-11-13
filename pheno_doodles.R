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
  summarize(n=length(Day))