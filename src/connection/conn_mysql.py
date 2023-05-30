import pymysql
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

# Conexão MySQL
def conectar_mysql(host, user, password, database):
    try:
        conexao = pymysql.connect(
            host=host,
            user=user,
            password=password,
            charset='utf8'
        )
        logger.info('Conexão estabelecida com o MySQL.')

        # Cria o banco de dados caso não exista
        cursor = conexao.cursor()
        cursor.execute(f"CREATE SCHEMA IF NOT EXISTS {database}")
        logger.info(f'Banco de dados "{database}" criado com sucesso!')

        # Conecta ao banco de dados
        conexao = pymysql.connect(
            host=host,
            user=user,
            password=password,
            database=database
        )
        logger.info('Conexão estabelecida com o banco de dados.')
        return conexao
    except pymysql.Error as e:
        logger.info(f'Erro ao conectar ao MySQL: {e}')
        return None