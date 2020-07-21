SELECT 
    k.timestamp
    ,k.textPayLoad AS text_pay_load
FROM (
      SELECT ARRAY_AGG(row LIMIT 1)[OFFSET(0)] k 
      FROM 
        `minka-ach-dw.ach_tin_logs.both_logs` row
      GROUP BY 
        timestamp,textPayLoad
    )