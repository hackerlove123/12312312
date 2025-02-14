# Sử dụng base image với JupyterLab 3.x
FROM jupyter/base-notebook:lab-3.6.5

# Cài đặt các công cụ cần thiết
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    git \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Cài đặt code-server (VSCode trên web)
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Copy file start.sh vào container
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Cài đặt JupyterLab extension để chạy code-server
RUN pip install jupyter-server-proxy

# Thiết lập quyền cho user mặc định (jovyan)
USER jovyan

# Expose cổng 8080 để chạy code-server
EXPOSE 8080

# Chạy script start.sh khi container khởi động
CMD ["start.sh"]
