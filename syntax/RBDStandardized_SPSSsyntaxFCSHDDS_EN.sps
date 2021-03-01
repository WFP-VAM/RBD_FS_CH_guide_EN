GET
  FILE='exampledataEnglish_raw.sav'.
DATASET NAME DataSet1 WINDOW=FRONT.

** Calculate Food Consumption Score

compute FCS = sum(FCSStap*2, FCSPulse*3, FCSDairy*4, FCSPr*4, FCSVeg, FCSFruit, FCSFat*0.5, FCSSugar*0.5).
variable labels FCS "Food Consumption Score".

** Calculate Food Consumption Groups

recode FCS (0 thru 21 = 1) (21 thru 35 = 2) (35 thru highest = 3) into FCSCat21.
variable labels FCSCat21 "Food Consumption Groups - 21/35 thresholds".
recode FCS (0 thru 28 = 1) (28 thru 42 = 2) (42 thru highest = 3) into FCSCat28.
variable labels FCSCat28  "Food Consumption Groups - 28/42 thresholds".

VALUE LABELS FCSCat21 FCSCat28 
1 "Poor"
2 "Borderline"
3 "Acceptable".

** Calculate Household Dietary Diversity Score

compute HDDS = sum(HDDSStapCer,HDDSStapRoot,HDDSPulse,HDDSDairy,HDDSPrMeatF,HDDSPrMeatO,HDDSPrFish,
HDDSPrEgg,HDDSVegOrg,HDDSVegGre,HDDSVegOth,HDDSFruitOrg,HDDSFruitOth,HDDSFat,HDDSSugar,HDDSCond).
variable labels HDDS "Household Dietary Diversity Score".






