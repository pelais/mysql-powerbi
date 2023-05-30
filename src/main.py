from dashboards_functions import *
from datetime import datetime, time, timedelta, date
import time as time_module
import logging
import os
import schedule

DEFAULT_LOG_FORMAT = '%(asctime)s - [%(levelname)8s] - %(threadName)24s - %(module)24s - %(funcName)24s - %(message)s'
DEFAULT_LOG_LEVEL = 'INFO'
LOG_LEVEL = os.getenv('LOG_LEVEL', DEFAULT_LOG_LEVEL)
LOG_FORMAT = os.getenv('LOG_FORMAT', DEFAULT_LOG_FORMAT)

# enable logging
logging.basicConfig(format=LOG_FORMAT, level=LOG_LEVEL)
logger = logging.getLogger(__name__)
logger.setLevel(LOG_LEVEL)

execution_count = 0
MAX_EXECUTIONS = 5

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
    logger.info('Total execution time: {}'.format((end - start).total_seconds()))

if __name__ == '__main__':
    main()

# def run_main():
#     global execution_count

#     current_time = datetime.now().time()
#     current_weekday = date.today().weekday()
#     start_time = time(8, 0)  # Início do intervalo
#     end_time = time(19, 0)  # Fim do intervalo

#     if current_time < start_time:
#         return  # Se o horário atual for anterior a 08:00, não executar o main()

#     if start_time <= current_time <= end_time and current_weekday < 5:  # Executar apenas nos dias úteis e dentro do horário desejado
#         if execution_count < MAX_EXECUTIONS:
#             main()
#             execution_count += 1

# def schedule_runs():
#     current_time = datetime.now().time()
#     start_time = time(8, 0)  # Início do intervalo
#     end_time = time(19, 0)  # Fim do intervalo

#     if current_time < start_time:
#         schedule.every().day.at('08:00').do(run_main)
#     elif current_time > end_time:
#         next_day = datetime.now() + timedelta(days=1)
#         next_day_start = datetime.combine(next_day.date(), time(8, 0))
#         schedule.every().day.at(next_day_start.strftime('%H:%M')).do(run_main)
#     else:
#         schedule.every().hour.do(run_main)

# def print_next_scheduled_runs():
#     for job in schedule.jobs:
#         logger.info('Próxima execução agendada para {}'.format(job.next_run.strftime('%Y-%m-%d %H:%M:%S')))

# # Agendar as execuções
# schedule_runs()

# while True:
#     schedule.run_pending()

#     if execution_count == 0:
#         print_next_scheduled_runs()

#     time_module.sleep(10)