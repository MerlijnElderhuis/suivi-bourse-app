FROM python:3.8

WORKDIR /usr/src/app

ENV INFLUXDB_HOST=suivi-bourse-influxdb
ENV INFLUXDB_PORT=8086
ENV INFLUXDB_DATABASE=bourse

COPY app/Pipfile .
COPY app/Pipfile.lock .

RUN pip install pipenv
RUN pipenv lock --requirements > requirements.txt
RUN pip install -r requirements.txt

COPY patchs_libs/base.py /usr/local/lib/python3.8/site-packages/yfinance/base.py

COPY ./app/ .

VOLUME [ "/data" ]

CMD ["python3", "main.py"]

