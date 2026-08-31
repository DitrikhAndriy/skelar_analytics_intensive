WITH user_ts AS (
    SELECT
        id_user,
        id_region,
        SUM(amount) AS total_spend
    FROM task1
	WHERE status = 'success'
    GROUP BY id_user, id_region
),

region_avg AS (
    SELECT
        id_region,
        AVG(total_spend) AS avg_ts
    FROM user_ts
    GROUP BY id_region
)

SELECT
    u.id_user,
    u.id_region,
    u.total_spend
FROM user_ts AS u
JOIN region_avg AS r
    ON u.id_region = r.id_region
WHERE u.total_spend > r.avg_ts
ORDER BY
    u.id_region,
    u.total_spend DESC;