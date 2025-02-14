FROM ubuntu:latest

# Cập nhật hệ thống và cài đặt Jupyter
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    jupyter \
    && rm -rf /var/lib/apt/lists/*

# Tạo thư mục làm việc
WORKDIR /root

# Chạy Jupyter Notebook với terminal
CMD ["jupyter", "notebook", "--NotebookApp.token=''", "--NotebookApp.password=''", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
