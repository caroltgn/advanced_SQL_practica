CREATE OR REPLACE TABLE keepcoding.ivr_summary AS


SELECT 
     ivr_id
    ,phone_number
    ,ivr_result
    ,CASE WHEN vdn_label LIKE 'ATC%' THEN 'FRONT' 
          WHEN vdn_label LIKE 'TECH%'THEN 'TECH'
          WHEN vdn_label ='ABSORPTION' THEN 'ABSORPTION'
          ELSE 'RESTO' END AS vdn_aggregation
    ,start_date
    ,end_date
    ,total_duration
    ,customer_segment
    ,ivr_language
    ,steps_module
    ,module_aggregation
    ,IFNULL(MAX(NULLIF(document_type,'NULL')),'NULL') AS document_type
    ,IFNULL(MAX(NULLIF(document_identification,'NULL')),'NULL') AS document_identification
    ,IFNULL(MAX(NULLIF(customer_phone,'NULL')),'NULL') AS customer_phone
    ,IFNULL(MAX(NULLIF(billing_account_id,'NULL')),'NULL') AS billing_account_id
    ,MAX(IF(module_name ='AVERIA_MASIVA',1,0)) AS masiva_lg
    ,MAX(IF( step_name ='CUSTOMERINFOBYPHONE.TX' and step_description_error ='NULL',1,0) )AS info_by_phone_lg
    ,MAX(IF( step_name ='CUSTOMERINFOBYDNI.TX' and step_description_error ='NULL',1,0) )AS info_by_dni_lg
    ,IF(LAG(start_date)OVER (PARTITION BY phone_number ORDER BY phone_number,start_date ASC)>= DATETIME_ADD( start_date, INTERVAL -1 DAY) and LAG(start_date)OVER (PARTITION BY phone_number ORDER BY phone_number,start_date ASC) < start_date ,1,0)   as     repeated_phone_24H
    ,IF(LEAD(start_date)OVER (PARTITION BY phone_number ORDER BY phone_number,start_date ASC)<= DATETIME_ADD( start_date, INTERVAL 1 DAY) and LEAD(start_date)OVER (PARTITION BY phone_number ORDER BY phone_number,start_date ASC) > start_date ,1,0)   as  cause_recall_phone_24H
    
    
  FROM `keepcoding.ivr_detail` 

  
    


  GROUP BY ivr_id
    ,phone_number
    ,ivr_result
    ,vdn_label 
    ,start_date
    ,end_date
    ,total_duration
    ,customer_segment
    ,ivr_language
    ,steps_module
    ,module_aggregation
