SELECT timestamp,textPayload
FROM `ach-tin-prd.achtin_logs.stdout`
WHERE textPayload like "%4B0CnFjwDZ3euyBFJ%"
ORDER BY timestamp ASC
LIMIT 1000