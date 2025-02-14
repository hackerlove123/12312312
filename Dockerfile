# Sử dụng một base image có sẵn, ví dụ như jupyter/base-notebook
FROM jupyter/base-notebook:latest

# Cài đặt các gói cần thiết
RUN conda install -y -c conda-forge bash jupyter_contrib_nbextensions

# Cài đặt Jupyter Notebook extensions
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension

# Cài đặt thêm các gói khác nếu cần
# RUN apt-get update && apt-get install -y <package-name>

# Tạo một thư mục làm việc
WORKDIR /home/jovyan/work

# Copy các file cần thiết vào thư mục làm việc
COPY . /home/jovyan/work

# Thiết lập quyền truy cập
USER root
RUN chown -R jovyan:users /home/jovyan/work
USER jovyan

# Khởi động Jupyter Notebook
CMD ["jupyter", "notebook", "--ip", "0.0.0.0", "--port", "8888", "--no-browser", "--allow-root"]
