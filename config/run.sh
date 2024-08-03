#!/bin/bash
export PROJECT="test_project"
export VENV="/home/ubuntu/venv/bin/activate"
export MANAGE="/home/ubuntu/$PROJECT/manage.py"

service postgresql start

su ubuntu -c ". $VENV && python3 $MANAGE makemigrations"
su ubuntu -c ". $VENV && python3 $MANAGE migrate"
# su ubuntu -c ". $VENV && --// DATA BASE AUTO LOADER \\--"
su ubuntu -c ". $VENV && python3 $MANAGE runserver 0.0.0.0:8000"

su ubuntu
/bin/bash

