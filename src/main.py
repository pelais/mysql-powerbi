from dashboards_functions import *

def main():

    print('### Iniciando Geração das tabelas no MYSQL ###')
    generate_dash_os()
    generate_dash_compras()
    generate_dash_pedidos()
    generate_dash_faturamento()

if __name__ == '__main__':
    main()