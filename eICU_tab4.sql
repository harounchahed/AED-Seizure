with partitioned as (
  select cohort.* , 
         icu.apache_iv, 
         icu.icu_los_hours,
         inf.norepinephrine,
         inf.dobutamine, 
         inf.phenylephrine, 
         inf.epinephrine,
         inf.vasopressin,
         inf.milrinone,
         inf.heparin,
         ROW_NUMBER() OVER(PARTITION BY cohort.uniquepid
                            ORDER BY took_AED DESC) AS seq1 -- we want to capture the admissions during which the patient were given an AED 
  from `AED_effect_seizure.eICU_tab3` cohort
  left outer join `physionet-data.eicu_crd_derived.icustay_detail` icu
  on icu.uniquepid = cohort.uniquepid 
  left outer join `physionet-data.eicu_crd_derived.pivoted_infusion` inf
  on inf.patientunitstayid= cohort.patientunitstayid
  )
select * 
from partitioned 
where seq1 = 1 