--Update schema
CREATE OR REPLACE TABLE
    `minka-ach-dw.ach_tin_20200702_1159.action` (
    action_id STRING,
    action_source STRING,
    action_target STRING,
    action_amount STRING,
    action_symbol STRING,
    action_transfer_id STRING,
    action_tx_id STRING,
    action_type STRING,
    action_status STRING,
    action_desc STRING,
    action_created STRING,
    action_udpated STRING,
    action_hash STRING,
    error_code STRING,
    action_source_bankname STRING,
    action_source_bankaccounttype STRING,
    action_source_bankaccountnum STRING,
    action_target_bankname STRING,
    action_target_bankaccounttype STRING,
    action_target_bankaccountnum STRING)
/*
** New Field syntax
    a BOOL,
    b STRING NOT NULL ,
    c FLOAT64 NOT NULL OPTIONS(description="An optional INTEGER field"),
    d STRUCT<
        da INT64 OPTIONS(description="An optional INTEGER field"),
        db ARRAY<STRING> OPTIONS(description="A repeated STRING field"),
        dc BOOL
    >
*/