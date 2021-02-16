library(haven)
library(tidyverse)
library(labelled)

####
Cameroonexample <- read_sav("example_datasets\\datsetmaker\\CMR_CFSVA_2017_hh.sav")


dataLHCSLightEng <- Cameroonexample %>%
  rename(LhCSIStress1_lt = S12.02.1,
         LhCSIStress2_lt = S12.02.2,
         LhCSIStress3_lt = S12.02.3,
         LhCSIStress4_lt = S12.02.4,
         LhCSICrisis1_lt = S12.02.5,
         LhCSICrisis2_lt = S12.02.6,
         LhCSICrisis3_lt = S12.02.7,
         LhCSIEmergency1_lt = S12.02.8,
         LhCSIEmergency2_lt = S12.02.9,
         LhCSIEmergency3_lt = S12.02.10)
#variablelabels - yes/no
var_label(dataLHCSLightEng$LhCSIStress1_lt) <- "During the past 30 days, did anyone in your household have to: Sell household assets/goods (radio, furniture, refrigerator, television, jewelry etc..) due to a lack of food or a lack of money to buy food?"
var_label(dataLHCSLightEng$LhCSIStress2_lt) <- "During the past 30 days, did anyone in your household have to: sell more animals (non-productive) than usual due to a lack of food or a lack of money to buy food?"
var_label(dataLHCSLightEng$LhCSIStress3_lt) <- "During the past 30 days, did anyone in your household have to: spend savings due to a lack of food or a lack of money to buy food?"
var_label(dataLHCSLightEng$LhCSIStress4_lt) <- "During the past 30 days, did anyone in your household have to: Borrow money / food  from a formal lender / bank due to a lack of food or a lack of money to buy food?"
var_label(dataLHCSLightEng$LhCSICrisis1_lt) <- "During the past 30 days, did anyone in your household have to: Reduce non-food expenses on health (including drugs) and education due to a lack of food or a lack of money to buy food?"
var_label(dataLHCSLightEng$LhCSICrisis2_lt) <- "During the past 30 days, did anyone in your household have to: sell productive assets or means of transport (sewing machine, wheelbarrow, bicycle, car, etc..) due to a lack of food or a lack of money to buy food?"
var_label(dataLHCSLightEng$LhCSICrisis3_lt) <- "During the past 30 days, did anyone in your household have to: withdraw children from school due to a lack of food or a lack of money to buy food?"
var_label(dataLHCSLightEng$LhCSIEmergency1_lt) <- "During the past 30 days, did anyone in your household have to: sell house or land due to a lack of food or a lack of money to buy food?"
var_label(dataLHCSLightEng$LhCSIEmergency2_lt) <- "During the past 30 days, did anyone in your household have to: sell last female animals due to a lack of food or a lack of money to buy food?"
var_label(dataLHCSLightEng$LhCSIEmergency3_lt) <- "During the past 30 days, did anyone in your household have to:beg due to a lack of food or a lack of money to buy food?"
#value labels
val_labels(dataLHCSLightEng$LhCSIStress1_lt) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(dataLHCSLightEng$LhCSIStress2_lt) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(dataLHCSLightEng$LhCSIStress3_lt) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(dataLHCSLightEng$LhCSIStress4_lt) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(dataLHCSLightEng$LhCSICrisis1_lt) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(dataLHCSLightEng$LhCSICrisis2_lt) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(dataLHCSLightEng$LhCSICrisis3_lt) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(dataLHCSLightEng$LhCSIEmergency1_lt) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(dataLHCSLightEng$LhCSIEmergency2_lt) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(dataLHCSLightEng$LhCSIEmergency3_lt) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
#
#variable labels
dataLHCSLightEng <- dataLHCSLightEng %>% rename(ADMIN1Name = S0.1.3, ADMIN2Name = S0.1.4, WeightHH = Whi)
var_label(dataLHCSLightEng$ADMIN1Name) <- "First Administrative Level"
var_label(dataLHCSLightEng$ADMIN2Name) <- "Second Administrative Level"
var_label(dataLHCSLightEng$WeightHH) <- "Survey Weights"

dataLHCSLightEng <- sample_frac(dataLHCSLightEng, size = .3)

#select only variables
dataLHCSLightEng <- dataLHCSLightEng %>%
  select(ADMIN1Name, ADMIN2Name, WeightHH,LhCSIStress1_lt,LhCSIStress1_lt,LhCSIStress2_lt,LhCSIStress2_lt,LhCSIStress3_lt,,LhCSIStress4_lt,
         LhCSICrisis1_lt,LhCSICrisis2_lt,LhCSICrisis3_lt,LhCSIEmergency1_lt,LhCSIEmergency2_lt,LhCSIEmergency3_lt)

dataLHCSLightEng  %>% write_sav("C:/Users/william.olander/Dropbox/standardizedRBD/dataLHCSLightEng.sav")

