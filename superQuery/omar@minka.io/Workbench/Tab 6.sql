SELECT  
    DATETIME(TIMESTAMP(SUBSTR("2020-06-15T18:20:46.845Z",1,19))) BETWEEN
    DATETIME_SUB(DATETIME(TIMESTAMP(SUBSTR("2020-06-15T13:17:23-05:00",1,19))), INTERVAL 5 MINUTE)
    AND DATETIME_ADD(DATETIME(TIMESTAMP(SUBSTR("2020-06-15T13:17:23-05:00",1,19))), INTERVAL 5 MINUTE)