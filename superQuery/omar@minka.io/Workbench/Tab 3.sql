SELECT timestamp,textPayload
FROM `ach-tin-prd.achtin_logs.stdout`
WHERE textPayload like "%938RrCYGR6eWSJVzC%"
ORDER BY timestamp ASC
LIMIT 1000