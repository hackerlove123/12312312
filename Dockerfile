# Sử dụng base image với JupyterLab
FROM jupyter/base-notebook:latest

# Chuyển sang user root để cài đặt các gói và cấu hình
USER root

# Cài đặt các công cụ cần thiết
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    git \
    htop \
    sudo \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Xóa mật khẩu của user root (để không cần nhập mật khẩu)
RUN passwd -d root

# Cấp quyền sudo không cần mật khẩu cho user jovyan
RUN echo "jovyan ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Thiết lập user mặc định là root
ENV NB_USER root
ENV NB_UID 0
ENV NB_GID 0

# Copy file start.sh vào container
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Thiết lập quyền cho user root
USER root

# Expose cổng 8888 để chạy JupyterLab
EXPOSE 8888

# Chạy script start.sh khi container khởi động
CMD ["/usr/local/bin/start.sh"]
