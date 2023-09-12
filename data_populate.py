import csv
import psycopg
from shared_funcs import db_connect_string

insert_bikedata = """
INSERT INTO bike_data (record_id, trip_duration, start_time, stop_time, start_station_id,
start_station_name, start_station_latitude, start_station_longitude, end_station_id,
end_station_name, end_station_latitude, end_station_longitude, bike_id,
user_type, birth_year, gender)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);
"""

insert_weatherdata = """
INSERT INTO weather_data (record_id, station_id, station_name, date, average_wind_speed,
precipitation, snowfall, snow_depth, temperature_avg, temperature_max, temperature_min)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);
"""

with open("data_staging/bike_data_clean.csv", "r", newline="") as read_file:
    reader_bike = csv.reader(read_file, delimiter="|")
    reader_data_bike = [record for idx, record in enumerate(reader_bike) if idx > 0]

with open("data_staging/weather_data_clean.csv", "r", newline="") as read_file:
    reader_weather = csv.reader(read_file, delimiter="|")
    reader_data_weather = [record for idx, record in enumerate(reader_weather) if idx > 0]


with psycopg.connect(db_connect_string("portfolio_bikedata")) as conn:
    cur = conn.cursor()
    cur.executemany(insert_bikedata, reader_data_bike)
    cur.executemany(insert_weatherdata, reader_data_weather)
    conn.commit()
