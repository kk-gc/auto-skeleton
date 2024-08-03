#!/bin/bash
# usage: ./build.sh <image_name>
docker build --tag $1:latest .
