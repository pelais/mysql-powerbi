import pymysql
import pandas as pd
from decimal import Decimal

import logging
import os

DEFAULT_LOG_FORMAT = '%(asctime)s - [%(levelname)8s] - %(threadName)24s - %(module)24s - %(funcName)24s - %(message)s'
DEFAULT_LOG_LEVEL = 'INFO'
LOG_LEVEL = os.getenv('LOG_LEVEL', DEFAULT_LOG_LEVEL)
LOG_FORMAT = os.getenv('LOG_FORMAT', DEFAULT_LOG_FORMAT)

# enable logging
logging.basicConfig(format=LOG_FORMAT, level=LOG_LEVEL)
logger = logging.getLogger(__name__)
logger.setLevel(LOG_LEVEL)

# Função para converter os tipos de dados
def convert_types(row):
    converted_row = []
    for value in row:
        if pd.isnull(value):
            converted_row.append(None)
        elif isinstance(value, pd.Timestamp):
            converted_row.append(value.to_pydatetime())
        elif isinstance(value, pd.Series):
            converted_row.append(value.tolist())
        elif isinstance(value, bytes):
            converted_row.append(value.decode('utf-8'))
        elif isinstance(value, Decimal):
            converted_row.append(float(value))
        else:
            converted_row.append(value)
    return converted_row

def create_table(conexao, schema, nome_tabela, dataframe):
    try:
        cursor = conexao.cursor()
        cursor.execute(f"USE {schema}")

        if table_exist(conexao, schema, nome_tabela):
            cursor.execute(f"DROP TABLE {nome_tabela}")
            # print(f'Tabela "{nome_tabela}" excluída com sucesso!')

        comando_sql = genarate_command_sql(nome_tabela, dataframe)
        cursor.execute(comando_sql)
        logger.info(f'Tabela "{nome_tabela}" criada com sucesso!')

        # Inserção dos dados no MySQL
        for _, row in dataframe.iterrows():
            # Substitua os valores NaN por None para evitar erros
            row = row.where((pd.notnull(row)), None)
            row = convert_types(row)
            placeholders = ', '.join(['%s'] * len(row))
            query = f"INSERT INTO {schema}.{nome_tabela} VALUES ({placeholders})"
            cursor.execute(query, tuple(row))

        # Efetua o commit das alterações no banco de dados
        conexao.commit()

        logger.info(f'Dados inseridos na tabela "{nome_tabela}" com sucesso!')
    except pymysql.Error as e:
        logger.info(f'Erro ao criar ou excluir a tabela "{nome_tabela}": {e}')

def table_exist(conexao, schema, nome_tabela):
    cursor = conexao.cursor()
    cursor.execute(f"SHOW TABLES FROM {schema} LIKE '{nome_tabela}'")
    return cursor.fetchone() is not None

def genarate_command_sql(nome_tabela, dataframe):
    colunas = []

    for coluna, tipo in dataframe.dtypes.items(): #Change "iteritems" for "items"
        if tipo == 'object':
            tipo_coluna = 'TEXT'
        elif tipo == 'int64':
            tipo_coluna = 'INT'
        elif tipo == 'float64':
            tipo_coluna = 'FLOAT'
        elif tipo == 'datetime64[ns]':
            tipo_coluna = 'DATETIME'
        elif tipo == 'bool':
            tipo_coluna = 'BOOLEAN'
        elif tipo == 'bytes':
            tipo_coluna = 'LONGBLOB'
        else:
            tipo_coluna = 'VARCHAR(255)'

        colunas.append(f"{coluna} {tipo_coluna}")

    colunas_sql = ", ".join(colunas)
    return f"CREATE TABLE {nome_tabela} ({colunas_sql})"