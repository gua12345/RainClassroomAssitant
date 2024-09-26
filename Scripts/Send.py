from flask import Flask, request
import requests

app = Flask(__name__)

# 添加GET路由
@app.route('/', methods=['GET'])
def home():
    return "Hello, this is your QQ bot!"

# NapCatQQ API的基础URL
base_url = "http://服务器ip:3000"

# 发送群聊消息的函数
def send_group_message(message):
    url = f"{base_url}/send_group_msg"
    params = {
        "group_id": qq群号,
        "message": message,
        "access_token":"你的access_token"
    }
    response = requests.get(url, params=params)

    if response.status_code == 200:
        print("Message sent successfully")
    else:
        print("Failed to send message")
        print(response.status_code, response.text)

