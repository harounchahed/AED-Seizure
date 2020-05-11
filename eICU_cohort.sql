select pa.*,
hos.teachingstatus, 
hos.region,
apache.apachedxgroup,
max(score.gcs) as gcs,
max(score.gcs_motor) as gcs_motor,
max(score.gcs_eyes) as gcs_eyes,
max(score.gcs_verbal) as gcs_verbal, 
max(score.delirium_scale) as delirium_scale, 	
max(score.delirium_score) as delirium_score,	
max(score.sedation_scale) as sedation_scale, 
max(score.sedation_score) as sedation_score,	
max(score.sedation_goal) as sedation_goal, 
max(score.pain_score) as pain_score,
max(admdrug.drugoffset) as drugoffset, 
max(admdrug.drugenteredoffset) as drugenteredoffset,
max(admdrug.drugnotetype) as drugnotetype,
max(admdrug.drugname) as admission_drug_name, 
icu.apache_iv, 
icu.icu_los_hours,
max(inf.dopamine) as dopamine, 	
max(inf.dobutamine) as dobutamine,
max(inf.norepinephrine) as	norepinephrine, 
max(inf.phenylephrine) as phenylephrine,
max(inf.epinephrine) as	epinephrine,
max(inf.vasopressin) as vasopressin, 
max(inf.milrinone) as milrinone,	
max(inf.heparin) as heparin
from `physionet-data.eicu_crd.patient` pa
inner join `physionet-data.eicu_crd.diagnosis` di 
on pa.patientunitstayid = di.patientunitstayid
left outer join `physionet-data.eicu_crd.hospital` hos
on hos.hospitalid = pa.hospitalid  
left outer join `physionet-data.eicu_crd_derived.apache_groups`  apache
on apache.patientUnitStayID = pa.patientUnitStayID
left outer join `physionet-data.eicu_crd.admissiondrug` admdrug
on admdrug.patientunitstayid = pa.patientunitstayid
left outer join `physionet-data.eicu_crd_derived.pivoted_score` score
on score.patientunitstayid = pa.patientunitstayid 
left outer join `physionet-data.eicu_crd_derived.icustay_detail` icu
on icu.uniquepid = pa.uniquepid 
and icu.patientunitstayid = pa.patientunitstayid
left outer join `physionet-data.eicu_crd_derived.pivoted_infusion` inf
on inf.patientunitstayid= pa.patientunitstayid
where di.icd9code like "%345.4%" 
or di.diagnosisstring like '%status epilepticus%' 
group by pa.patientunitstayid,
         pa.patienthealthsystemstayid,
         pa.gender,
         pa.age,
         pa.ethnicity,	
         pa.hospitalid,	
         pa.wardid,	
         pa.apacheadmissiondx,	
         pa.admissionheight,	
         pa.hospitaladmittime24,
         pa.hospitaladmitoffset,	
         pa.hospitaladmitsource,	
         pa.hospitaldischargeyear,
         pa.hospitaldischargetime24,	
         pa.hospitaldischargeoffset,	
         pa.hospitaldischargelocation,	
         pa.hospitaldischargestatus,	
         pa.unittype,
         pa.unitadmittime24,	
         pa.unitadmitsource,	
         pa.unitvisitnumber,	
         pa.unitstaytype,	
         pa.admissionweight,	
         pa.dischargeweight,	
         pa.unitdischargetime24,	
         pa.unitdischargeoffset,	
         pa.unitdischargelocation,	
         pa.unitdischargestatus,	
         pa.uniquepid,	
         hos.teachingstatus, 
         hos.region, 
         apache.apachedxgroup,
         icu.apache_iv, 
         icu.icu_los_hours;
