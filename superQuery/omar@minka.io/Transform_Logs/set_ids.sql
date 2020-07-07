CREATE TABLE minka-ach-dw.temp.mini_logs AS 
SELECT 
   timestamp
   ,textPayLoad
FROM 
    minka-ach-dw.ach_tin_logs.stdout
WHERE
    textPayLoad like "%FnmtWMnLvvwWOJcMf%" or textPayLoad like "%d84f3e5d-3e16-4dee-8bfa-08f3de969af1%"