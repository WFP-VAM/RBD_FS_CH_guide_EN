library(haven)
library(labelled)
library(tidyverse)

#import dataset
datarCSIEng <- read_sav("example_datasets/datarCSIEng.sav")

#Calculate HHS
datarCSIEng <- to_factor(datarCSIEng)

#calculate rCSI Score
datarCSIEng <- datarCSIEng %>% mutate(rCSI = rCSILessQlty  + (2 * rCSIBorrow) + rCSIMealSize + (3 * rCSIMealAdult) + rCSIMealNb)
var_label(datarCSIEng$rCSI) <- "rCSI"

#each household should have a rCSI between 0 - 56

summary(datarCSIEng$rCSI)

#Create rCSI Cadre Harmonise Categories
datarCSIEng <- datarCSIEng %>% mutate(rCSI_CH = case_when(
  rCSI <= 3 ~ "Phase1",
  between(rCSI,4,18) ~ "Phase2",
  rCSI >= 19 ~ "Phase3"))
var_label(datarCSIEng$rCSI_CH) <- "rCSI categories - Cadre Harmonise "

#Generate table of proportion of households in CH rCSI phases by Adm1 and Adm2 using weights
CH_rCSI_table_wide <- datarCSIEng %>% group_by(ADMIN1Name, ADMIN2Name) %>%
  drop_na(rCSI_CH) %>%
  count(rCSI_CH, wt = WeightHH) %>%
  mutate(perc = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  spread(key = rCSI_CH, value = perc) %>% replace(., is.na(.), 0)  %>% mutate_if(is.numeric, round, 1)
