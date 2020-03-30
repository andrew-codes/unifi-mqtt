FROM python:2.7

RUN apt-get update && apt-get install -y -q --no-install-recommends zip libsasl2-dev python-dev libldap2-dev libssl-dev

RUN mkdir -p /app
COPY . /app
WORKDIR /app

RUN pip install -r requirements.txt

CMD python unifi.py
