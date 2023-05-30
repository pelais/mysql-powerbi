from connection.conn_mysql import conectar_mysql
from env import HOST, USER, PASSWORD
from tables.create_tables import *
import importlib

def generate_dash_os():
    # Criar conexão com o MySQL
    database = 'dash_os'
    conexao = conectar_mysql(HOST, USER, PASSWORD, database)

    if conexao:
        # Obter o DataFrame da função get_ordem_servico
        df_ordem_servico = importlib.import_module('dashboards.dash-os').get_ordem_servico()
        create_table(conexao, database, 'ordem_servico', df_ordem_servico)

        # # Obter o DataFrame da função get_condpagto_os
        df_condpagto_os = importlib.import_module('dashboards.dash-os').get_condpagto_os()
        create_table(conexao, database, 'condpagto_os', df_condpagto_os)

        # # Obter o DataFrame da função get_itens_os
        df_itens_os = importlib.import_module('dashboards.dash-os').get_itens_os()
        create_table(conexao, database, 'itens_os', df_itens_os)

        # # Obter o DataFrame da função get_centro_custo
        df_centro_custo = importlib.import_module('dashboards.dash-os').get_centro_custo()
        create_table(conexao, database, 'centro_custo', df_centro_custo)


def generate_dash_compras():
    # Criar conexão com o MySQL
    database = 'dash_compras'
    conexao = conectar_mysql(HOST, USER, PASSWORD, database)

    if conexao:
        # Obter o DataFrame da função get_ordem_servico
        df_compras = importlib.import_module('dashboards.dash-compras').get_compras()
        create_table(conexao, database, 'compras', df_compras)


def generate_dash_pedidos():
    # Criar conexão com o MySQL
    database = 'dash_pedidos'
    conexao = conectar_mysql(HOST, USER, PASSWORD, database)

    if conexao:
        # Obter o DataFrame da função get_pedidos
        df_pedidos = importlib.import_module('dashboards.dash-pedidos').get_pedidos()
        create_table(conexao, database, 'pedidos', df_pedidos)


def generate_dash_faturamento():
    # Criar conexão com o MySQL
    database = 'dash_faturamento'
    conexao = conectar_mysql(HOST, USER, PASSWORD, database)

    if conexao:
        # Obter o DataFrame da função get_pedidos
        df_vendas = importlib.import_module('dashboards.dash-faturamento').get_faturamento()
        create_table(conexao, database, 'vendas', df_vendas)


def generate_dash_financeiro():
    # Criar conexão com o MySQL
    database = 'dash_financeiro'
    conexao = conectar_mysql(HOST, USER, PASSWORD, database)

    if conexao:
        # Obter o DataFrame da função get_pedidos
        df_fluxocaixa = importlib.import_module('dashboards.dash-financeiro').get_fluxocaixa()
        create_table(conexao, database, 'fluxo_caixa', df_fluxocaixa)

        # Obter o DataFrame da função get_pedidos
        df_calendario = importlib.import_module('dashboards.dash-financeiro').get_calendario()
        create_table(conexao, database, 'calendario', df_calendario)