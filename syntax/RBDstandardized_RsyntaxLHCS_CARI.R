library(haven)
library(labelled)
library(tidyverse)

#import dataset
dataLHCS_CARIEng <- read_sav("example_datasets/dataLHCS_CARIEng.sav")

#Calculate HHS
dataLHCS_CARIEng<- to_factor(dataLHCS_CARIEng)

#create a variable to specify if the household used any of the strategies by severity
#stress
dataLHCS_CARIEng <- dataLHCS_CARIEng %>% mutate(stress_coping = case_when(
  LhCSIStress1 %in% c("Yes","No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it") ~ "usedstress",
  LhCSIStress2 %in% c("Yes","No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it") ~ "usedstress",
  LhCSIStress3 %in% c("Yes","No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it") ~ "usedstress",
  LhCSIStress4 %in% c("Yes","No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it") ~ "usedstress",
  TRUE ~ "notusedstress"))
#Crisis
dataLHCS_CARIEng <- dataLHCS_CARIEng %>% mutate(crisis_coping = case_when(
  LhCSICrisis1 %in% c("Yes","No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it") ~ "usedcrisis",
  LhCSICrisis2 %in% c("Yes","No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it") ~ "usedcrisis",
  LhCSICrisis3 %in% c("Yes","No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it") ~ "usedcrisis",
  TRUE ~ "notusedcrisis"))
#Emergency
dataLHCS_CARIEng <- dataLHCS_CARIEng %>% mutate(emergency_coping = case_when(
  LhCSIEmergency1 %in% c("Yes","No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it") ~ "usedemergency",
  LhCSIEmergency2 %in% c("Yes","No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it") ~ "usedemergency",
  LhCSIEmergency3 %in% c("Yes","No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it") ~ "usedemergency",
  TRUE ~ "noutusedemergency"))

#calculate Max_coping_behaviour
dataLHCS_CARIEng <- dataLHCS_CARIEng %>% mutate(LhCSICat = case_when(
  emergency_coping == "usedemergency" ~ "EmergencyStrategies",
  crisis_coping == "usedcrisis" ~ "CrisisStrategies",
  stress_coping == "usedstress" ~ "StressStrategies",
  TRUE ~ "NoStrategies"))
var_label(dataLHCS_CARIEng$LhCSICat) <- "Livelihood Coping Strategy categories - CARI light version"



#Generate table of proportion of households in CH LhCHS phases by Adm1 and Adm2 using weights
#Livelihood Coping Strategies
LhHCSCat_table_wide <- dataLHCS_CARIEng %>%
  drop_na(LhCSICat) %>%
  group_by(ADMIN1Name, ADMIN2Name) %>%
  count(LhCSICat, wt = WeightHH) %>%
  mutate(perc = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  spread(key = LhCSICat, value = perc) %>% replace(., is.na(.), 0) %>% mutate_if(is.numeric, round, 1)
