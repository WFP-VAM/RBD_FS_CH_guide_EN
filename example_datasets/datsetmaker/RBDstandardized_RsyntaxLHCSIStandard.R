library(haven)
library(labelled)
library(tidyverse)

#import dataset
dataLHCSstandardEng<- read_sav("dataLHCSstandardEng.sav")

#Calculate HHS 
dataLHCSstandardEng <- to_factor(dataLHCSstandardEng)

#create a dummy variable 0/1 if the household used any of the 4 stress_coping strategies
#Stress
dataLHCSstandardEng <- dataLHCSstandardEng %>% mutate(stress_coping = case_when(
  LhCSIStress1_YN == "Yes" | LhCSIStress1_N == "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" ~ "usedstress",
  LhCSIStress2_YN == "Yes" | LhCSIStress2_N == "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" ~ "usedstress",
  LhCSIStress3_YN == "Yes" | LhCSIStress3_N == "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" ~ "usedstress",
  LhCSIStress4_YN == "Yes" | LhCSIStress4_N == "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" ~ "usedstress",
  TRUE ~ "notusedstress"))
#Crisis
dataLHCSstandardEng <- dataLHCSstandardEng %>% mutate(crisis_coping = case_when(
  LhCSICrisis1_YN == "Yes" | LhCSICrisis1_N == "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" ~ "usedcrisis",
  LhCSICrisis2_YN == "Yes" | LhCSICrisis2_N == "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" ~ "usedcrisis",
  LhCSICrisis3_YN == "Yes" | LhCSICrisis3_N == "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" ~ "usedcrisis",
  TRUE ~ "notusedcrisis"))
#Emergency
dataLHCSstandardEng <- dataLHCSstandardEng %>% mutate(emergency_coping = case_when(
  LhCSIEmergency1_YN == "Yes" | LhCSIEmergency1_N == "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" ~ "usedemergency",
  LhCSIEmergency2_YN == "Yes" | LhCSIEmergency2_N == "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" ~ "usedemergency",
  LhCSIEmergency3_YN == "Yes" | LhCSIEmergency3_N == "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" ~ "usedemergency",
  TRUE ~ "notusedemergency"))

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