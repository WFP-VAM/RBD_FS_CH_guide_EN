library(haven)
library(tidyverse)
library(labelled)

NGREFSAFebruary2020_external <- read_sav("example_datasets\\datsetmaker\\NGREFSAFebruary2020_external.sav")

NGREFSAFebruary2020_external$state <- to_factor(NGREFSAFebruary2020_external$state)
NGREFSAFebruary2020_external$cod_lga <- to_factor(NGREFSAFebruary2020_external$cod_lga)

###
dataFCSHDDSEng <- NGREFSAFebruary2020_external %>% rename(
  FCSStap = nbr_fcs1_cer,
  HDDSStapCer = q5.5.1,
  FCSStapCerSRf = src_fcs1_cer,
  HDDSStapRoot = q5.5,
  FCSStapRootSRf = src_fcs1_tub,
  FCSPulse = nbr_fcs2_leg,
  HDDSPulse = q5.5.2,
  FCSPulseSRf = src_fcs2_leg,
  FCSDairy = nbr_fcs3_milk,
  HDDSDairy = q5.5.3,
  FCSDairySRf = src_fcs3_milk,
  FCSPr = nbr_fcs4_protein,
  FCSPrMeatF = nbr_fcs41_fresh,
  HDDSPrMeatF = q5.5.4,
  FCSPrMeatFSRf = src_fcs41_fresh,
  FCSPrMeatO = nbr_fcs42_organ,
  HDDSPrMeatO = q5.5.5,
  FCSPrMeatOSRf = src_fcs42_organ,
  FCSPrFish = nbr_fcs43_fish,
  HDDSPrFish = q5.5.6,
  FCSPrFishSRf = src_fcs43_fish,
  FCSPrEgg = nbr_fcs44_eg,
  HDDSPrEgg = q5.5.7,
  FCSPrEggSRf = src_fcs44_eg,
  FCSVeg = nbr_fcs5_veg,
  FCSVegOrg = nbr_fcs51_orveg,
  HDDSVegOrg = q5.51,
  FCSVegOrgSRf = src_fcs51_orveg,
  FCSVegGre = nbr_fcs52_grveg,
  HDDSVegGre = q5.52,
  FCSVegGreSRf = src_fcs52_grveg,
  HDDSVegOth = q5.5.8,
  FCSVegOthSRf = src_fcs5_veg,
  FCSFruit = nbr_fcs6_fruit,
  FCSFruitOrg = nbr_fcs61_orfr,
  FCSFruitOrgSRf = src_fcs61_orfr,
  HDDSFruitOth = q5.56,
  FCSFruitOthSRF = src_fcs6_fruit,
  FCSFat = nbr_fcs7_oil,
  HDDSFat = q5.57,
  FCSFatSRf = src_fcs7_oil,
  FCSSugar = nbr_fcs8_sug,
  HDDSSugar = q5.58,
  FCSSugarSRf = src_fcs8_sug,
  FCSCond = nbr_fcs9_cond,
  HDDSCond = q5.5.14,
  FCSCondSRf = src_fcs9_cond)


dataFCSHDDSEng <- dataFCSHDDSEng %>% mutate(FCSVegOth = FCSVegOrg, FCSFruitOth = FCSFruitOrg)
dataFCSHDDSEng <- dataFCSHDDSEng %>% mutate(HDDSFruitOrg = HDDSFruitOth)



#variablelabels - FCS
var_label(dataFCSHDDSEng$FCSStap) <- "Over the last 7 days, how many days did members of your household eat : Cereals, grains, roots and tubers "
var_label(dataFCSHDDSEng$FCSPulse) <- "Over the last 7 days, how many days did members of your household eat : Pulses"
var_label(dataFCSHDDSEng$FCSDairy) <- "Over the last 7 days, how many days did members of your household eat : Dairy "
var_label(dataFCSHDDSEng$FCSPr) <- "Over the last 7 days, how many days did members of your household eat : Meat, fish, eggs"
var_label(dataFCSHDDSEng$FCSPrMeatF) <- "Over the last 7 days, how many days did members of your household eat : Flesh/red meat"
var_label(dataFCSHDDSEng$FCSPrMeatO) <- "Over the last 7 days, how many days did members of your household eat : Organ meat"
var_label(dataFCSHDDSEng$FCSPrFish) <- "Over the last 7 days, how many days did members of your household eat : Fish and shellfish"
var_label(dataFCSHDDSEng$HDDSPrEgg) <- "Over the last 7 days, how many days did members of your household eat : Eggs"
var_label(dataFCSHDDSEng$FCSVeg) <- "Over the last 7 days, how many days did members of your household eat :  Vegetables and leaves"
var_label(dataFCSHDDSEng$FCSVegOrg) <- "Over the last 7 days, how many days did members of your household eat : Orange vegetables"
var_label(dataFCSHDDSEng$FCSVegGre) <- "Over the last 7 days, how many days did members of your household eat : Green leafy vegetables"
var_label(dataFCSHDDSEng$FCSVegOth) <- "Over the last 7 days, how many days did members of your household eat : Other Vegetables"
var_label(dataFCSHDDSEng$FCSFruit) <- "Over the last 7 days, how many days did members of your household eat : Fruits"
var_label(dataFCSHDDSEng$FCSFruitOrg) <- "Over the last 7 days, how many days did members of your household eat : Orange fruits "
var_label(dataFCSHDDSEng$FCSFruitOth) <- "Over the last 7 days, how many days did members of your household eat : Other fruits"
var_label(dataFCSHDDSEng$FCSFat) <- "Over the last 7 days, how many days did members of your household eat : Oil/fat/butter"
var_label(dataFCSHDDSEng$FCSSugar) <- "Over the last 7 days, how many days did members of your household eat : Sugar and sweets"
var_label(dataFCSHDDSEng$FCSCond) <- "Over the last 7 days, how many days did members of your household eat : Condiments/Spices"
#variablelabels - HDDS
var_label(dataFCSHDDSEng$HDDSStapCer) <- "Yesterday, during the day and night, did members in your household eat: Cereals and grains"
var_label(dataFCSHDDSEng$HDDSStapRoot) <- "Yesterday, during the day and night, did members in your household eat: Roots and Tubers"
var_label(dataFCSHDDSEng$HDDSPulse) <- "Yesterday, during the day and night, did members in your household eat: Pulses"
var_label(dataFCSHDDSEng$HDDSDairy) <- "Yesterday, during the day and night, did members in your household eat: Milk and dairy products"
var_label(dataFCSHDDSEng$HDDSPrMeatF) <- "Yesterday, during the day and night, did members in your household eat: Flesh/red meat"
var_label(dataFCSHDDSEng$HDDSPrMeatO) <- "Yesterday, during the day and night, did members in your household eat: Organ meat"
var_label(dataFCSHDDSEng$HDDSPrFish) <- "Yesterday, during the day and night, did members in your household eat: Fish and shellfish"
var_label(dataFCSHDDSEng$HDDSPrEgg) <- "Yesterday, during the day and night, did members in your household eat: Eggs"
var_label(dataFCSHDDSEng$HDDSVegOrg) <- "Yesterday, during the day and night, did members in your household eat: Orange Vegetables"
var_label(dataFCSHDDSEng$HDDSVegGre) <- "Yesterday, during the day and night, did members in your household eat: Green leafy vegetables"
var_label(dataFCSHDDSEng$HDDSVegOth) <- "Yesterday, during the day and night, did members in your household eat: Other Vegetables"
var_label(dataFCSHDDSEng$HDDSFruitOrg) <- "Yesterday, during the day and night, did members in your household eat: Orange fruits"
var_label(dataFCSHDDSEng$HDDSFruitOth) <- "Yesterday, during the day and night, did members in your household eat: Other fruits"
var_label(dataFCSHDDSEng$HDDSFat) <- "Yesterday, during the day and night, did members in your household eat: Oil/fat/butter"
var_label(dataFCSHDDSEng$HDDSSugar) <- "Yesterday, during the day and night, did members in your household eat: Sugar and sweets"
var_label(dataFCSHDDSEng$HDDSCond) <- "Yesterday, during the day and night, did members in your household eat: Condiments/Spices"
#variablelabels - source
var_label(dataFCSHDDSEng$FCSStapCerSRf) <- "Over the last 7 days, What was the main source of Cereals and grains"
var_label(dataFCSHDDSEng$FCSStapRootSRf) <- "Over the last 7 days, What was the main source of Roots and Tubers"
var_label(dataFCSHDDSEng$FCSPulseSRf) <- "Over the last 7 days, What was the main source of Pulses "
var_label(dataFCSHDDSEng$FCSDairySRf) <- "Over the last 7 days, What was the main source of Milk and dairy products"
var_label(dataFCSHDDSEng$FCSPrMeatFSRf) <- "Over the last 7 days, What was the main source of Flesh/red meat"
var_label(dataFCSHDDSEng$FCSPrMeatOSRf) <- "Over the last 7 days, What was the main source of Organ meat"
var_label(dataFCSHDDSEng$FCSPrFishSRf) <- "Over the last 7 days, What was the main source of Fish and shellfish"
var_label(dataFCSHDDSEng$FCSPrEggSRf) <- "Over the last 7 days, What was the main source of Eggs"
var_label(dataFCSHDDSEng$FCSVegOrgSRf) <- "Over the last 7 days, What was the main source of Orange vegetables"
var_label(dataFCSHDDSEng$FCSVegGreSRf) <- "Over the last 7 days, What was the main source of Green leafy vegetables"
var_label(dataFCSHDDSEng$FCSVegOthSRf) <- "Over the last 7 days, What was the main source of Other Vegetables"
var_label(dataFCSHDDSEng$FCSFruitOrgSRf) <- "Over the last 7 days, What was the main source of Orange fruits"
var_label(dataFCSHDDSEng$FCSFruitOthSRF) <- "Over the last 7 days, What was the main source of Other fruits"
var_label(dataFCSHDDSEng$FCSFatSRf) <- "Over the last 7 days, What was the main source of Oil/fat/butter"
var_label(dataFCSHDDSEng$FCSSugarSRf) <- "Over the last 7 days, What was the main source of Sugar and sweets"
var_label(dataFCSHDDSEng$FCSCondSRf) <- "Over the last 7 days, What was the main source of Condiments/Spices"

#variable labels
dataFCSHDDSEng <- dataFCSHDDSEng %>% rename(ADMIN1Name = state, ADMIN2Name = cod_lga, WeightHH = domainwgt)
var_label(dataFCSHDDSEng$ADMIN1Name) <- "First Administrative Level"
var_label(dataFCSHDDSEng$ADMIN2Name) <- "Second Administrative Level"
var_label(dataFCSHDDSEng$WeightHH) <- "Survey Weights"

dataFCSHDDSEng <- sample_frac(dataFCSHDDSEng, size = .5)

#select only variables
dataFCSHDDSEng <- dataFCSHDDSEng %>%
  select(ADMIN1Name, ADMIN2Name, enum_cod, WeightHH,
         FCSStap,
         HDDSStapCer,
         FCSStapCerSRf,
         HDDSStapRoot,
         FCSStapRootSRf,
         FCSPulse,
         HDDSPulse,
         FCSPulseSRf,
         FCSDairy,
         HDDSDairy,
         FCSDairySRf,
         FCSPr,
         FCSPrMeatF,
         HDDSPrMeatF,
         FCSPrMeatFSRf,
         FCSPrMeatO,
         HDDSPrMeatO,
         FCSPrMeatOSRf,
         FCSPrFish,
         HDDSPrFish,
         FCSPrFishSRf,
         FCSPrEgg,
         HDDSPrEgg,
         FCSPrEggSRf,
         FCSVeg,
         FCSVegOrg,
         HDDSVegOrg,
         FCSVegOrgSRf,
         FCSVegGre,
         HDDSVegGre,
         FCSVegGreSRf,
         FCSVegOth,
         HDDSVegOth,
         FCSVegOthSRf,
         FCSFruit,
         FCSFruitOrg,
         HDDSFruitOrg,
         FCSFruitOrgSRf,
         FCSFruitOth,
         HDDSFruitOth,
         FCSFruitOthSRF,
         FCSFat,
         HDDSFat,
         FCSFatSRf,
         FCSSugar,
         HDDSSugar,
         FCSSugarSRf,
         FCSCond,
         HDDSCond,
         FCSCondSRf)


#Join with p-codes to make pcodes
dataFCSHDDSEng <- dataFCSHDDSEng %>% mutate(ADMIN1Name = str_to_title(ADMIN1Name, locale = "en"),
                                      ADMIN2Name = str_to_title(ADMIN2Name, locale = "en"))

library(readxl)
nga_adminboundaries_tabulardata <- read_excel("example_datasets/nga_adminboundaries_tabulardata.xlsx")
nga_adminboundaries_tabulardata <- nga_adminboundaries_tabulardata %>% select(ADMIN2Name = admin2Name_en, ADMIN2Code = admin2Pcode, ADMIN1Code = admin1Pcode)

#recode Kala/bage
dataFCSHDDSEng <- dataFCSHDDSEng %>% mutate(ADMIN2Name = case_when(
  ADMIN2Name == "Kalabalge" ~ "Kala/Balge",
  TRUE ~ ADMIN2Name))

#join
sux  <- anti_join(dataFCSHDDSEng, nga_adminboundaries_tabulardata, by = "ADMIN2Name")
sux2  <- anti_join(nga_adminboundaries_tabulardata, dataFCSHDDSEng, by = "ADMIN2Name")
dataFCSHDDSEng <- left_join(dataFCSHDDSEng, nga_adminboundaries_tabulardata, by = "ADMIN2Name")

dataFCSHDDSEng %>% write_sav("example_datasets\\dataFCSHDDSEng.sav")



