SELECT  TIMESTAMP("2020-06-15T15:31:28-05:00") 
BETWEEN TIMESTAMP_SUB("2020-06-15T15:44:28-05:00", INTERVAL 5 MINUTE)
    AND TIMESTAMP_ADD("2020-06-15T15:44:28-05:00", INTERVAL 5 MINUTE)