from connection.conn_firebird import connect_to_firebird, execute_query
import pandas as pd
from env import FIREBIRD_HOST, FIREBIRD_USER, FIREBIRD_PASSWORD, FIREBIRD_DATABASE_ATUAL, FIREBIRD_DATABASE_BACKUP
import requests
from decimal import Decimal

def execute_firebird_query(query):
    fb_1 = connect_to_firebird(
        host=FIREBIRD_HOST,
        database=FIREBIRD_DATABASE_ATUAL,
        user=FIREBIRD_USER,
        password=FIREBIRD_PASSWORD
    )

    fb_2 = connect_to_firebird(
        host=FIREBIRD_HOST,
        database=FIREBIRD_DATABASE_BACKUP,
        user=FIREBIRD_USER,
        password=FIREBIRD_PASSWORD
    )

    result1, columns1 = execute_query(fb_1, query)
    result2, columns2 = execute_query(fb_2, query)

    df1 = pd.DataFrame(result1, columns=columns1)
    df2 = pd.DataFrame(result2, columns=columns2)
    df_combine = pd.concat([df1, df2], axis=0, ignore_index=True)

    # Verificar se a coluna é decimal e aplica o float no dataframe
    decimal_columns = df_combine.apply(lambda s: s.apply(lambda x: isinstance(x, Decimal)).any())
    for col in decimal_columns[decimal_columns].index:
        df_combine[col] = df_combine[col].astype(float)
        
    df_final = df_combine.drop_duplicates()

    return df_final

def read_sql_from_github(url):
    response = requests.get(url)
    if response.status_code == 200:
        return response.text
    else:
        # Tratar erros de requisição, se necessário
        raise Exception(f"Failed to read SQL file from GitHub. Status code: {response.status_code}")

def get_faturamento():
    sql_url = "https://raw.githubusercontent.com/pelais/mysql-powerbi/master/querys/faturamento/q-vendas.sql"
    query = read_sql_from_github(sql_url)

    return execute_firebird_query(query)
