library(haven)
library(tidyverse)
library(labelled)
library(readxl)

exampledataEng <- read_sav("example_datasets\\datsetmaker\\NGREFSAFebruary2020_external.sav")
exampledataEng$state <- to_factor(exampledataEng$state)
exampledataEng$cod_lga <- to_factor(exampledataEng$cod_lga)

###rCSI
exampledataEng <- exampledataEng %>%
  rename(rCSILessQlty = rcsi1, rCSIBorrow = rcsi2, rCSIMealSize = rcsi3, rCSIMealAdult = rcsi4, rCSIMealNb = rcsi5)
#variablelabels
var_label(exampledataEng$rCSILessQlty) <- "In the past 7 days, how many days has your household had to: Rely on less preferred and less expensive food because you did not have enough food or money to buy food?"
var_label(exampledataEng$rCSIBorrow) <- "In the past 7 days, how many days has your household had to: Borrow food or rely on help from a relative or friend because you did not have enough food or money to buy food?"
var_label(exampledataEng$rCSIMealSize) <- "In the past 7 days, how many days has your household had to: Limit portion size of meals because you did not have enough food or money to buy food?"
var_label(exampledataEng$rCSIMealAdult) <- "In the past 7 days, how many days has your household had to: Restrict consumption by adults in order for small children to eat because you did not have enough food or money to buy food?"
var_label(exampledataEng$rCSIMealNb) <- "	In the past 7 days, how many days has your household had to: Reduce the number of meals eaten per day because you did not have enough food or money to buy food?"

###HHS
exampledataEng <- exampledataEng %>%
  rename(HHhSNoFood_YN = yn_hhs1, HHhSBedHung_YN = yn_hhs2, HHhSNotEat_YN = yn_hhs3, HHhSNoFood_FR = hss1, HHhSBedHung_FR = hss2, HHhSNotEat_FR = hss3)
#variablelabels
var_label(exampledataEng$HHhSNoFood_YN) <- "In the past [4 weeks/30 days], was there ever no food to eat of any kind in your house because of lack of resources to get food?"
var_label(exampledataEng$HHhSBedHung_YN) <- "How often did this happen in the past [4 weeks/30 days]?"
var_label(exampledataEng$HHhSNotEat_YN) <- "In the past [4 weeks/30 days], did you or any household member go to sleep at night hungry because there was not enough food?"
var_label(exampledataEng$HHhSNoFood_FR) <- "How often did this happen in the past [4 weeks/30 days]?"
var_label(exampledataEng$HHhSBedHung_FR) <- "In the past [4 weeks/30 days], did you or any household member go to sleep at night hungry because there was not enough food?"
var_label(exampledataEng$HHhSNotEat_FR) <- "How often did this happen in the past [4 weeks/30 days]?"
#value labels
val_labels(exampledataEng$HHhSNoFood_FR) <- c("Rarely (1–2 times)" = 1, "Sometimes (3–10 times)" = 2, "Often (more than 10 times)" = 3)
val_labels(exampledataEng$HHhSBedHung_FR) <- c("Rarely (1–2 times)" = 1, "Sometimes (3–10 times)" = 2, "Often (more than 10 times)" = 3)
val_labels(exampledataEng$HHhSNotEat_FR) <- c("Rarely (1–2 times)" = 1, "Sometimes (3–10 times)" = 2, "Often (more than 10 times)" = 3)

#FCS/HDDS
###
exampledataEng <- exampledataEng %>% rename(
  FCSStap = nbr_fcs1_cer,
  HDDSStapCer = q5.5.1,
  HDDSStapRoot = q5.5,
  FCSPulse = nbr_fcs2_leg,
  HDDSPulse = q5.5.2,
  FCSDairy = nbr_fcs3_milk,
  HDDSDairy = q5.5.3,
  FCSPr = nbr_fcs4_protein,
  FCSPrMeatF = nbr_fcs41_fresh,
  HDDSPrMeatF = q5.5.4,
  FCSPrMeatO = nbr_fcs42_organ,
  HDDSPrMeatO = q5.5.5,
  FCSPrFish = nbr_fcs43_fish,
  HDDSPrFish = q5.5.6,
  FCSPrEgg = nbr_fcs44_eg,
  HDDSPrEgg = q5.5.7,
  FCSVeg = nbr_fcs5_veg,
  FCSVegOrg = nbr_fcs51_orveg,
  HDDSVegOrg = q5.51,
  FCSVegGre = nbr_fcs52_grveg,
  HDDSVegGre = q5.52,
  #FCSVegOth below
  HDDSVegOth = q5.5.8,
  FCSFruit = nbr_fcs6_fruit,
  FCSFruitOrg = nbr_fcs61_orfr,
  HDDSFruitOrg = q5.56,
  #FCSFrutoth below
  FCSFat = nbr_fcs7_oil,
  HDDSFat = q5.57,
  FCSSugar = nbr_fcs8_sug,
  HDDSSugar = q5.58,
  FCSCond = nbr_fcs9_cond,
  HDDSCond = q5.5.14,
)
exampledataEng <- exampledataEng %>% mutate(FCSVegOth = FCSVegOrg, FCSFruitOth = FCSFruitOrg)
exampledataEng <- exampledataEng %>% mutate(HDDSFruitOth = HDDSFruitOrg)
#variablelabels - FCS
var_label(exampledataEng$FCSStap) <- "Over the last 7 days, how many days did members of your household eat : Cereals, grains, roots and tubers "
var_label(exampledataEng$FCSPulse) <- "Over the last 7 days, how many days did members of your household eat : Pulses"
var_label(exampledataEng$FCSDairy) <- "Over the last 7 days, how many days did members of your household eat : Dairy "
var_label(exampledataEng$FCSPr) <- "Over the last 7 days, how many days did members of your household eat : Meat, fish, eggs"
var_label(exampledataEng$FCSPrMeatF) <- "Over the last 7 days, how many days did members of your household eat : Flesh/red meat"
var_label(exampledataEng$FCSPrMeatO) <- "Over the last 7 days, how many days did members of your household eat : Organ meat"
var_label(exampledataEng$FCSPrFish) <- "Over the last 7 days, how many days did members of your household eat : Fish and shellfish"
var_label(exampledataEng$FCSPrEgg) <- "Over the last 7 days, how many days did members of your household eat : Eggs"
var_label(exampledataEng$FCSVeg) <- "Over the last 7 days, how many days did members of your household eat :  Vegetables and leaves"
var_label(exampledataEng$FCSVegOrg) <- "Over the last 7 days, how many days did members of your household eat : Orange vegetables"
var_label(exampledataEng$FCSVegGre) <- "Over the last 7 days, how many days did members of your household eat : Green leafy vegetables"
var_label(exampledataEng$FCSVegOth) <- "Over the last 7 days, how many days did members of your household eat : Other Vegetables"
var_label(exampledataEng$FCSFruit) <- "Over the last 7 days, how many days did members of your household eat : Fruits"
var_label(exampledataEng$FCSFruitOrg) <- "Over the last 7 days, how many days did members of your household eat : Orange fruits "
var_label(exampledataEng$FCSFruitOth) <- "Over the last 7 days, how many days did members of your household eat : Other fruits"
var_label(exampledataEng$FCSFat) <- "Over the last 7 days, how many days did members of your household eat : Oil/fat/butter"
var_label(exampledataEng$FCSSugar) <- "Over the last 7 days, how many days did members of your household eat : Sugar and sweets"
var_label(exampledataEng$FCSCond) <- "Over the last 7 days, how many days did members of your household eat : Condiments/Spices"
#variablelabels - HDDS
var_label(exampledataEng$HDDSStapCer) <- "Yesterday, during the day and night, did members in your household eat: Cereals and grains"
var_label(exampledataEng$HDDSStapRoot) <- "Yesterday, during the day and night, did members in your household eat: Roots and Tubers"
var_label(exampledataEng$HDDSPulse) <- "Yesterday, during the day and night, did members in your household eat: Pulses"
var_label(exampledataEng$HDDSDairy) <- "Yesterday, during the day and night, did members in your household eat: Milk and dairy products"
var_label(exampledataEng$HDDSPrMeatF) <- "Yesterday, during the day and night, did members in your household eat: Flesh/red meat"
var_label(exampledataEng$HDDSPrMeatO) <- "Yesterday, during the day and night, did members in your household eat: Organ meat"
var_label(exampledataEng$HDDSPrFish) <- "Yesterday, during the day and night, did members in your household eat: Fish and shellfish"
var_label(exampledataEng$HDDSPrEgg) <- "Yesterday, during the day and night, did members in your household eat: Eggs"
var_label(exampledataEng$HDDSVegOrg) <- "Yesterday, during the day and night, did members in your household eat: Orange Vegetables"
var_label(exampledataEng$HDDSVegGre) <- "Yesterday, during the day and night, did members in your household eat: Green leafy vegetables"
var_label(exampledataEng$HDDSVegOth) <- "Yesterday, during the day and night, did members in your household eat: Other Vegetables"
var_label(exampledataEng$HDDSFruitOrg) <- "Yesterday, during the day and night, did members in your household eat: Orange fruits"
var_label(exampledataEng$HDDSFruitOth) <- "Yesterday, during the day and night, did members in your household eat: Other fruits"
var_label(exampledataEng$HDDSFat) <- "Yesterday, during the day and night, did members in your household eat: Oil/fat/butter"
var_label(exampledataEng$HDDSSugar) <- "Yesterday, during the day and night, did members in your household eat: Sugar and sweets"
var_label(exampledataEng$HDDSCond) <- "Yesterday, during the day and night, did members in your household eat: Condiments/Spices"
#make random subset of 3000 records
exampledataEng <- sample_n(exampledataEng, size = 3000)
#variable labels
exampledataEng <- exampledataEng %>% rename(ADMIN1Name = state, ADMIN2Name = cod_lga, WeightHH = domainwgt, EnumName = enum_cod)
var_label(exampledataEng$ADMIN1Name) <- "First Administrative Level"
var_label(exampledataEng$ADMIN2Name) <- "Second Administrative Level"
var_label(exampledataEng$WeightHH) <- "Survey Weights"
var_label(exampledataEng$EnumName) <- "Code of Enumerator"
#select only needed variables
exampledataEng <- exampledataEng %>% select(ADMIN1Name, ADMIN2Name, WeightHH, EnumName,
    rCSILessQlty, rCSIBorrow, rCSIMealSize, rCSIMealAdult, rCSIMealNb,
    HHhSNoFood_YN, HHhSNoFood_FR, HHhSBedHung_YN, HHhSBedHung_FR, HHhSNotEat_YN, HHhSNotEat_FR,
    FCSStap, FCSPulse, FCSDairy, FCSPr, FCSPrMeatF, FCSPrMeatO, FCSPrFish, FCSPrEgg, FCSVeg, FCSVegOrg, FCSVegGre, FCSVegOth, FCSFruit, FCSFruitOrg, FCSFruitOth, FCSFat, FCSSugar, FCSCond,
    HDDSStapCer, HDDSStapRoot, HDDSPulse, HDDSDairy, HDDSPrMeatF, HDDSPrMeatO, HDDSPrFish, HDDSPrEgg, HDDSVegOrg, HDDSVegGre, HDDSVegOth, HDDSFruitOrg, HDDSFruitOth, HDDSFat, HDDSSugar, HDDSCond)
#####Cameroon for LHCS
Cameroonexample <- read_sav("example_datasets\\datsetmaker\\CMR_CFSVA_2017_hh.sav")
Cameroonexample <- Cameroonexample %>%
  rename(LhCSIStress1 = S12.02.1,
         LhCSIStress2 = S12.02.2,
         LhCSIStress3 = S12.02.3,
         LhCSIStress4 = S12.02.4,
         LhCSICrisis1 = S12.02.5,
         LhCSICrisis2 = S12.02.6,
         LhCSICrisis3 = S12.02.7,
         LhCSIEmergency1 = S12.02.8,
         LhCSIEmergency2 = S12.02.9,
         LhCSIEmergency3 = S12.02.10)
#variablelabels - yes/no
var_label(Cameroonexample$LhCSIStress1) <- "During the past 30 days, did anyone in your household have to: Sell household assets/goods (radio, furniture, refrigerator, television, jewelry etc..) due to a lack of food or a lack of money to buy food?"
var_label(Cameroonexample$LhCSIStress2) <- "During the past 30 days, did anyone in your household have to: sell more animals (non-productive) than usual due to a lack of food or a lack of money to buy food?"
var_label(Cameroonexample$LhCSIStress3) <- "During the past 30 days, did anyone in your household have to: spend savings due to a lack of food or a lack of money to buy food?"
var_label(Cameroonexample$LhCSIStress4) <- "During the past 30 days, did anyone in your household have to: Borrow money / food  from a formal lender / bank due to a lack of food or a lack of money to buy food?"
var_label(Cameroonexample$LhCSICrisis1) <- "During the past 30 days, did anyone in your household have to: Reduce non-food expenses on health (including drugs) and education due to a lack of food or a lack of money to buy food?"
var_label(Cameroonexample$LhCSICrisis2) <- "During the past 30 days, did anyone in your household have to: sell productive assets or means of transport (sewing machine, wheelbarrow, bicycle, car, etc..) due to a lack of food or a lack of money to buy food?"
var_label(Cameroonexample$LhCSICrisis3) <- "During the past 30 days, did anyone in your household have to: withdraw children from school due to a lack of food or a lack of money to buy food?"
var_label(Cameroonexample$LhCSIEmergency1) <- "During the past 30 days, did anyone in your household have to: sell house or land due to a lack of food or a lack of money to buy food?"
var_label(Cameroonexample$LhCSIEmergency2) <- "During the past 30 days, did anyone in your household have to: sell last female animals due to a lack of food or a lack of money to buy food?"
var_label(Cameroonexample$LhCSIEmergency3) <- "During the past 30 days, did anyone in your household have to:beg due to a lack of food or a lack of money to buy food?"
#value labels
val_labels(Cameroonexample$LhCSIStress1) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(Cameroonexample$LhCSIStress2) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(Cameroonexample$LhCSIStress3) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(Cameroonexample$LhCSIStress4) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(Cameroonexample$LhCSICrisis1) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(Cameroonexample$LhCSICrisis2) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(Cameroonexample$LhCSICrisis3) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(Cameroonexample$LhCSIEmergency1) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(Cameroonexample$LhCSIEmergency2) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
val_labels(Cameroonexample$LhCSIEmergency3) <- c("No, because I did not face a shortage of food" = 1, "No; because I already sold those assets or did this activity in the last 12 months and cannot continue to do it" = 2, "Yes" = 3, "Not applicable" = 4)
#make random subset of 3000 records
Cameroonexample <- sample_n(Cameroonexample, size = 3000)
#variable labels
Cameroonexample <- Cameroonexample %>% select(LhCSIStress1, LhCSIStress2, LhCSIStress3, LhCSIStress4, LhCSICrisis1, LhCSICrisis2, LhCSICrisis3,
                                              LhCSIEmergency1, LhCSIEmergency2, LhCSIEmergency3)
#merge Cameroon and Nigeria dataset
exampledataEng <- bind_cols(exampledataEng, Cameroonexample)



#Now fix Geo-names and codes
#Join with p-codes to make pcodes
exampledataEng <- exampledataEng %>% mutate(ADMIN1Name = str_to_title(ADMIN1Name, locale = "en"),
                                    ADMIN2Name = str_to_title(ADMIN2Name, locale = "en"))
#OCHA codes
nga_adminboundaries_tabulardata <- read_excel("example_datasets/nga_adminboundaries_tabulardata.xlsx")
nga_adminboundaries_tabulardata <- nga_adminboundaries_tabulardata %>% select(ADMIN2Name = admin2Name_en, ADMIN2Code = admin2Pcode, ADMIN1Code = admin1Pcode) %>% distinct(ADMIN2Code, .keep_all = TRUE)
#recode Kala/bage
exampledataEng <- exampledataEng %>% mutate(ADMIN2Name = case_when(
  ADMIN2Name == "Kalabalge" ~ "Kala/Balge",
  TRUE ~ ADMIN2Name))
#join
sux  <- anti_join(exampledataEng, nga_adminboundaries_tabulardata, by = "ADMIN2Name")
sux2  <- anti_join(nga_adminboundaries_tabulardata, exampledataEng, by = "ADMIN2Name")
exampledataEng <- inner_join(exampledataEng, nga_adminboundaries_tabulardata, by = "ADMIN2Name")

#make labelled/value version of ADM1Name, ADM2Name
#adm2
dictionary <- distinct(select(exampledataEng,ADMIN2Name,ADMIN2Code))
v <- dictionary$ADMIN2Code
names(v) <- dictionary$ADMIN2Name
exampledataEng$ADMIN2Name <- labelled_spss(exampledataEng$ADMIN2Code, v)
#adm1
dictionary1 <- distinct(select(exampledataEng,ADMIN1Name,ADMIN1Code))
v1 <- dictionary1$ADMIN1Code
names(v1) <- dictionary1$ADMIN1Name
exampledataEng$ADMIN1Name <- labelled_spss(exampledataEng$ADMIN1Code, v1)


exampledataEng <- exampledataEng %>% select(-ADMIN1Code, -ADMIN2Code)
exampledataEng %>% write_sav("example_datasets\\exampledataEnglish_raw_testy.sav")
#get rid of ADMINCodes and weights
exampledataEng <- exampledataEng %>% select(-WeightHH)
exampledataEng %>% write_sav("example_datasets\\exampledataEnglish_raw.sav")


