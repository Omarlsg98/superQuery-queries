CREATE OR REPLACE TABLE minka-ach-dw.temp.logs_transfor_test AS (
SELECT
    timestamp
    ,CASE
        WHEN payload LIKE '%cron%' THEN "cron"
        WHEN payload LIKE '%saveInDb%' THEN "db_write"
        WHEN payload LIKE '%updateAction%' THEN "db_update"
        WHEN payload LIKE '%database.read.action%' THEN "db_read"
        WHEN payload LIKE '%error-handling%' THEN "error"
        WHEN payload LIKE '%GET%' THEN  
            IF(payload LIKE "%transfer%","transfer_request","action_request")
        WHEN payload LIKE '%callUrl %' OR payload LIKE '%/router/%' THEN 
            CASE
            WHEN payload LIKE '%/debit%' THEN "call_debit"
            WHEN payload LIKE '%/Debit%' THEN "call_debit"
            WHEN payload LIKE '%/GenerarDebito%' THEN "call_debit"
            WHEN payload LIKE '%/debit_transactions%' THEN "call_debit"
            WHEN payload LIKE '%/action %' THEN "call_action"
            WHEN payload LIKE '%/sign_actions%' THEN "call_action"
            WHEN payload LIKE '%/transfer %' THEN "call_action"
            WHEN payload LIKE '%/approve-transfer%' THEN "call_action"
            WHEN payload LIKE '%/GenerarAccion%' THEN "call_action"
            WHEN payload LIKE '%/credit%' THEN "call_credit"
            WHEN payload LIKE '%/Download%' THEN "call_credit" 
            WHEN payload LIKE '%/pdn/-service-immediate-transfers-credit%' THEN "call_credit" 
            WHEN payload LIKE '%/GenerarCredito%' THEN "call_credit"
            WHEN payload LIKE '%/credit_transactions%' THEN "call_credit"
            WHEN payload LIKE '%/status%' THEN "call_status"
            WHEN payload LIKE '%/Status%' THEN "call_status"
            WHEN payload LIKE '%/GenerarEstado%' THEN "call_status"
            ELSE "call_unidentified"
        END
        WHEN payload LIKE '%callUrlError%' THEN "bank_answer_error"
        WHEN payload LIKE '%/continue%' THEN "continue_request"
        WHEN payload LIKE '%Continue Transfer.  Action%' THEN "continue_info"
        WHEN payload LIKE '%/sendit%' THEN "sendit_request"
        WHEN payload LIKE '%/accept%' THEN "accept_request"
        WHEN payload LIKE '%callUrlResponse%' THEN "bank_answer"
        WHEN payload LIKE '%Monitor%' THEN
            CASE
                WHEN payload LIKE '%[339]:%' THEN "monitor_339"
                WHEN payload LIKE '%[341]:%' THEN "monitor_341"
                ELSE"monitor_answer" 
            END
        WHEN payload LIKE '%error-handling%' THEN "error"
        WHEN payload LIKE '%creat%' AND payload LIKE '%transfer%' THEN "transfer_status"
        WHEN payload LIKE '%Continue Transfer %'  THEN "transfer_status"
        WHEN payload LIKE '%transfer update %'  THEN "transfer_status"
        WHEN payload LIKE "%Info%" THEN 
            CASE
                WHEN payload LIKE '%has gotten SMS info with response%' THEN
                     IF(payload LIKE "%Message sent successfully%"
                        ,"successful_infobip"
                        ,"fail_infobip")
                WHEN payload LIKE "%Starting request to%" THEN "call_infobip"
                ELSE "infobip_unidentified"
            END
        WHEN payload LIKE '%request%' THEN "request_preparation"
        ELSE NULL
    END as category
    ,payload
FROM
    minka-ach-dw.ach_tin_logs.subset
)