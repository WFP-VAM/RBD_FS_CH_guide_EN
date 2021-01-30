library(haven)
library(labelled)
library(tidyverse)

#import dataset
dataHHSEng <- read_sav("dataHHSEng.sav")

#Calculate HHS
dataHHSEng <- to_factor(dataHHSEng)

#Recode HHS questions into new variables with score
dataHHSEng <- dataHHSEng %>% mutate(HHhSNoFood_FR_r = case_when(
  HHhSNoFood_FR == "Rarely (1–2 times)" ~ 1,
  HHhSNoFood_FR == "Sometimes (3–10 times)" ~ 1,
  HHhSNoFood_FR == "Often (more than 10 times)" ~ 2,
  TRUE ~ 0),
  HHhSBedHung_FR_r = case_when(
    HHhSBedHung_FR == "Rarely (1–2 times)" ~ 1,
    HHhSBedHung_FR == "Sometimes (3–10 times)" ~ 1,
    HHhSBedHung_FR == "Often (more than 10 times)" ~ 2,
    TRUE ~ 0),
  HHhSNotEat_FR_r = case_when(
    HHhSNotEat_FR == "Rarely (1–2 times)" ~ 1,
    HHhSNotEat_FR == "Sometimes (3–10 times)" ~ 1,
    HHhSNotEat_FR == "Often (more than 10 times)" ~ 2,
    TRUE ~ 0))
#Calculate HHS
dataHHSEng <- dataHHSEng %>% mutate(HHhS = HHhSNoFood_FR_r + HHhSBedHung_FR_r + HHhSNotEat_FR_r)

#Convert HH Scores to CH phases
dataHHSEng <- dataHHSEng %>% mutate(CH_HHS = case_when(
  HHhS == 0 ~ "Phase1",
  HHhS == 1 ~ "Phase2",
  HHhS %in% c(2,3,4) ~ "Phase3",
  HHhS == 4 ~ "Phase4",
  HHhS >= 5 ~ "Phase5"))

#Generate table of proportion of households in CH HHS phases by Adm1 and Adm2 using weights
CH_HHS_table_wide <- dataHHSEng %>% group_by(ADMIN1Name, ADMIN2Name) %>%
  drop_na(CH_HHS) %>%
  count(CH_HHS, wt = hh_weight) %>%
  mutate(perc = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  spread(key = CH_HHS, value = perc) %>% replace(., is.na(.), 0)  %>% mutate_if(is.numeric, round, 1)
