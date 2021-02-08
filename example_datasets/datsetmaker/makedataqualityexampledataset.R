library(haven)
library(tidyverse)
library(labelled)

dataHHSEng <- read_sav("example_datasets/dataHHSEng.sav")
dataFCSHDDSEng <- read_sav("example_datasets/dataFCSHDDSEng.sav")
datarCSIEng <- read_sav("example_datasets/datarCSIEng.sav")

all_together <- inner_join(dataFCSHDDSEng, dataHHSEng, by = c("uuid"))
all_together <- inner_join(all_together, datarCSIEng, by = c("uuid"))

all_together %>% write_sav("example_datasets\\data4dataqreport.sav")


