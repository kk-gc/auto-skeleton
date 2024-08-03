FROM ubuntu:latest

ENV DB_PG_VER="16"
ENV DB_USER="db_user"
ENV DB_NAME="db_name"

WORKDIR /home/ubuntu/
ADD ./config/* ./config/
ADD ./tools/* ./tools/
ADD ./src/* ./src/

RUN apt -y -qq update && apt -y -qq full-upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
RUN apt -y -qq install build-essential nano git python3 python3-dev python3-venv 

# postgresql:
RUN apt -y -qq install libpq-dev postgresql
RUN sed -i -e 's/peer/trust/g' /etc/postgresql/$DB_PG_VER/main/pg_hba.conf
RUN sed -i -e 's/scram-sha-256/trust/g' /etc/postgresql/$DB_PG_VER/main/pg_hba.conf

USER postgres
RUN service postgresql start && createuser $DB_USER --superuser --no-password && createdb $DB_NAME
# ------------

# python venv:
USER ubuntu
RUN python3 -m venv $HOME/venv
RUN . $HOME/venv/bin/activate && pip install -r $HOME/src/requirements.txt
# ------------

# cookiecutter:
RUN git clone https://github.com/cookiecutter/cookiecutter-django.git

RUN mv ./cookiecutter-django/cookiecutter.json ./cookiecutter-django/cookiecutter.json.old
RUN cp -p ./config/cookiecutter.json ./cookiecutter-django/

RUN . $HOME/venv/bin/activate && cookiecutter --no-input ./cookiecutter-django/ --output-dir ./

RUN . $HOME/venv/bin/activate && python $HOME/tools/db_cred_patch.py $DB_USER $DB_NAME
RUN . $HOME/venv/bin/activate && python $HOME/tools/patcher.py $HOME/test_project/config/settings/base.py 6 $HOME/base.py.patch

# -------------

USER root
ENTRYPOINT /home/ubuntu/config/run.sh

