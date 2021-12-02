#!/bin/bash
export FLASK_APP=./bootling/index.py
source bootling/venv/bin/activate
flask run -h 0.0.0.0
