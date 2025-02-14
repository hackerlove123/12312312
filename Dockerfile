# Sử dụng base image với JupyterLab 3.x
FROM jupyter/base-notebook:latest

# Cài đặt các công cụ cần thiết
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    git \
    htop \
    speedtest-cli \
    sudo \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Thiết lập mật khẩu root
RUN echo "root:negan" | chpasswd

# Cấp quyền sudo cho user jovyan (user mặc định của JupyterLab)
RUN echo "jovyan ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Copy file start.sh vào container
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Thiết lập quyền cho user root
USER root

# Expose cổng 8888 để chạy JupyterLab
EXPOSE 8888

# Chạy script start.sh khi container khởi động
CMD ["start.sh"]
