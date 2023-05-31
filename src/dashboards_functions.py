from connection.conn_mysql import conectar_mysql
from env import HOST, USER, PASSWORD
from tables.create_tables import *
from dashboards.dash_os import *
from dashboards.dash_pedidos import *
from dashboards.dash_financeiro import *
from dashboards.dash_faturamento import *
from dashboards.dash_compras import *

def generate_dash_os():
    # Criar conexão com o MySQL
    database = 'dash_os'
    conexao = conectar_mysql(HOST, USER, PASSWORD, database)

    if conexao:
        # Obter o DataFrame da função get_ordem_servico
        df_ordem_servico = get_ordem_servico()
        create_table(conexao, database, 'ordem_servico', df_ordem_servico)

        # # Obter o DataFrame da função get_condpagto_os
        df_condpagto_os = get_condpagto_os()
        create_table(conexao, database, 'condpagto_os', df_condpagto_os)

        # # Obter o DataFrame da função get_itens_os
        df_itens_os = get_itens_os()
        create_table(conexao, database, 'itens_os', df_itens_os)

        # # Obter o DataFrame da função get_centro_custo
        df_centro_custo = get_centro_custo()
        create_table(conexao, database, 'centro_custo', df_centro_custo)


def generate_dash_compras():
    # Criar conexão com o MySQL
    database = 'dash_compras'
    conexao = conectar_mysql(HOST, USER, PASSWORD, database)

    if conexao:
        # Obter o DataFrame da função get_ordem_servico
        df_compras = get_compras()
        create_table(conexao, database, 'compras', df_compras)


def generate_dash_pedidos():
    # Criar conexão com o MySQL
    database = 'dash_pedidos'
    conexao = conectar_mysql(HOST, USER, PASSWORD, database)

    if conexao:
        # Obter o DataFrame da função get_pedidos
        df_pedidos = get_pedidos()
        create_table(conexao, database, 'pedidos', df_pedidos)


def generate_dash_faturamento():
    # Criar conexão com o MySQL
    database = 'dash_faturamento'
    conexao = conectar_mysql(HOST, USER, PASSWORD, database)

    if conexao:
        # Obter o DataFrame da função get_pedidos
        df_vendas = get_faturamento()
        create_table(conexao, database, 'vendas', df_vendas)


def generate_dash_financeiro():
    # Criar conexão com o MySQL
    database = 'dash_financeiro'
    conexao = conectar_mysql(HOST, USER, PASSWORD, database)

    if conexao:
        # Obter o DataFrame da função
        df_fluxocaixa = get_fluxocaixa()
        create_table(conexao, database, 'fluxo_caixa', df_fluxocaixa)

        # Obter o DataFrame da função
        df_calendario = get_calendario()
        create_table(conexao, database, 'calendario', df_calendario)

        # Obter o DataFrame da função
        df_cadastro_grupo = get_cadastrogrupo()
        create_table(conexao, database, 'cadastro_grupo', df_cadastro_grupo)

        # Obter o DataFrame da função
        df_comp_fat_desp = get_comparativo_fat_desp()
        create_table(conexao, database, 'comparativo_fat_desp', df_comp_fat_desp)

        # Obter o DataFrame da função
        df_comp_rec_desp = get_comparativo_rec_desp()
        create_table(conexao, database, 'comparativo_rec_desp', df_comp_rec_desp)

        # Obter o DataFrame da função
        df_contacorrente = get_conta_corrente()
        create_table(conexao, database, 'conta_corrente', df_contacorrente)

        # Obter o DataFrame da função
        df_empresa = get_empresa()
        create_table(conexao, database, 'empresa', df_empresa)

        # Obter o DataFrame da função
        df_estoque = get_estoque()
        create_table(conexao, database, 'estoque', df_estoque)

        # Obter o DataFrame da função
        df_grupo_despesa = get_grupo_despesa()
        create_table(conexao, database, 'grupo_despesa', df_grupo_despesa)

        # Obter o DataFrame da função
        df_inadimplencia = get_inadimplencia()
        create_table(conexao, database, 'inadimplencia', df_inadimplencia)

        # Obter o DataFrame da função
        df_previsao_pagamento = get_previsao_pagamento()
        create_table(conexao, database, 'previsao_pagamento', df_previsao_pagamento)

        # Obter o DataFrame da função
        df_recebimento_tipo = get_recebimento_tipo()
        create_table(conexao, database, 'recebimento_tipo', df_recebimento_tipo)