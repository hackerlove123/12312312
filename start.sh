#!/bin/bash
# Khởi động code-server
code-server --auth none --bind-addr 0.0.0.0:8080 /home/jovyan/work &

# Khởi động JupyterLab
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token='' --NotebookApp.password=''
