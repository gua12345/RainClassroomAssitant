import sys
from PyQt5 import QtWidgets, QtCore
from UI.MainWindow import MainWindow_Ui
from UI.MainWindow import MainWindow_Ui
from Scripts.Send import send_group_message

def close_app():
    QtWidgets.QApplication.quit()

if __name__ == "__main__":
    # 初始化
    app = QtWidgets.QApplication(sys.argv)
    main = QtWidgets.QMainWindow()
    ui = MainWindow_Ui()
    ui.setupUi(main)
    main.show()
    # 启动监听
    ui.active()
    send_group_message("摸鱼助手监听启动成功") 
    # 设置定时器，105分钟后关闭应用程序
    timer = QtCore.QTimer()
    timer.timeout.connect(close_app)
    timer.start(105 * 60 * 1000)  # 100分钟转换为毫秒
    send_group_message( "摸鱼助手启动成功")
    # 主窗体循环
    app.exec_()
