WITH data_transform AS (
	SELECT
		record_id,
		trip_duration,
		start_station_longitude,
		start_station_latitude,
		ST_Point(start_station_longitude, start_station_latitude, 4326) as start_point,
		ST_Point(end_station_longitude, end_station_latitude, 4326) as stop_point
	FROM bike_data
)

SELECT
	record_id,
	trip_duration,
	ST_Distance(ST_Transform(start_point, 26910), ST_Transform(stop_point, 26910)) 
FROM data_transform
ORDER by trip_duration DESC
LIMIT 1000;