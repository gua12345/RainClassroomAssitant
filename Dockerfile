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
    xvfb \
    tigervnc-standalone-server \
    tigervnc-common \
    git \
    wget

# 复制项目文件到容器中
COPY . /app
WORKDIR /app

# 安装Python依赖
RUN pip3 install -r requirements.txt

# 下载并配置 noVNC
RUN git clone https://github.com/novnc/noVNC.git /opt/noVNC \
    && git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify \
    && ln -s /opt/noVNC/vnc.html /opt/noVNC/index.html

# 设置 VNC 密码
RUN mkdir -p ~/.vnc \
    && echo "yourpassword" | vncpasswd -f > ~/.vnc/passwd \
    && chmod 600 ~/.vnc/passwd

# 启动脚本
COPY startup.sh /opt/startup.sh
RUN chmod +x /opt/startup.sh

# 暴露端口
EXPOSE 5901 6080

# 启动 VNC 和 noVNC
CMD ["/opt/startup.sh"]
