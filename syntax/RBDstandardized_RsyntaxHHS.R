library(haven)
library(labelled)
library(tidyverse)

#import dataset
dataHHSEng <- read_sav("example_datasets/dataHHSEng.sav")

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
# Calculate HHhS score
dataHHSEng <- dataHHSEng %>% mutate(HHhS = HHhSNoFood_FR_r + HHhSBedHung_FR_r + HHhSNotEat_FR_r)
var_label(dataHHSEng$HHhS) <- "Household Hunger Scale"

#each household should have an HHS score between 0 - 6
summary(dataHHSEng$HHhS)

# Create Categorical HHS
dataHHSEng <- dataHHSEng %>% mutate(HHhSCat = case_when(
  HHhS %in% c(0,1) ~ "No or little hunger in the household",
  HHhS %in% c(2,3) ~ "Moderate hunger in the household",
  HHhS >= 4 ~ "Severe hunger in the household"
))
var_label(dataHHSEng$HHhSCat) <- "Household Hunger Score Categories"

#Convert HH Scores to CH phases
dataHHSEng <- dataHHSEng %>% mutate(HHhS_CH = case_when(
  HHhS == 0 ~ "Phase1",
  HHhS == 1 ~ "Phase2",
  HHhS %in% c(2,3) ~ "Phase3",
  HHhS == 4 ~ "Phase4",
  HHhS >= 5 ~ "Phase5"))
var_label(dataHHSEng$HHhS_CH) <- "Household Hunger Score Categories - Cadre Harmonise"

#Generate table of proportion of households in CH HHS phases by Adm1 and Adm2 using weights
CH_HHhS_table_wide <- dataHHSEng %>% group_by(ADMIN1Name, ADMIN2Name) %>%
  drop_na(HHhS_CH) %>%
  count(HHhS_CH, wt = WeightHH) %>%
  mutate(perc = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  spread(key = HHhS_CH, value = perc) %>% replace(., is.na(.), 0)  %>% mutate_if(is.numeric, round, 1)
