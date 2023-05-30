from dashboards_functions import *
from datetime import datetime
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

def main():

    start = datetime.now()

    logger.info('Iniciando Geração das tabelas no MYSQL')

    generate_dash_os()
    generate_dash_compras()
    generate_dash_pedidos()
    generate_dash_faturamento()
    generate_dash_financeiro()

    logger.info('Processo finalizado com sucesso!')
    
    end = datetime.now()
    logger.info('Total execution time: {}'.format(
        (end - start).total_seconds()))

if __name__ == '__main__':
    main()