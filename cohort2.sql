WITH ICUtimes as 
  (select subject_id, hadm_id, count(icustay_id) as ICUtimes 
  from `physionet-data.mimiciii_derived.icustay_times` 
  group by subject_id, hadm_id)
SELECT distinct         
        cohort.*, 
        elixhauser_vanwalraven,	
        elixhauser_SID29,	
        elixhauser_SID30, 
        ICUtimes , 
        DATE_DIFF(DATE(detail.outtime), DATE(detail.intime), day) as ICUdur_days,
        detail.ethnicity, 
        vent.MechVent, 
        vent.OxygenTherapy,
        vent.Extubated,	
        vent.SelfExtubated	
FROM `AED_effect_seizure.cohort_1` cohort
LEFT OUTER JOIN `physionet-data.mimiciii_derived.elixhauser_quan_score` elix 
ON cohort.HADM_ID = elix.HADM_ID
LEFT OUTER JOIN ICUtimes times
ON times.subject_id = cohort.subject_id 
AND times.hadm_id = cohort.hadm_id
LEFT OUTER JOIN `physionet-data.mimiciii_derived.icustay_detail`  detail
ON detail.icustay_id = cohort.icustay_id 
AND detail.hadm_id = cohort.hadm_id 
AND detail.subject_id = cohort.subject_id 
LEFT OUTER JOIN `physionet-data.mimiciii_derived.ventsettings` vent 
ON vent.icustay_id = cohort.icustay_id 
WHERE GCS >= 3 
AND GCS <= 10
; 
