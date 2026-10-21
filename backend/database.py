import mysql.connector        # biblioteca para conectar ao MySQL
from dotenv import load_dotenv  # lê o arquivo .env
import os                      # acessa as variáveis de ambiente

load_dotenv()                  # carrega as variáveis do .env

def conectar():
    # cria e retorna uma conexão com o banco de dados
    return mysql.connector.connect(
        host=os.getenv("DB_HOST"),          # Vai ler '127.0.0.1' do seu .env
        port=3306,                          # ← FORÇA A PORTA PADRÃO
        user=os.getenv("DB_USER"),          # usuário do banco
        password=os.getenv("DB_PASSWORD"),  # senha do banco
        database=os.getenv("DB_NAME"),      # nome do banco
        auth_plugin='mysql_native_password', # Mantém a correção do travamento
        use_pure=True                       # ← FORÇA O PYTHON PURO (Evita que o Windows resete a conexão)
    )
