library(haven)
library(tidyverse)
library(labelled)

NGREFSAFebruary2020_external <- read_sav("example_datasets\\datsetmaker\\NGREFSAFebruary2020_external.sav")

###
#rcsi1	-Relied on less preferred, less expensive food
#rcsi2	-Borrowed food or relied on help from friends or relatives
#rcsi3	-Reduced the number of meals eaten per day
#rcsi4	-Reduced portion size of meals
#rcsi5	-Reduction in the quantities consumed by adults/mothers for young children

datarCSIEng <- NGREFSAFebruary2020_external %>%
  rename(rCSILessQlty = rcsi1, rCSIBorrow = rcsi2, rCSIMealSize = rcsi3, rCSIMealAdult = rcsi4, rCSIMealNb = rcsi5)

#variablelabels
var_label(datarCSIEng$rCSILessQlty) <- "In the past 7 days, how many days has your household had to: Rely on less preferred and less expensive food because you did not have enough food or money to buy food?"
var_label(datarCSIEng$rCSIBorrow) <- "In the past 7 days, how many days has your household had to: Borrow food or rely on help from a relative or friend because you did not have enough food or money to buy food?"
var_label(datarCSIEng$rCSIMealSize) <- "In the past 7 days, how many days has your household had to: Limit portion size of meals because you did not have enough food or money to buy food?"
var_label(datarCSIEng$rCSIMealAdult) <- "	In the past 7 days, how many days has your household had to: Restrict consumption by adults in order for small children to eat because you did not have enough food or money to buy food?"
var_label(datarCSIEng$rCSIMealNb) <- "	In the past 7 days, how many days has your household had to: Reduce the number of meals eaten per day because you did not have enough food or money to buy food?"


#variable labels
datarCSIEng <- datarCSIEng %>% rename(ADMIN1Name = state, ADMIN2Name = cod_lga, WeightHH = domainwgt)
var_label(datarCSIEng$ADMIN1Name) <- "First Administrative Level"
var_label(datarCSIEng$ADMIN2Name) <- "Second Administrative Level"
var_label(datarCSIEng$WeightHH) <- "Survey Weights"

datarCSIEng <- sample_frac(datarCSIEng, size = .5)

#select only variables
datarCSIEng <- datarCSIEng %>% select(ADMIN1Name, ADMIN2Name, enum_cod,
                                      rCSILessQlty, rCSIBorrow, rCSIMealSize, rCSIMealAdult, rCSIMealNb,
                                      WeightHH)

datarCSIEng %>% write_sav("example_datasets\\datarCSIEng.sav")

