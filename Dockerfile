FROM ubuntu:latest

# Cập nhật hệ thống và cài đặt Jupyter
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    jupyter \
    && rm -rf /var/lib/apt/lists/*

# Tạo thư mục làm việc và cấp quyền full
RUN mkdir -p /workspace && chmod -R 777 /workspace

# Thiết lập thư mục làm việc
WORKDIR /workspace

# Sao chép script khởi động
COPY start.sh /workspace/start.sh
RUN chmod +x /workspace/start.sh

# Chạy script khởi động
CMD ["/workspace/start.sh"]
