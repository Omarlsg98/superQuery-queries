SELECT timestamp,textPayload
FROM `ach-tin-prd.achtin_logs.stdout`
WHERE textPayload like "%sJbXlNqFAHpvJtdGB%"
ORDER BY timestamp ASC
LIMIT 1000