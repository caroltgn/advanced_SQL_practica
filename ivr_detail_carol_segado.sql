CREATE OR REPLACE TABLE keepcoding.ivr_detail AS
SELECT 
    calls.ivr_id AS calls_ivr_id
    ,calls.phone_number AS calls_phone_number
    ,calls.ivr_result AS calls_ivr_result
    ,calls.vdn_label AS calls_vdn_label
    ,calls.start_date AS calls_start_date
    ,SAFE_CAST(FORMAT_DATE('%Y%m%d' ,calls.start_date) AS INT64) AS calls_start_date_id
    ,calls.end_date AS calls_end_date
    ,SAFE_CAST(FORMAT_DATE('%Y%m%d' ,calls.end_date) AS INT64) AS calls_end_date_id
    ,calls.total_duration AS calls_total_duration
    ,calls.customer_segment AS calls_customer_segment
    ,calls.ivr_language AS calls_ivr_language
    ,calls.steps_module AS calls_steps_module
    ,calls.module_aggregation AS calls_module_aggregation
    ,modules.module_sequece
    ,modules.module_name
    ,modules.module_duration
    ,modules.module_result
    ,step.step_sequence
    ,step.step_name
    ,step.step_result
    ,step.step_description_error
    ,step.document_type
    ,step.document_identification
    ,step.customer_phone
    ,step.billing_account_id
    
  FROM `keepcoding.ivr_calls` calls
  LEFT 
  JOIN `keepcoding.ivr_modules` modules
  ON calls.ivr_id = modules.ivr_id
  LEFT
  JOIN `keepcoding.ivr_steps` step
  ON modules.ivr_id = step.ivr_id AND modules.module_sequece = step.module_sequece