SELECT  TIMESTAMP("2020-06-15T18:20:46.845Z") 
BETWEEN TIMESTAMP_SUB(TIMESTAMP("2020-06-15T13:17:23-05:00"), INTERVAL 5 MINUTE)
    AND TIMESTAMP_ADD(TIMESTAMP("2020-06-15T13:17:23-05:00"), INTERVAL 5 MINUTE)
    ,TIMESTAMP("2020-06-15T18:20:46.845Z")
    ,TIMESTAMP_SUB(TIMESTAMP("2020-06-15T13:17:23-05:00"), INTERVAL 5 MINUTE)
    ,TIMESTAMP_ADD(TIMESTAMP("2020-06-15T13:17:23-05:00"), INTERVAL 5 MINUTE)