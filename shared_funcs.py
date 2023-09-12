
def db_connect_string(db_name=None):

    from configparser import ConfigParser

    config = ConfigParser()
    config.read("config.ini")
    db = db_name
    user = config['PORTFOLIO_8']['username']
    password = config['PORTFOLIO_8']['password']
    host = config['PORTFOLIO_8']['host']
    port = config['PORTFOLIO_8']['port']

    connection_string = f"dbname={db} user={user} password={password} host={host} port={port}"

    return connection_string


def db_connect_url(db_name=None):

    from configparser import ConfigParser

    config = ConfigParser()
    config.read("config.ini")
    db = db_name
    user = config['PORTFOLIO_8']['username']
    password = config['PORTFOLIO_8']['password']
    host = config['PORTFOLIO_8']['host']
    port = config['PORTFOLIO_8']['port']

    connection_url = f"postgresql+psycopg://{user}:{password}@{host}:{port}/{db}"

    return connection_url


if __name__ == '__main__':

    conn_string = db_connect_string("portfolio_bikedata")
    conn_url = db_connect_url("portfolio_bikedata")

    print(f"The connection string is : {conn_string}")
    print()
    print(f"The connection url is : {conn_url}")
