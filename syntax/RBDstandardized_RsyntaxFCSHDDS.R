library(haven)
library(labelled)
library(tidyverse)

#import dataset
dataFCSHDDSEng <- read_sav("example_datasets/dataFCSHDDSEng.sav")
#convert to labels
dataFCSHDDSEng <- to_factor(dataFCSHDDSEng)

#calculate FCS
dataFCSHDDSEng <- dataFCSHDDSEng %>% mutate(FCS = (2 * FCSStap) + (3 * FCSPulse)+ (4*FCSPr) +FCSVeg  +FCSFruit +(4*FCSDairy) + (0.5*FCSFat) + (0.5*FCSSugar))
#create FCG groups based on 21/25 or 28/42 thresholds
dataFCSHDDSEng <- dataFCSHDDSEng %>% mutate(
  FCSCat21 = case_when(
    FCS <= 21 ~ "Poor", between(FCS, 21.5, 35) ~ "Borderline", FCS > 35 ~ "Acceptable"),
  FCSCat28 = case_when(
    FCS <= 28 ~ "Poor", between(FCS, 28.5, 42) ~ "Borderline", FCS > 42 ~ "Acceptable"))

#calculate HDDS first by creating the 12 groups based on the 16 questions
dataFCSHDDSEng <- dataFCSHDDSEng %>% mutate(
  HDDSStapCer = case_when(HDDSStapCer == "Yes" ~ 1, TRUE ~ 0),
  HDDSStapRoot = case_when(HDDSStapRoot  == "Yes" ~ 1, TRUE ~ 0),
  HDDSVeg = case_when(HDDSVegOrg  == "Yes" | HDDSVegGre == "Yes" | HDDSVegOth == "Yes" ~ 1, TRUE ~ 0),
  HDDSFruit = case_when(HDDSFruitOrg == "Yes" | HDDSFruitOth == "Yes" ~ 1, TRUE ~ 0),
  HDDSPrMeat = case_when(HDDSPrMeatF == "Yes" | HDDSPrMeatO == "Yes" ~ 1, TRUE ~ 0),
  HDDSPrEgg = case_when(HDDSPrEgg  == "Yes" ~ 1, TRUE ~ 0),
  HDDSPrFish = case_when(HDDSPrFish == "Yes" ~ 1, TRUE ~ 0),
  HDDSPulse = case_when(HDDSPulse == "Yes" ~ 1, TRUE ~ 0),
  HDDSDairy = case_when(HDDSDairy == "Yes" ~ 1, TRUE ~ 0),
  HDDSFat = case_when(HDDSFat == "Yes" ~ 1, TRUE ~ 0),
  HDDSSugar = case_when(HDDSSugar == "Yes" ~ 1, TRUE ~ 0),
  HDDSCond = case_when(HDDSCond == "Yes"~ 1, TRUE ~ 0))

#Generate table of proportion of households in FCG by Adm1 and Adm2 using weights
#Food Consumption Group 21/35 cutoff
FCSCat_table_wide <- dataFCSHDDSEng %>%
  drop_na(FCSCat21) %>%
  group_by(ADMIN1Name, ADMIN2Name) %>%
  count(FCSCat21, wt = WeightHH) %>%
  mutate(perc = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  spread(key = FCSCat21, value = perc) %>% replace(., is.na(.), 0) %>% mutate_if(is.numeric, round, 1)

#Generate table of proportion of households by HDDS by Adm1 and Adm2 using weights
#Food Consumption Group 21/35 cutoff
HDDS_table_wide <- dataFCSHDDSEng %>%
  drop_na(HDDS) %>%
  group_by(ADMIN1Name, ADMIN2Name) %>%
  count(HDDS, wt = WeightHH) %>%
  mutate(perc = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  spread(key = HDDS, value = perc) %>% replace(., is.na(.), 0) %>% mutate_if(is.numeric, round, 1)
