FROM python:3.10

WORKDIR /app

COPY requirements.txt .

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install gcc default-libmysqlclient-dev pkg-config -y \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000
