from connection.conn_firebird import connect_to_firebird, execute_query
import pandas as pd
from env import FIREBIRD_HOST, FIREBIRD_USER, FIREBIRD_PASSWORD, FIREBIRD_DATABASE_ATUAL, FIREBIRD_DATABASE_BACKUP

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
    df_final = df_combine.drop_duplicates()

    return df_final

def get_ordem_servico():
    with open('querys/ordem-servico/q-ordem-servico.sql', 'r', encoding='utf-8') as arquivo:
        query = arquivo.read()

    return execute_firebird_query(query)

def get_condpagto_os():
    with open('querys/ordem-servico/q-condpgto-os.sql', 'r', encoding='utf-8') as arquivo:
        query = arquivo.read()

    return execute_firebird_query(query)

def get_itens_os():
    with open('querys/ordem-servico/q-itens-os.sql', 'r', encoding='utf-8') as arquivo:
        query = arquivo.read()

    return execute_firebird_query(query)

def get_centro_custo():
    with open('querys/ordem-servico/q-centro-custo.sql', 'r', encoding='utf-8') as arquivo:
        query = arquivo.read()

    return execute_firebird_query(query)
