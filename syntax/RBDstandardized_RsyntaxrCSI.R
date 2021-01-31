library(haven)
library(labelled)
library(tidyverse)

#import dataset
datarCSIEng <- read_sav("example_datasets/datarCSIEng.sav")

#Calculate HHS
datarCSIEng <- to_factor(datarCSIEng)

#calculate rCSI Score
datarCSIEng <- datarCSIEng %>% mutate(rCSI = rCSILessQlty  + (2 * rCSIBorrow) + rCSIMealSize + (3 * rCSIMealAdult) + rCSIMealNb)

#convert rCSI Score into thresholds
datarCSIEng <- datarCSIEng %>% mutate(CH_rCSI = case_when(
  rCSI <= 3 ~ "Phase1",
  between(rCSI,4,18) ~ "Phase2",
  rCSI >= 19 ~ "Phase3"))

#Generate table of proportion of households in CH rCSI phases by Adm1 and Adm2 using weights
CH_rCSI_table_wide <- datarCSIEng %>% group_by(ADMIN1Name, ADMIN2Name) %>%
  drop_na(CH_rCSI) %>%
  count(CH_rCSI, wt = hh_weight) %>%
  mutate(perc = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  spread(key = CH_rCSI, value = perc) %>% replace(., is.na(.), 0)  %>% mutate_if(is.numeric, round, 1)
