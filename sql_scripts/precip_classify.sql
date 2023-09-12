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
		precipitation,
		CASE
			WHEN precipitation = 0.0 THEN '01 -> No Precipitation'
			WHEN precipitation <= .10 THEN '02 -> Precipitation Between .01 and .1 inches'
			WHEN precipitation <= .20 THEN '03 -> Precipitation Between .11 and .2 inches'
			WHEN precipitation <= .30 THEN '04 -> Precipitation Between .21 and .3 inches'
			WHEN precipitation <= .40 THEN '05 -> Precipitation Between .31 and .4 inches'
			WHEN precipitation <= .50 THEN '06 -> Precipitation Between .41 and .5 inches'
			WHEN precipitation <= .60 THEN '07 -> Precipitation Between .51 and .6 inches'
			WHEN precipitation <= .70 THEN '08 -> Precipitation Between .61 and .7 inches'
			WHEN precipitation <= .80 THEN '09 -> Precipitation Between .71 and .8 inches'
			WHEN precipitation <= .90 THEN '10 -> Precipitation Between .81 and .9 inches'
			WHEN precipitation <= 1.0 THEN '11 -> Precipitation Between .91 and 1.0 inches'
			ELSE '12 -> Precipitation Greater than 1 inch'
		END AS precipitation_classify
	FROM weather_data
),

combine_daily AS (
	SELECT
		wd.date,
		bd.record_count,
		wd.precipitation,
		wd.precipitation_classify
	FROM weather_data_classify wd
	LEFT JOIN bike_data_daily bd
		ON wd.date = bd.date
	ORDER BY 1
)

SELECT
	precipitation_classify,
	COUNT(date) AS number_of_days,
	ROUND(AVG(record_count), 1) avg_daily_rentals
FROM combine_daily
GROUP BY 1
ORDER BY 1;