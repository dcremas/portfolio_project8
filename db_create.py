import psycopg
from shared_funcs import db_connect_string

create_table_bikedata = """
CREATE TABLE bike_data (
record_id INTEGER,
trip_duration VARCHAR,
start_time TIMESTAMP,
stop_time TIMESTAMP,
start_station_id INTEGER,
start_station_name VARCHAR,
start_station_latitude REAL,
start_station_longitude REAL,
end_station_id INTEGER,
end_station_name VARCHAR,
end_station_latitude REAL,
end_station_longitude REAL,
bike_id INTEGER,
user_type VARCHAR,
birth_year INTEGER,
gender VARCHAR
);
"""

create_table_weatherdata = """
CREATE TABLE weather_data (
record_id INTEGER,
station_id VARCHAR,
station_name VARCHAR,
date DATE,
average_wind_speed REAL,
precipitation REAL,
snowfall REAL,
snow_depth REAL,
temperature_avg INTEGER,
temperature_max INTEGER,
temperature_min INTEGER
);
"""

with psycopg.connect(db_connect_string("portfolio_bikedata")) as conn:
    try:
        cur = conn.cursor()
        cur.execute(create_table_bikedata)
        cur.execute(create_table_weatherdata)
        conn.commit()
    except:
        print("This table already exists")
