SELECT timestamp,textPayload
FROM `ach-tin-prd.achtin_logs.stdout`
WHERE textPayload like "%hOTS8z72gWQf0wLmw%"
ORDER BY timestamp ASC
LIMIT 1000