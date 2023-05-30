from connection.conn_firebird import connect_to_firebird, execute_query
import pandas as pd

def get_pedidos():
    # Conexão com os bancos de dados Firebird
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

    # Faz a leitura da query na pasta
    with open('querys/pedidos/q-pedidos.sql', 'r') as arquivo:
        query = arquivo.read()


    result1, columns1 = execute_query(fb_1, query)
    result2, columns2 = execute_query(fb_2, query)

    # Combina os resultados em um único DataFrame
    df1 = pd.DataFrame(result1, columns=columns1)
    df2 = pd.DataFrame(result2, columns=columns2)
    df_combine = pd.concat([df1, df2], axis=0, ignore_index=True)
    
    df_final = df_combine.drop_duplicates()

    return df_final