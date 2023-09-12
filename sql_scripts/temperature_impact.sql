WITH bike_data_daily AS (
	SELECT
		DATE(start_time),
		COUNT(record_id) AS record_count
	FROM bike_data
	GROUP BY 1
),

weather_data_classify AS (
	SELECT
		date,
		temperature_max,
		CASE
			WHEN temperature_max <= 20 THEN '01 -> Max Temp Below 21 deg. F'
			WHEN temperature_max <= 30 THEN '02 -> Max Temp Between 21 and 30 deg. F'
			WHEN temperature_max <= 40 THEN '03 -> Max Temp Between 31 and 40 deg. F'
			WHEN temperature_max <= 50 THEN '04 -> Max Temp Between 41 and 50 deg. F'	
			WHEN temperature_max <= 60 THEN '05 -> Max Temp Between 51 and 60 deg. F'
			WHEN temperature_max <= 70 THEN '06 -> Max Temp Between 61 and 70 deg. F'
			WHEN temperature_max <= 80 THEN '07 -> Max Temp Between 71 and 80 deg. F'
			WHEN temperature_max <= 90 THEN '08 -> Max Temp Between 81 and 90 deg. F'
			WHEN temperature_max <= 100 THEN '09 -> Max Temp Between 91 and 100 deg. F'	
			ELSE '10 -> Max Temp Greater than 100 deg. F'
		END AS temperature_classify
	FROM weather_data
),

combine_daily AS (
	SELECT
		wd.date,
		bd.record_count,
		wd.temperature_max,
		wd.temperature_classify
	FROM weather_data_classify wd
	LEFT JOIN bike_data_daily bd
		ON wd.date = bd.date
	ORDER BY 1
)

SELECT
	temperature_classify,
	COUNT(date) AS number_of_days,
	ROUND(AVG(record_count), 1) avg_daily_rentals
FROM combine_daily
GROUP BY 1
ORDER BY 1;