#!/usr/bin/env bash
python dockerfile_generator.py
docker-compose build jupyter
docker-compose kill jupyter
docker-compose up -d jupyter
