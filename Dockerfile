# Sử dụng base image với JupyterLab
FROM jupyter/base-notebook:latest

# Cài đặt các công cụ cần thiết
USER jovyan
RUN sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends \
    curl \
    git \
    htop \
    && sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*

# Copy file start.sh vào container
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Expose cổng 8888 để chạy JupyterLab
EXPOSE 8888

# Chạy script start.sh khi container khởi động
CMD ["/usr/local/bin/start.sh"]
