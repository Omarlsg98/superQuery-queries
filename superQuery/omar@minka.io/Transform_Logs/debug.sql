CREATE OR REPLACE TABLE minka-ach-dw.ach_tin_logs.subset AS
SELECT
    *
FROM
    minka-ach-dw.ach_tin_logs.logs_transfer_ids
WHERE
   transfer_id IN ('fOb827deUNn7FnDhH',
'IgzVTggH6BAIzN2NE',
'nAPRhEkqJA0nFKyFE',
'8YXBlSWsyOkpDyNoJ',
'rdiFcEpNFIp7UQtWP',
'AEktMtpvbthV8VFyo',
'hQtVulxHYKjeKPGq2',
'eqoJIPQLU6rM7fWhT',
'VjzGVnKvJ1UQcuY9S',
'NuzFBgDtV6hK4qx7l',
'g6RlTgjM3N4ErtFoG',
'IYNjcES6gIyRCtWPw',
'RUnvL5Zo7UOOkTb6P',
'tlWIuWi7xKnDsc5Vx',
'Jg7nPMJinXSltSt4j',
'04gXwTXFYdgQOJ6wV',
'65noxBZPSNuUG3Qnv',
'8f5uFLIQ03fEPLl89',
'aHVHIMzOHUs701q5F',
'yy0QFflYU5wj0qGc9',
'0eK8tJyR6fFl9pR4Q',
'2M2PvgHaRgPzS7DYz')
ORDER BY 
    transfer_id, timestamp ASC