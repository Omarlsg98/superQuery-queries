SELECT
    timestamp
    ,CASE
        WHEN payload LIKE "%Starting request to InfoBip%" THEN "call_infobip"
        WHEN payload LIKE '%InfoBip has gotten SMS info with response%' THEN
            IF(payload LIKE "%Message sent successfully%","successful_infobip","fail_infobip")
        WHEN payload LIKE '%callUrl%' THEN 
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
        WHEN payload LIKE '%/continue%' THEN "continue_request"
        WHEN payload LIKE '%/sendit%' THEN "sendit_request"
        WHEN payload LIKE '%GET%' THEN  
            IF(payload LIKE "%transfer%","transfer_request","action_request")
        WHEN payload LIKE '%callUrlResponse%' THEN "bank_answer"
        WHEN payload LIKE '%Monitor [339]%' THEN "monitor_339" 
        WHEN payload LIKE '%Monitor [341]%' THEN "monitor_341"
        WHEN payload LIKE '%Monitor%' AND payload NOT LIKE "%[%" THEN "monitor_answer" 
        WHEN payload LIKE '%error-handling%' THEN "error"
        ELSE NULL
    END as category
    ,payload
FROM
    minka-ach-dw.ach_tin_logs.subset