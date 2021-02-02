GET  FILE='datarCSIEng.sav'.
DATASET NAME DataSet1 WINDOW=FRONT.

*** caculate rCSI

compute rCSI = sum(rCSILessQlty,rCSIBorrow*2,rCSIMealSize,rCSIMealAdult*3,rCSIMealNb).
Variable labels rCSI "rCSI".

*** each household should have a rCSI between 0 - 56

FREQUENCIES VARIABLES =  rCSI
/STATISTICS=MEAN MEDIAN MINIMUM MAXIMUM
/ORDER=ANALYSIS.

*** Create rCSI Cadre Harmonise Categories

RECODE rCSI (0 thru 3=1) (4 thru 18=2) (19 thru 56=3) INTO rCSI_CH.
variable labels rCSI_CH "rCSI categories - Cadre Harmonise ".
value labels rCSI_CH
1 `Phase1`
2 `Phase2`
3 `Phase3`.

*** Generate table of proportion of households in CH HHhS phases by Adm1 and Adm2 using weights

WEIGHT BY WeightHH.

CROSSTABS
  /TABLES=ADMIN2Name BY rCSI_CH BY ADMIN1Name
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.


