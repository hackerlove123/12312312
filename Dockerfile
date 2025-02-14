# Sử dụng một base image nhẹ với quyền root
FROM ubuntu:latest

# Cập nhật hệ thống và cài đặt các công cụ cần thiết
RUN apt-get update && apt-get install -y \
    bash \
    sudo \
    curl \
    wget \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Thiết lập người dùng root
USER root

# Thiết lập thư mục làm việc
WORKDIR /root

# Khởi động terminal
CMD ["bash"]
