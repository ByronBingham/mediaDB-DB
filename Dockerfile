# syntax=docker/dockerfile:1

FROM postgres:15.1
RUN apt-get update && apt-get install -y python3-pip
COPY ./requirements.txt /db/requirements.txt
RUN pip install -r /db/requirements.txt
COPY ./build_db.py /db/build_db.py
COPY ./mediaDB-Config/db_config_schema.json /db/db_config_schema.json
COPY ./db-entrypoint.sh /db/db-entrypoint.sh

ENTRYPOINT [ "/db/db-entrypoint.sh" ]
CMD ""