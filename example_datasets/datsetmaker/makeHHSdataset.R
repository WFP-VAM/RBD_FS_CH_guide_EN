library(haven)
library(tidyverse)
library(labelled)

NGREFSAFebruary2020_external <- read_sav("C:/Users/william.olander/Dropbox/standardizedRBD/NGREFSAFebruary2020_external.sav")

###
#yn_hhs1 - In the past 4 weeks (30 days), was there ever no food to eat of any kind in your house because of lack of resources to get food?
#yn_hhs2 - 	In the past 4 weeks (30 days), did you or any household member go to sleep at night hungry because there was not enough food?
#yn_hhs3 - In the past 4 weeks (30 days), did you or any household member go a whole day and night without eating anything at all because there was not enough food?

#hss1 - How often did this happen in the past 4 weeks (30 days)?
#hss2 - How often did this happen in the past 4 weeks (30 days)?
#hss3 - How often did this happen in the past 4 weeks (30 days)?

#1. Rarely (once or twice in the past four weeks),
#2. Sometimes (three to ten times in the past four weeks),
#3. Often (more than ten times in the past four weeks)

dataHHSEng <- NGREFSAFebruary2020_external %>%
  rename(HHhSNoFood_YN = yn_hhs1, HHhSBedHung_YN = yn_hhs2, HHhSNotEat_YN = yn_hhs3, HHhSNoFood_FR = hss1, HHhSBedHung_FR = hss2, HHhSNotEat_FR = hss3)

#variablelabels
var_label(dataHHSEng$HHhSNoFood_YN) <- "In the past [4 weeks/30 days], was there ever no food to eat of any kind in your house because of lack of resources to get food?"
var_label(dataHHSEng$HHhSBedHung_YN) <- "How often did this happen in the past [4 weeks/30 days]?"
var_label(dataHHSEng$HHhSNotEat_YN) <- "In the past [4 weeks/30 days], did you or any household member go to sleep at night hungry because there was not enough food?"
var_label(dataHHSEng$HHhSNoFood_FR) <- "How often did this happen in the past [4 weeks/30 days]?"
var_label(dataHHSEng$HHhSBedHung_FR) <- "In the past [4 weeks/30 days], did you or any household member go to sleep at night hungry because there was not enough food?"
var_label(dataHHSEng$HHhSNotEat_FR) <- "How often did this happen in the past [4 weeks/30 days]?"

#value labels
val_labels(dataHHSEng$HHhSNoFood_FR) <- c("Rarely (1–2 times)" = 1, "Sometimes (3–10 times)" = 2, "Often (more than 10 times)" = 3)
val_labels(dataHHSEng$HHhSBedHung_FR) <- c("Rarely (1–2 times)" = 1, "Sometimes (3–10 times)" = 2, "Often (more than 10 times)" = 3)
val_labels(dataHHSEng$HHhSNotEat_FR) <- c("Rarely (1–2 times)" = 1, "Sometimes (3–10 times)" = 2, "Often (more than 10 times)" = 3)


#variable labels
dataHHSEng <- dataHHSEng %>% rename(ADMIN1Name = state, ADMIN2Name = cod_lga, WeightHH = domainwgt)
var_label(dataHHSEng$ADMIN1Name) <- "First Administrative Level"
var_label(dataHHSEng$ADMIN2Name) <- "Second Administrative Level"
var_label(dataHHSEng$WeightHH) <- "Survey Weights"

dataHHSEng <- sample_frac(dataHHSEng, size = .5)

#select only variables
dataHHSEng <- dataHHSEng %>% select(ADMIN1Name, ADMIN2Name, HHhSNoFood_YN, HHhSBedHung_YN, HHhSNotEat_YN,
                                    HHhSNoFood_FR, HHhSBedHung_FR, HHhSNotEat_FR, WeightHH)

dataHHSEng %>% write_sav("C:\\RBD_FS_CH_guide_EN\\example_datasets\\dataHHSEng.sav")

