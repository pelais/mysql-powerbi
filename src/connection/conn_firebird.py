import firebirdsql as fdb

def connect_to_firebird(host, database, user, password):
    return fdb.connect(
        host=host,
        database=database,
        user=user,
        password=password
    )

def execute_query(connection, query):
    cursor = connection.cursor()
    cursor.execute(query)
    return cursor.fetchall(), [desc[0] for desc in cursor.description]