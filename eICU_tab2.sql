with partitioned AS (
    SELECT patientunitstayid,
           patienthealthsystemstayid,
           gender,
           age,
           ethnicity,
           hospitalid,
           wardid,
           apacheadmissiondx,
           admissionheight,
           hospitaladmittime24,
           hospitaladmitoffset,
           hospitaladmitsource,
           hospitaldischargeyear,
           hospitaldischargetime24,
           hospitaldischargeoffset,
           hospitaldischargelocation,
           hospitaldischargestatus,
           unittype,
           unitadmittime24,
           unitadmitsource,
           unitvisitnumber,
           unitstaytype,
           admissionweight,
           dischargeweight,
           unitdischargetime24,
           unitdischargeoffset,
           unitdischargelocation,
           unitdischargestatus,
           uniquepid,
           diagnosisstring,
           icd9code,
           drugName,
           drugDosage,
           drugUnit,
           took_AED	
        ,ROW_NUMBER() OVER(PARTITION BY uniquepid
                            ORDER BY took_AED DESC) AS seq -- we want to capture the admissions during which the patient were given an AED 
    FROM `AED_effect_seizure.eICU_tab1` 
)
SELECT *
FROM partitioned WHERE seq = 1