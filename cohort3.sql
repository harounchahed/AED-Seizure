With all_text as 
  (select cohort.SUBJECT_ID,
         max(cohort.HADM_ID) as HADM_ID,	
         max(ICUSTAY_ID) as ICUSTAY_ID,
         max(AGE) as AGE,	
         max(GENDER)	as GENDER, 
         max(ICD9_CODE) as ICD9_CODE,	
         max(SHORT_TITLE) as SHORT_TITLE,
         max(DIAGNOSIS) as DIAGNOSIS,
         max(ADMITTIME) as ADMITTIME,	
         max(DEATHTIME) as DEATHTIME,
         max(GCSMotor) as GCSMotor,
         max(GCSEyes) as GCSEyes,
         max(GCS) as GCS,
         took_AED,
         max(AED) as AED,
         max(elixhauser_vanwalraven) as elixhauser_vanwalraven,
         max(elixhauser_SID29) as elixhauser_SID29,
         max(elixhauser_SID30) as	elixhauser_SID30 ,
         max(ICUtimes) as ICUtimes,
         max(ICUdur_days) as ICUdur_days, 
         max(ethnicity) as 	ethnicity ,
         max(MechVent) as MechVent,	
         max(OxygenTherapy)	as OxygenTherapy, 
         max(Extubated) as Extubated,
         max(SelfExtubated) as SelfExtubated, 
         notes.text 
  from `AED_effect_seizure.cohort_2` cohort 
  left outer join `physionet-data.mimiciii_notes.noteevents` notes
  on cohort.subject_id = notes.subject_id 
  group by SUBJECT_ID,
           took_AED, 
           notes.text),

           
all_seizure as 
  (select subject_id, 
       HADM_ID,
       ICUSTAY_ID,
       AGE,	
       GENDER,
       ICD9_CODE,
       SHORT_TITLE,
       DIAGNOSIS,
       ADMITTIME,
       DEATHTIME,
       GCSMotor,
       GCSEyes,
       GCS,
       took_AED,
       AED,
       elixhauser_vanwalraven,
       elixhauser_SID29,
       elixhauser_SID30,
       ICUtimes,
       ICUdur_days,
       ethnicity,
       MechVent,
       OxygenTherapy,
       Extubated,
       SelfExtubated, 
       case 
       when all_text.text like "%epilep%" 
       or all_text.text like "%eeg%"
       or all_text.text like "%seizur%" 
       or all_text.text like "%siezur%"
       then 1 
       else 0 
       end as had_seisure
from all_text) 

select SUBJECT_ID,
         max(HADM_ID) as HADM_ID,	
         max(ICUSTAY_ID) as ICUSTAY_ID,
         max(AGE) as AGE,	
         max(GENDER)	as GENDER, 
         max(ICD9_CODE) as ICD9_CODE,	
         max(SHORT_TITLE) as SHORT_TITLE,
         max(DIAGNOSIS) as DIAGNOSIS,
         max(ADMITTIME) as ADMITTIME,	
         max(DEATHTIME) as DEATHTIME,
         max(GCSMotor) as GCSMotor,
         max(GCSEyes) as GCSEyes,
         max(GCS) as GCS,
         max(took_AED) as took_AED,
         max(AED) as AED,
         max(elixhauser_vanwalraven) as elixhauser_vanwalraven,
         max(elixhauser_SID29) as elixhauser_SID29,
         max(elixhauser_SID30) as	elixhauser_SID30 ,
         max(ICUtimes) as ICUtimes,
         max(ICUdur_days) as ICUdur_days, 
         max(ethnicity) as 	ethnicity ,
         max(MechVent) as MechVent,	
         max(OxygenTherapy)	as OxygenTherapy, 
         max(Extubated) as Extubated,
         max(SelfExtubated) as SelfExtubated, 
         max(had_seisure) as had_seizure 
from all_seizure      
group by subject_id 
      