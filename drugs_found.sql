select  ITEM.label, INPUT1.SUBJECT_ID, INPUT1.HADM_ID, INPUT1.ICUSTAY_ID, INPUT1.CHARTTIME 
from `physionet-data.mimiciii_clinical.d_items` ITEM
inner join `physionet-data.mimiciii_clinical.inputevents_cv`  INPUT1
on ITEM.ITEMID = INPUT1.ITEMID
where lower(label) like '%carba%' 
or lower(label) like '%diazepam%'  
or lower(label) like' %diazepam%'  
or lower(label) like '%phosphenytoin%'
or lower(label) like '%fosphenytoin%'
or lower(label) like '%sium sulfate%' 
or lower(label) like '%phenytoin%'  
or lower(label) like '%valproic acid%'  
or lower(label) like '%tivan%' 
or lower(label) like '%desitin%' 
or lower(label) like '%desitin%' 
or lower(label) like '%desitin%' 
or lower(label) like '%dilantin%'
or lower(label) like '%kep%' 
or lower(label) like '%gretol%' 
or lower(label) like '%zon%' 