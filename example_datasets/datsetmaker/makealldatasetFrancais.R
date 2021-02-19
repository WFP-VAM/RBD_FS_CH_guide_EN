library(haven)
library(tidyverse)
library(labelled)
library(readxl)

exampledataFrancais <- read_sav("example_datasets\\datsetmaker\\NGREFSAFebruary2020_external.sav")
exampledataFrancais$state <- to_factor(exampledataFrancais$state)
exampledataFrancais$cod_lga <- to_factor(exampledataFrancais$cod_lga)

###rCSI
exampledataFrancais <- exampledataFrancais %>%
  rename(rCSILessQlty = rcsi1, rCSIBorrow = rcsi2, rCSIMealSize = rcsi3, rCSIMealAdult = rcsi4, rCSIMealNb = rcsi5)
#variablelabels
var_label(exampledataFrancais$rCSILessQlty) <- "Au cours des 7 derniers jours, combien de jours votre ménage a-t-il dû: Consommer des aliments moins préférés et moins chers parce que vous n'aviez pas assez de nourriture ou de l'argent pour acheter de la nourriture ?"
var_label(exampledataFrancais$rCSIBorrow) <- "Au cours des 7 derniers jours, combien de jours votre ménage a-t-il dû: Emprunter de la nourriture ou compter sur l’aide des parents/amis parce que vous n'aviez pas assez de nourriture ou de l'argent pour acheter de la nourriture ?"
var_label(exampledataFrancais$rCSIMealSize) <- "Au cours des 7 derniers jours, combien de jours votre ménage a-t-il dû: Diminuer la quantité consommée pendant les repas parce que vous n'aviez pas assez de nourriture ou de l'argent pour acheter de la nourriture ?"
var_label(exampledataFrancais$rCSIMealAdult) <- "Au cours des 7 derniers jours, combien de jours votre ménage a-t-il dû: Restreindre la consommation des adultes pour nourrir les enfants parce que vous n'aviez pas assez de nourriture ou de l'argent pour acheter de la nourriture ?"
var_label(exampledataFrancais$rCSIMealNb) <- "Au cours des 7 derniers jours, combien de jours votre ménage a-t-il dû: Diminuer le nombre de repas par jour parce que vous n'aviez pas assez de nourriture ou de l'argent pour acheter de la nourriture ?"

###HHS
exampledataFrancais <- exampledataFrancais %>%
  rename(HHhSNoFood_YN = yn_hhs1, HHhSBedHung_YN = yn_hhs2, HHhSNotEat_YN = yn_hhs3, HHhSNoFood_FR = hss1, HHhSBedHung_FR = hss2, HHhSNotEat_FR = hss3)
#variablelabels
var_label(exampledataFrancais$HHhSNoFood_YN) <- "Au cours des [4 dernières semaines/30 jours], n'y avait-il aucun aliment à manger à la maison, de quelque nature que ce soit à cause du manque de ressources ?"
var_label(exampledataFrancais$HHhSBedHung_YN) <- "Combien de fois est-ce arrivé au cours des [4 dernières semaines/30 jours] ?"
var_label(exampledataFrancais$HHhSNotEat_YN) <- "Au cours des [4 dernières semaines/30 jours], étiez-vous ou tout membre de votre ménage obligé de dormir affamé le soir parce qu’il n’y avait pas assez de nourriture ?"
var_label(exampledataFrancais$HHhSNoFood_FR) <- "Combien de fois est-ce arrivé au cours des [4 dernières semaines/30 jours] ?"
var_label(exampledataFrancais$HHhSBedHung_FR) <- "Au cours des [4 dernières semaines/30 jours], avez-vous ou tout membre de votre ménage passé un jour et une nuit entière sans rien manger parce qu’il n’y avait pas assez de nourriture ?"
var_label(exampledataFrancais$HHhSNotEat_FR) <- "Combien de fois est-ce arrivé au cours des [4 dernières semaines/30 jours] ?"
#value labels
val_labels(exampledataFrancais$HHhSNoFood_FR) <- c("Rarement (1 à 2 fois)" = 1, "Parfois (3 à 10 fois)" = 2, "Souvent (plus que 10 fois)" = 3)
val_labels(exampledataFrancais$HHhSBedHung_FR) <- c("Rarement (1 à 2 fois)" = 1, "Parfois (3 à 10 fois)" = 2, "Souvent (plus que 10 fois)" = 3)
val_labels(exampledataFrancais$HHhSNotEat_FR) <- c("Rarement (1 à 2 fois)" = 1, "Parfois (3 à 10 fois)" = 2, "Souvent (plus que 10 fois)" = 3)

#FCS/HDDS
###
exampledataFrancais <- exampledataFrancais %>% rename(
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
exampledataFrancais <- exampledataFrancais %>% mutate(FCSVegOth = FCSVegOrg, FCSFruitOth = FCSFruitOrg)
exampledataFrancais <- exampledataFrancais %>% mutate(HDDSFruitOth = HDDSFruitOrg)
#variablelabels - FCS
var_label(exampledataFrancais$FCSStap) <- "Au cours des 7 derniers jours, combien de jours les membres de votre ménage ont mangé :  Céréales, grains, racines et tubercules"
var_label(exampledataFrancais$FCSPulse) <- "Au cours des 7 derniers jours, combien de jours les membres de votre ménage ont mangé :  Légumineuses / noix"
var_label(exampledataFrancais$FCSDairy) <- "Au cours des 7 derniers jours, combien de jours les membres de votre ménage ont mangé :  Le lait et les produits laitiers"
var_label(exampledataFrancais$FCSPr) <- "Au cours des 7 derniers jours, combien de jours les membres de votre ménage ont mangé :  Viande, poisson, œufs"
var_label(exampledataFrancais$FCSPrMeatF) <- "Au cours des 7 derniers jours, combien de jours les membres de votre ménage ont mangé :  Chair/viande rouge"
var_label(exampledataFrancais$FCSPrMeatO) <- "Au cours des 7 derniers jours, combien de jours les membres de votre ménage ont mangé :  Viande d'organe"
var_label(exampledataFrancais$FCSPrFish) <- "Au cours des 7 derniers jours, combien de jours les membres de votre ménage ont mangé :  Poissons et coquillage"
var_label(exampledataFrancais$FCSPrEgg) <- "Au cours des 7 derniers jours, combien de jours les membres de votre ménage ont mangé :  Oeufs"
var_label(exampledataFrancais$FCSVeg) <- "Au cours des 7 derniers jours, combien de jours les membres de votre ménage ont mangé :   Légumes et feuilles"
var_label(exampledataFrancais$FCSVegOrg) <- "Au cours des 7 derniers jours, combien de jours les membres de votre ménage ont mangé :  Légumes oranges"
var_label(exampledataFrancais$FCSVegGre) <- "Au cours des 7 derniers jours, combien de jours les membres de votre ménage ont mangé :  Légumes à feuilles vertes"
var_label(exampledataFrancais$FCSVegOth) <- "Au cours des 7 derniers jours, combien de jours les membres de votre ménage ont mangé :  Autres légumes"
var_label(exampledataFrancais$FCSFruit) <- "Au cours des 7 derniers jours, combien de jours les membres de votre ménage ont mangé :  Des fruits"
var_label(exampledataFrancais$FCSFruitOrg) <- "Au cours des 7 derniers jours, combien de jours les membres de votre ménage ont mangé :  Fruits oranges"
var_label(exampledataFrancais$FCSFruitOth) <- "Au cours des 7 derniers jours, combien de jours les membres de votre ménage ont mangé :  Autres fruits"
var_label(exampledataFrancais$FCSFat) <- "Au cours des 7 derniers jours, combien de jours les membres de votre ménage ont mangé :  Huile/matières grasses/beurre"
var_label(exampledataFrancais$FCSSugar) <- "Au cours des 7 derniers jours, combien de jours les membres de votre ménage ont mangé :  Sucre ou sucreries"
var_label(exampledataFrancais$FCSCond) <- "Au cours des 7 derniers jours, combien de jours les membres de votre ménage ont mangé :  Condiments/épices"
#variablelabels - HDDS
var_label(exampledataFrancais$HDDSStapCer) <- "Hier, pendant la journée et la nuit, les membres de votre ménage ont-ils mangé : Céréales, grains"
var_label(exampledataFrancais$HDDSStapRoot) <- "Hier, pendant la journée et la nuit, les membres de votre ménage ont-ils mangé : Racines et tubercules"
var_label(exampledataFrancais$HDDSPulse) <- "Hier, pendant la journée et la nuit, les membres de votre ménage ont-ils mangé : Légumineuses / noix"
var_label(exampledataFrancais$HDDSDairy) <- "Hier, pendant la journée et la nuit, les membres de votre ménage ont-ils mangé : Le lait et les produits laitiers"
var_label(exampledataFrancais$HDDSPrMeatF) <- "Hier, pendant la journée et la nuit, les membres de votre ménage ont-ils mangé : Chair/viande rouge"
var_label(exampledataFrancais$HDDSPrMeatO) <- "Hier, pendant la journée et la nuit, les membres de votre ménage ont-ils mangé : Viande d'organe"
var_label(exampledataFrancais$HDDSPrFish) <- "Hier, pendant la journée et la nuit, les membres de votre ménage ont-ils mangé : Poissons et coquillage"
var_label(exampledataFrancais$HDDSPrEgg) <- "Hier, pendant la journée et la nuit, les membres de votre ménage ont-ils mangé : Oeufs"
var_label(exampledataFrancais$HDDSVegOrg) <- "Hier, pendant la journée et la nuit, les membres de votre ménage ont-ils mangé : Légumes oranges"
var_label(exampledataFrancais$HDDSVegGre) <- "Hier, pendant la journée et la nuit, les membres de votre ménage ont-ils mangé : Légumes à feuilles vertes"
var_label(exampledataFrancais$HDDSVegOth) <- "Hier, pendant la journée et la nuit, les membres de votre ménage ont-ils mangé : Autres légumes"
var_label(exampledataFrancais$HDDSFruitOrg) <- "Hier, pendant la journée et la nuit, les membres de votre ménage ont-ils mangé : Fruits oranges"
var_label(exampledataFrancais$HDDSFruitOth) <- "Hier, pendant la journée et la nuit, les membres de votre ménage ont-ils mangé : Autres fruits"
var_label(exampledataFrancais$HDDSFat) <- "Hier, pendant la journée et la nuit, les membres de votre ménage ont-ils mangé : Huile/matières grasses/beurre"
var_label(exampledataFrancais$HDDSSugar) <- "Hier, pendant la journée et la nuit, les membres de votre ménage ont-ils mangé : Sucre ou sucreries"
var_label(exampledataFrancais$HDDSCond) <- "Hier, pendant la journée et la nuit, les membres de votre ménage ont-ils mangé : Condiments/épices"
#value labels
val_labels(exampledataFrancais$HDDSStapCer) <- c("Oui" = 1, "Non" = 0)
val_labels(exampledataFrancais$HDDSStapRoot) <- c("Oui" = 1, "Non" = 0)
val_labels(exampledataFrancais$HDDSPulse) <- c("Oui" = 1, "Non" = 0)
val_labels(exampledataFrancais$HDDSDairy) <- c("Oui" = 1, "Non" = 0)
val_labels(exampledataFrancais$HDDSPrMeatF) <- c("Oui" = 1, "Non" = 0)
val_labels(exampledataFrancais$HDDSPrMeatO) <- c("Oui" = 1, "Non" = 0)
val_labels(exampledataFrancais$HDDSPrFish) <- c("Oui" = 1, "Non" = 0)
val_labels(exampledataFrancais$HDDSPrEgg) <- c("Oui" = 1, "Non" = 0)
val_labels(exampledataFrancais$HDDSVegOrg) <- c("Oui" = 1, "Non" = 0)
val_labels(exampledataFrancais$HDDSVegGre) <- c("Oui" = 1, "Non" = 0)
val_labels(exampledataFrancais$HDDSVegOth) <- c("Oui" = 1, "Non" = 0)
val_labels(exampledataFrancais$HDDSFruitOrg) <- c("Oui" = 1, "Non" = 0)
val_labels(exampledataFrancais$HDDSFruitOth) <- c("Oui" = 1, "Non" = 0)
val_labels(exampledataFrancais$HDDSFat) <- c("Oui" = 1, "Non" = 0)
val_labels(exampledataFrancais$HDDSSugar) <- c("Oui" = 1, "Non" = 0)
val_labels(exampledataFrancais$HDDSCond) <- c("Oui" = 1, "Non" = 0)
#make random subset of 3000 records
exampledataFrancais <- sample_n(exampledataFrancais, size = 3000)
#variable labels
exampledataFrancais <- exampledataFrancais %>% rename(ADMIN1Name = state, ADMIN2Name = cod_lga, WeightHH = domainwgt, EnumName = enum_cod)
var_label(exampledataFrancais$ADMIN1Name) <- "Premier niveau administratif"
var_label(exampledataFrancais$ADMIN2Name) <- "Deuxième niveau administratif"
var_label(exampledataFrancais$WeightHH) <- "Ponderation"
var_label(exampledataFrancais$EnumName) <- "Code de l'enquêteur"
#select only needed variables
exampledataFrancais <- exampledataFrancais %>% select(ADMIN1Name, ADMIN2Name, WeightHH, EnumName,
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
var_label(Cameroonexample$LhCSIStress1) <- "Au cours des 30 derniers jours, est ce qu' un membre de votre ménage a du: Vendre des actifs/biens non productifs du ménage (radio, meuble, réfrigérateur, télévision, bijoux etc.) en raison d'un manque de nourriture ou d'argent pour acheter de la nourriture ?"
var_label(Cameroonexample$LhCSIStress2) <- "Au cours des 30 derniers jours, est ce qu' un membre de votre ménage a du: Vendre plus d’animaux (non-productifs) que d’habitude than usual en raison d'un manque de nourriture ou d'argent pour acheter de la nourriture ?"
var_label(Cameroonexample$LhCSIStress3) <- "Au cours des 30 derniers jours, est ce qu' un membre de votre ménage a du: Dépenser l’épargne  en raison d'un manque de nourriture ou d'argent pour acheter de la nourriture ?"
var_label(Cameroonexample$LhCSIStress4) <- "Au cours des 30 derniers jours, est ce qu' un membre de votre ménage a du: Emprunter de l’argent / nourriture auprès d’un prêteur formel /banque en raison d'un manque de nourriture ou d'argent pour acheter de la nourriture ?"
var_label(Cameroonexample$LhCSICrisis1) <- "Au cours des 30 derniers jours, est ce qu' un membre de votre ménage a du: Réduire les dépenses non alimentaires essentielles telles que l’éducation, la santé (dont de médicaments) en raison d'un manque de nourriture ou d'argent pour acheter de la nourriture ?"
var_label(Cameroonexample$LhCSICrisis2) <- "Au cours des 30 derniers jours, est ce qu' un membre de votre ménage a du: Vendre des biens productifs ou des moyens de transport (machine à coudre, brouette, vélo, car, etc.) en raison d'un manque de nourriture ou d'argent pour acheter de la nourriture ?"
var_label(Cameroonexample$LhCSICrisis3) <- "Au cours des 30 derniers jours, est ce qu' un membre de votre ménage a du: Retirer les enfants de l’école en raison d'un manque de nourriture ou d'argent pour acheter de la nourriture ?"
var_label(Cameroonexample$LhCSIEmergency1) <- "Au cours des 30 derniers jours, est ce qu' un membre de votre ménage a du: Vendre la maison ou du terrain en raison d'un manque de nourriture ou d'argent pour acheter de la nourriture ?"
var_label(Cameroonexample$LhCSIEmergency2) <- "Au cours des 30 derniers jours, est ce qu' un membre de votre ménage a du: Vendre les derniers animaux femelles en raison d'un manque de nourriture ou d'argent pour acheter de la nourriture ?"
var_label(Cameroonexample$LhCSIEmergency3) <- "Au cours des 30 derniers jours, est ce qu' un membre de votre ménage a du: Mendier en raison d'un manque de nourriture ou d'argent pour acheter de la nourriture ?"
#value labels
val_labels(Cameroonexample$LhCSIStress1) <- c("Non, je n'ai pas été confronté à une insuffisance de nourriture" = 1, "Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas continuer à le faire" = 2, "Oui" = 3, "Non applicable" = 4)
val_labels(Cameroonexample$LhCSIStress2) <- c("Non, je n'ai pas été confronté à une insuffisance de nourriture" = 1, "Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas continuer à le faire" = 2, "Oui" = 3, "Non applicable" = 4)
val_labels(Cameroonexample$LhCSIStress3) <- c("Non, je n'ai pas été confronté à une insuffisance de nourriture" = 1, "Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas continuer à le faire" = 2, "Oui" = 3, "Non applicable" = 4)
val_labels(Cameroonexample$LhCSIStress4) <- c("Non, je n'ai pas été confronté à une insuffisance de nourriture" = 1, "Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas continuer à le faire" = 2, "Oui" = 3, "Non applicable" = 4)
val_labels(Cameroonexample$LhCSICrisis1) <- c("Non, je n'ai pas été confronté à une insuffisance de nourriture" = 1, "Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas continuer à le faire" = 2, "Oui" = 3, "Non applicable" = 4)
val_labels(Cameroonexample$LhCSICrisis2) <- c("Non, je n'ai pas été confronté à une insuffisance de nourriture" = 1, "Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas continuer à le faire" = 2, "Oui" = 3, "Non applicable" = 4)
val_labels(Cameroonexample$LhCSICrisis3) <- c("Non, je n'ai pas été confronté à une insuffisance de nourriture" = 1, "Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas continuer à le faire" = 2, "Oui" = 3, "Non applicable" = 4)
val_labels(Cameroonexample$LhCSIEmergency1) <- c("Non, je n'ai pas été confronté à une insuffisance de nourriture" = 1, "Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas continuer à le faire" = 2, "Oui" = 3, "Non applicable" = 4)
val_labels(Cameroonexample$LhCSIEmergency2) <- c("Non, je n'ai pas été confronté à une insuffisance de nourriture" = 1, "Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas continuer à le faire" = 2, "Oui" = 3, "Non applicable" = 4)
val_labels(Cameroonexample$LhCSIEmergency3) <- c("Non, je n'ai pas été confronté à une insuffisance de nourriture" = 1, "Non, parce que j’ai déjà vendu ces actifs ou mené cette activité au cours des 12 derniers mois et je ne peux pas continuer à le faire" = 2, "Oui" = 3, "Non applicable" = 4)
#make random subset of 3000 records
Cameroonexample <- sample_n(Cameroonexample, size = 3000)
#variable labels
Cameroonexample <- Cameroonexample %>% select(LhCSIStress1, LhCSIStress2, LhCSIStress3, LhCSIStress4, LhCSICrisis1, LhCSICrisis2, LhCSICrisis3,
                                              LhCSIEmergency1, LhCSIEmergency2, LhCSIEmergency3)
#merge Cameroon and Nigeria dataset
exampledataFrancais <- bind_cols(exampledataFrancais, Cameroonexample)



#Now fix Geo-names and codes
#Join with p-codes to make pcodes
exampledataFrancais <- exampledataFrancais %>% mutate(ADMIN1Name = str_to_title(ADMIN1Name, locale = "en"),
                                    ADMIN2Name = str_to_title(ADMIN2Name, locale = "en"))
#OCHA codes
nga_adminboundaries_tabulardata <- read_excel("example_datasets/nga_adminboundaries_tabulardata.xlsx")
nga_adminboundaries_tabulardata <- nga_adminboundaries_tabulardata %>% select(ADMIN2Name = admin2Name_en, ADMIN2Code = admin2Pcode, ADMIN1Code = admin1Pcode) %>% distinct(ADMIN2Code, .keep_all = TRUE)
#recode Kala/bage
exampledataFrancais <- exampledataFrancais %>% mutate(ADMIN2Name = case_when(
  ADMIN2Name == "Kalabalge" ~ "Kala/Balge",
  TRUE ~ ADMIN2Name))
#join
sux  <- anti_join(exampledataFrancais, nga_adminboundaries_tabulardata, by = "ADMIN2Name")
sux2  <- anti_join(nga_adminboundaries_tabulardata, exampledataFrancais, by = "ADMIN2Name")
exampledataFrancais <- inner_join(exampledataFrancais, nga_adminboundaries_tabulardata, by = "ADMIN2Name")

#make labelled/value version of ADM1Name, ADM2Name
#adm2
dictionary <- distinct(select(exampledataFrancais,ADMIN2Name,ADMIN2Code))
v <- dictionary$ADMIN2Code
names(v) <- dictionary$ADMIN2Name
exampledataFrancais$ADMIN2Name <- labelled_spss(exampledataFrancais$ADMIN2Code, v)
#adm1
dictionary1 <- distinct(select(exampledataFrancais,ADMIN1Name,ADMIN1Code))
v1 <- dictionary1$ADMIN1Code
names(v1) <- dictionary1$ADMIN1Name
exampledataFrancais$ADMIN1Name <- labelled_spss(exampledataFrancais$ADMIN1Code, v1)


exampledataFrancais %>% write_sav("example_datasets\\exampledataFrancais.sav")


