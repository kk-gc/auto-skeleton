#!/bin/bash
# usage: ./create.sh <image_name> <container_name>
docker create --name $2 -p 8000:8000 -it $1:latest /bin/bash
