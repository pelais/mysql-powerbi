from dashboards_functions import *
from datetime import datetime, time, timedelta, date
import logging
import os
import time as time_module
import schedule

DEFAULT_LOG_FORMAT = '%(asctime)s - [%(levelname)8s] - %(threadName)24s - %(module)24s - %(funcName)24s - %(message)s'
DEFAULT_LOG_LEVEL = 'INFO'
LOG_LEVEL = os.getenv('LOG_LEVEL', DEFAULT_LOG_LEVEL)
LOG_FORMAT = os.getenv('LOG_FORMAT', DEFAULT_LOG_FORMAT)

# Habilitar o logging
logging.basicConfig(format=LOG_FORMAT, level=LOG_LEVEL)
logger = logging.getLogger(__name__)
logger.setLevel(LOG_LEVEL)

# Comando para gerar o executável #
# 1 - pip install auto-py-to-exe
# 2- Abrir o terminal e executar: auto-py-to-exe
# 3 - Incluir os dados do main e será executado caminho do próximo passo
# 4 - pyinstaller --noconfirm --onefile --console --icon "C:/Ricardo/Github/mysql-powerbi/src/icon.ico" --name "PowerBI - Hidrosilas"  "C:/Ricardo/Github/mysql-powerbi/src/main.py"
# Comando para gerar o executável #


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

# Função para agendar a execução nos horários desejados
def schedule_job():
    job_schedule = ["08:00", "16:00"]
    
    for time_str in job_schedule:
        scheduled_time = datetime.combine(date.today(), time.fromisoformat(time_str))
        schedule.every().day.at(scheduled_time.strftime("%H:%M")).do(main)

    while True:
        next_run = schedule.next_run()
        next_run_str = next_run.strftime("%Y-%m-%d %H:%M:%S")
        logger.info(f"Próxima execução agendada para: {next_run_str}")
        schedule.run_pending()
        time_module.sleep(900) # Verifica a cada 15 minutos

if __name__ == '__main__':
    # main()
    schedule_job()