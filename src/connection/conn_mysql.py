import pymysql

HOST = 'localhost'  # substitua pelo endereço do servidor MySQL
USER = 'root'  # substitua pelo nome de usuário do MySQL
PASSWORD = 'NXWMevp?E]TgpUzFN4`d'  # substitua pela senha do MySQL

# Conexão MySQL
def conectar_mysql(host, user, password, database):
    try:
        conexao = pymysql.connect(
            host=host,
            user=user,
            password=password,
            charset='utf8'
        )
        print('Conexão estabelecida com o MySQL.')

        # Cria o banco de dados caso não exista
        cursor = conexao.cursor()
        cursor.execute(f"CREATE SCHEMA IF NOT EXISTS {database}")
        print(f'Banco de dados "{database}" criado com sucesso!')

        # Conecta ao banco de dados
        conexao = pymysql.connect(
            host=host,
            user=user,
            password=password,
            database=database
        )
        print('Conexão estabelecida com o banco de dados.')
        return conexao
    except pymysql.Error as e:
        print(f'Erro ao conectar ao MySQL: {e}')
        return None