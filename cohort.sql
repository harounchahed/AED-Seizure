WITH ALLGCS as 
-- this table containts all GCS values for each patient, we later select the maximum GCS over the stay
  (SELECT D.SUBJECT_ID, 
          D.HADM_ID,
          CH.ICUSTAY_ID,
          DATE_DIFF(DATE(HADM.ADMITTIME), 
          DATE(P.DOB), YEAR) as age, 
          P.GENDER, 
          ICD.ICD9_CODE, 
          ICD.SHORT_TITLE, 
          HADM.DIAGNOSIS, 
          HADM.ADMITTIME,
          HADM.DISCHTIME,
          HADM.DEATHTIME, 
          CASE WHEN CH.ITEMID in (723,223900) THEN valuenum ELSE -1 END AS GCSVerbal,
          CASE WHEN CH.ITEMID in (454,223901) THEN valuenum ELSE -1 END AS GCSMotor,
          CASE WHEN CH.ITEMID in (184,220739) THEN valuenum ELSE -1 END AS GCSEyes,
          CH.valuenum,
          CASE WHEN INPUT.ITEMID in (227689,227690,228316,30141) THEN 1 ELSE 0 END AS took_AED, -- ITEM IDs for Dilantin, Phenytoin, Keppa, Levi
          CASE WHEN INPUT.ITEMID = 227689 THEN 'Keppra' 
               WHEN INPUT.ITEMID = 227690 THEN 'Dilantin' 
               WHEN INPUT.ITEMID = 228316 THEN 'Fosphenytoin' 
               WHEN INPUT.ITEMID = 30141 THEN 'Avitan'
               ELSE null END AS AED -- ITEM IDs for Dilantin, Phenytoin, Keppa, Levi
  FROM `physionet-data.mimiciii_clinical.d_icd_diagnoses`  ICD -- contains diagnoses names for ICD codes 
  INNER JOIN `physionet-data.mimiciii_clinical.diagnoses_icd`  D  -- contains ICD codes for patient's diagnoses
  ON ICD.ICD9_CODE = D.ICD9_CODE
  INNER JOIN `physionet-data.mimiciii_clinical.admissions` HADM -- contains hospital admission information
  ON HADM.HADM_ID = D.HADM_ID 
  INNER JOIN `physionet-data.mimiciii_clinical.patients` P -- contains patient information
  ON HADM.SUBJECT_ID = P.SUBJECT_ID 
  LEFT OUTER JOIN `physionet-data.mimiciii_clinical.chartevents` CH -- contains all chart events of patient
  ON CH.HADM_ID = HADM.HADM_ID 
  AND CH.SUBJECT_ID = P.SUBJECT_ID
  AND CH.ITEMID in (184, 454, 723, 223900, 223901, 220739) -- Item ids corresponding to the GCS 
  AND DATE_DIFF(DATE(CH.CHARTTIME), DATE(HADM.ADMITTIME), DAY) < 3 -- GCS withing first 3 days 
  LEFT OUTER JOIN `physionet-data.mimiciii_clinical.inputevents_mv` INPUT
  ON INPUT.SUBJECT_ID = HADM.SUBJECT_ID
  AND INPUT.HADM_ID = HADM.HADM_ID
  WHERE ICD.ICD9_CODE LIKE '85%') -- ALL TBI ICD codes start with 85 
SELECT SUBJECT_ID,
       HADM_ID,
       ICUSTAY_ID,
       max(age) as AGE, 
       max(GENDER) GENDER, 
       ICD9_CODE, 
       max(SHORT_TITLE) as SHORT_TITLE, 
       max(DIAGNOSIS) as DIAGNOSIS, 
       ADMITTIME, 
       DISCHTIME,  
       max(DEATHTIME) as DEATHTIME, 
       max(GCSVerbal) as GCSVerbal,
       max(GCSMotor) as GCSMotor,
       max(GCSEyes) as GCSEyes, 
       max(GCSVerbal) + max(GCSMotor) + max(GCSEyes) as GCS,
       max(took_AED) as took_AED,
       max(AED) as AED
FROM ALLGCS
GROUP BY SUBJECT_ID,
         HADM_ID,
         ICUSTAY_ID,
         ICD9_CODE, 
         ADMITTIME, 
         DISCHTIME;         
