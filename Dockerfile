# Etapa 1: Usar uma imagem base oficial do Python.
# python:3.10-slim é uma boa escolha por ser leve e conter o necessário.
FROM python:3.10-slim

# Etapa 2: Definir o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências para o diretório de trabalho.
# Fazer isso separadamente aproveita o cache de camadas do Docker.
COPY requirements.txt .

# Etapa 4: Instalar as dependências.
# --no-cache-dir garante que o pip não armazene o cache, mantendo a imagem menor.
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar o restante do código da aplicação.
COPY . .

# Etapa 6: Expor a porta em que a aplicação será executada.
EXPOSE 8000

# Etapa 7: Definir o comando para iniciar a aplicação.
# Usamos uvicorn com --host 0.0.0.0 para que seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]