FROM ubuntu:20.04

# 设置时区为Asia/Shanghai
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 安装必要的依赖
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-pyqt5 \
    libgl1-mesa-glx \
    xvfb

# 复制项目文件到容器中
COPY . /app
WORKDIR /app

#单独安装pyqt5
RUN apt-get update 
RUN apt install python3-pyqt5

# 安装Python依赖
RUN pip3 install -r requirements.txt

# 设置环境变量
ENV DISPLAY=:99

# 启动虚拟显示并运行项目
CMD ["xvfb-run", "python3", "RainClassroomAssistant.py"]
