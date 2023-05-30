from connection.conn_firebird import connect_to_firebird, execute_query
import pandas as pd

def execute_firebird_query(query):
    fb_1 = connect_to_firebird(
        host='localhost',
        database='C:\ONCLICK\ARQUIVOS\GRUPO_HS_ATUAL.GDB',
        user='SYSDBA',
        password='masterkey'
    )

    fb_2 = connect_to_firebird(
        host='localhost',
        database='C:\ONCLICK\ARQUIVOS\BACKUP_2022.GDB',
        user='SYSDBA',
        password='masterkey'
    )

    result1, columns1 = execute_query(fb_1, query)
    result2, columns2 = execute_query(fb_2, query)

    df1 = pd.DataFrame(result1, columns=columns1)
    df2 = pd.DataFrame(result2, columns=columns2)
    df_combine = pd.concat([df1, df2], axis=0, ignore_index=True)
    df_final = df_combine.drop_duplicates()

    return df_final

def get_fluxocaixa():
    with open('querys/financeiro/q-fluxo-caixa.sql', 'r', encoding='utf-8') as arquivo:
        query = arquivo.read()

    return execute_firebird_query(query)

def get_calendario():
    with open('querys/financeiro/q-calendario.sql', 'r', encoding='utf-8') as arquivo:
        query = arquivo.read()

    return execute_firebird_query(query)

def get_cadastrogrupo():
    with open('querys/financeiro/q-cadastro-grupo.sql', 'r', encoding='utf-8') as arquivo:
        query = arquivo.read()

    return execute_firebird_query(query)

def get_comparativo_fat_desp():
    with open('querys/financeiro/q-comparativo-fat-desp.sql', 'r', encoding='utf-8') as arquivo:
        query = arquivo.read()

    return execute_firebird_query(query)


def get_comparativo_rec_desp():
    with open('querys/financeiro/q-comparativo-rec-desp.sql', 'r', encoding='utf-8') as arquivo:
        query = arquivo.read()

    return execute_firebird_query(query)

def get_conta_corrente():
    with open('querys/financeiro/q-conta-corrente.sql', 'r', encoding='utf-8') as arquivo:
        query = arquivo.read()

    return execute_firebird_query(query)

def get_empresa():
    with open('querys/financeiro/q-empresa.sql', 'r', encoding='utf-8') as arquivo:
        query = arquivo.read()

    return execute_firebird_query(query)

def get_estoque():
    with open('querys/financeiro/q-estoque.sql', 'r', encoding='utf-8') as arquivo:
        query = arquivo.read()

    return execute_firebird_query(query)

def get_grupo_despesa():
    with open('querys/financeiro/q-grupo-despesa.sql', 'r', encoding='utf-8') as arquivo:
        query = arquivo.read()

    return execute_firebird_query(query)

def get_inadimplencia():
    with open('querys/financeiro/q-inadimplencia.sql', 'r', encoding='utf-8') as arquivo:
        query = arquivo.read()

    return execute_firebird_query(query)

def get_previsao_pagamento():
    with open('querys/financeiro/q-previsao-pagamento.sql', 'r', encoding='utf-8') as arquivo:
        query = arquivo.read()

    return execute_firebird_query(query)

def get_recebimento_tipo():
    with open('querys/financeiro/q-recebimento-tipo.sql', 'r', encoding='utf-8') as arquivo:
        query = arquivo.read()

    return execute_firebird_query(query)