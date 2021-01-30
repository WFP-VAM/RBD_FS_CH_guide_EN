library(haven)
library(labelled)
library(tidyverse)

#import dataset
dataLHCSLightEng <- read_sav("dataLHCSLightEng.sav")

#Calculate HHS 
dataLHCSLightEng <- to_factor(dataLHCSLightEng)

#create a dummy variable 0/1 if the household used any of the 4 stress_coping strategies
#Stress
dataLHCSLightEng <- dataLHCSLightEng %>% mutate(stress_coping = case_when(
  LhCSIStress1_lt %in% c("Yes","No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it") ~ "usedstress",
  LhCSIStress2_lt %in% c("Yes","No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it") ~ "usedstress",
  LhCSIStress3_lt %in% c("Yes","No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it") ~ "usedstress",
  LhCSIStress4_lt %in% c("Yes","No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it") ~ "usedstress",
  TRUE ~ "notusedstress"))
#Crisis
dataLHCSLightEng <- dataLHCSLightEng %>% mutate(crisis_coping = case_when(
  LhCSICrisis1_lt %in% c("Yes","No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it") ~ "usedcrisis",
  LhCSICrisis2_lt %in% c("Yes","No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it") ~ "usedcrisis",
  LhCSICrisis3_lt %in% c("Yes","No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it") ~ "usedcrisis",
  TRUE ~ "notusedcrisis"))
#Emergency
dataLHCSLightEng <- dataLHCSLightEng %>% mutate(emergency_coping = case_when(
  LhCSIEmergency1_lt %in% c("Yes","No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it") ~ "usedemergency",
  LhCSIEmergency2_lt %in% c("Yes","No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it") ~ "usedemergency",
  LhCSIEmergency3_lt %in% c("Yes","No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it") ~ "usedemergency",
  TRUE ~ "noutusedemergency"))

#calculate Max_coping_behaviour
dataLHCSLightEng <- dataLHCSLightEng %>% mutate(LhCSICat = case_when(
  emergency_coping == "usedemergency" ~ "EmergencyStrategies",
  crisis_coping == "usedcrisis" ~ "CrisisStrategies",
  stress_coping == "usedstress" ~ "StressStrategies",
  TRUE ~ "NoStrategies"))

#Generate table of proportion of households in CH LhCHS phases by Adm1 and Adm2 using weights
#Livelihood Coping Strategies 
LhHCSCat_table_wide <- dataLHCSLightEng %>% 
  drop_na(LhCSICat) %>%
  group_by(ADMIN1Name, ADMIN2Name) %>%
  count(LhCSICat, wt = WeightHH) %>%
  mutate(perc = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  spread(key = LhCSICat, value = perc) %>% replace(., is.na(.), 0) %>% mutate_if(is.numeric, round, 1)