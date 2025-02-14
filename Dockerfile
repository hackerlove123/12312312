# Sử dụng base image có sẵn từ Jupyter
FROM jupyter/base-notebook:latest

# Cài đặt các dependencies cần thiết
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    git \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Cài đặt Visual Studio Code Server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Cấu hình để chạy code-server khi khởi động
RUN mkdir -p /home/jovyan/.local/share/code-server
COPY start-code-server.sh /usr/local/bin/start-code-server.sh
RUN chmod +x /usr/local/bin/start-code-server.sh

# Cấu hình JupyterLab để chạy code-server
RUN pip install jupyter-server-proxy
RUN jupyter labextension install @jupyterlab/server-proxy

# Tạo một script để khởi động code-server
RUN echo '#!/bin/bash\n\
code-server --auth none --bind-addr 0.0.0.0:8080 /home/jovyan/work\n\
' > /usr/local/bin/start-code-server.sh && \
    chmod +x /usr/local/bin/start-code-server.sh

# Thiết lập quyền cho user jovyan
USER jovyan

# Expose cổng 8080 cho code-server
EXPOSE 8080

# Khởi động JupyterLab và code-server
CMD ["start-code-server.sh"]
