select distinct pa.* , di.diagnosisstring,	di.icd9code, admdrug.drugName, admdrug.drugDosage	,  admdrug.drugUnit, 
  case when lower(admdrug.drugName) like '%carba%' 
    or lower(admdrug.drugName) like '%diazepam%'  
    or lower(admdrug.drugName) like' %diazepam%'  
    or lower(admdrug.drugName) like '%phosphenytoin%'
    or lower(admdrug.drugName) like '%fosphenytoin%'
    or lower(admdrug.drugName) like '%sium sulfate%' 
    or lower(admdrug.drugName) like '%phenytoin%'  
    or lower(admdrug.drugName) like '%valproic acid%'  
    or lower(admdrug.drugName) like '%tivan%' 
    or lower(admdrug.drugName) like '%desitin%' 
    or lower(admdrug.drugName) like '%desitin%' 
    or lower(admdrug.drugName) like '%desitin%' 
    or lower(admdrug.drugName) like '%dilantin%'
    or lower(admdrug.drugName) like '%kep%' 
    or lower(admdrug.drugName) like '%gretol%' 
    or lower(admdrug.drugName) like '%zon%'
    or lower(admdrug.drugName) like '%clobazam%'
    or lower(admdrug.drugName) like '%clonazepam%'
    or lower(admdrug.drugName) like '%divalproex sodium%'
    or lower(admdrug.drugName) like '%eslicarbazepine acetate%'
    or lower(admdrug.drugName) like '%ethosuximide%'
    or lower(admdrug.drugName) like '%ethotoin%'
    or lower(admdrug.drugName) like '%gabapentin%'
    or lower(admdrug.drugName) like '%lacosamide%'
    or lower(admdrug.drugName) like '%levetiracetam%'
    or lower(admdrug.drugName) like '%oxcarbazepine%'
    or lower(admdrug.drugName) like '%perampanel%'
    or lower(admdrug.drugName) like '%phenobarbital%'
    or lower(admdrug.drugName) like '%pregabalin%'
    or lower(admdrug.drugName) like '%primidone%'
    or lower(admdrug.drugName) like '%rufinamide%'
    or lower(admdrug.drugName) like '%sodium valproate	%'
    or lower(admdrug.drugName) like '%stiripentol%'
    or lower(admdrug.drugName) like '%tiagabine%'
    or lower(admdrug.drugName) like '%topiramate%'
    or lower(admdrug.drugName) like '%valproic acid	%'
    or lower(admdrug.drugName) like '%vigabatrin%'
    or lower(admdrug.drugName) like '%zonisamide%'
    or lower(admdrug.drugName) like '%banzel%'
    or lower(admdrug.drugName) like '%carbatrol%'
    or lower(admdrug.drugName) like '%convulex%'
    or lower(admdrug.drugName) like '%depacon%'
    or lower(admdrug.drugName) like '%depakene%'
    or lower(admdrug.drugName) like '%depakote%'
    or lower(admdrug.drugName) like '%diacomit%'
    or lower(admdrug.drugName) like '%emeside%'
    or lower(admdrug.drugName) like '%epanutin%'
    or lower(admdrug.drugName) like '%epilim%'
    or lower(admdrug.drugName) like '%epival%'
    or lower(admdrug.drugName) like '%frisium%'
    or lower(admdrug.drugName) like '%fycompa%'
    or lower(admdrug.drugName) like '%gabitril%'
    or lower(admdrug.drugName) like '%gralise%'
    or lower(admdrug.drugName) like '%lamictal%'
    or lower(admdrug.drugName) like '%lyrica%'
    or lower(admdrug.drugName) like '%mysolin%'
    or lower(admdrug.drugName) like '%neurontin%'
    or lower(admdrug.drugName) like '%nootropil%'
    or lower(admdrug.drugName) like '%onfi%'
    or lower(admdrug.drugName) like '%phenytek%'
    or lower(admdrug.drugName) like '%rivotril%'
    or lower(admdrug.drugName) like '%sabril%'
    or lower(admdrug.drugName) like '%stavzor%'
    or lower(admdrug.drugName) like '%tapclob%'
    or lower(admdrug.drugName) like '%topamax%'
    or lower(admdrug.drugName) like '%trileptal%'
    or lower(admdrug.drugName) like '%vimpat%'
    or lower(admdrug.drugName) like '%zarontin%'
    or lower(admdrug.drugName) like '%zebinix%'
    or lower(admdrug.drugName) like '%zonegran%'
    then 1 
    else 0 
    end as took_AED
from `physionet-data.eicu_crd.patient` pa
inner join `physionet-data.eicu_crd.diagnosis` di 
on pa.patientunitstayid = di.patientunitstayid
left outer join `physionet-data.eicu_crd.admissiondrug` admdrug
on admdrug.patientunitstayid = pa.patientunitstayid
where di.icd9code like "85%"
or di.icd9code like "%,85%"
or di.icd9code like "%, 85%"