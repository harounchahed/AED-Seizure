with partitioned as (
  select cohort.* , 
         score.gcs, 
         score.gcs_motor,
         score.gcs_eyes,
         score.gcs_verbal,
         score.delirium_scale,
         score.delirium_score, 
         score.sedation_score, 
         score.sedation_goal,
         score.pain_goal, 

         ROW_NUMBER() OVER(PARTITION BY cohort.uniquepid
                            ORDER BY took_AED DESC) AS sequence -- we want to capture the admissions during which the patient were given an AED 
  from `AED_effect_seizure.eICU_tab2` cohort
  left outer join `physionet-data.eicu_crd_derived.pivoted_score` score
  on score.patientunitstayid = cohort.patientunitstayid 
  )
select * 
from partitioned part
where sequence = 1 
and GCS >= 3  
and GCS <= 12