#to launch me : python3 timer_widget.pyfrom PyQt5 import QtCore
import sys
from PyQt5.QtWidgets import QApplication, QWidget, QLabel, QHBoxLayout, QPushButton, QProgressBar
from PyQt5.QtCore import Qt, QPoint
import subprocess

class TimerWidget(QWidget):
    def __init__(self):
        super().__init__()

        self.initUI()
        self.dragging = False

    def initUI(self):
        
        self.setFixedSize(200, 35)
        self.setAttribute(Qt.WA_TranslucentBackground, True)
        #self.setWindowOpacity(0.6);

        self.setWindowFlags(Qt.WindowMinMaxButtonsHint | Qt.WindowCloseButtonHint | Qt.WindowStaysOnTopHint)
        
        
        self.setGeometry(100, 100, 300, 150)
        self.setWindowFlags(Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint)

        self.timer_label = QLabel('Click go')
        self.timer_label.setStyleSheet('font-size: 14pt')
        self.timer_button = QPushButton('go')
        self.timer_button.setStyleSheet('background-color: transparent;border: 0px solid grey;')
        self.timer_button.clicked.connect(self.start_timer)

        self.progress_bar = QProgressBar(self)
        self.progress_bar.setStyleSheet("""
            QProgressBar {
                border: 1px solid grey;
                border-radius: 5px;
                background-color: transparent;
                color:green;
            }
            QProgressBar::chunk {
                background-color: green;
                width: 1px;
            }
            
        """)

        self.timer_duration = 20
        self.progress_bar.setMaximum(self.timer_duration)
        self.progress_bar.setValue(0)

        layout = QHBoxLayout()
        layout.addWidget(self.timer_label)

        layout.addWidget(self.progress_bar)
        layout.addWidget(self.timer_button)
        self.setLayout(layout)



    def start_timer(self):
        self.timer = QtCore.QTimer()
        self.timer.timeout.connect(self.update_timer)
        self.timer.start(10000) # update every 10 second
        self.remaining_time = self.timer_duration # seconds
        self.current_time = 0 # seconds
        self.timer_label.setText(f'running')


    def update_timer(self):
        self.remaining_time -= 1
        self.current_time += 1
        self.progress_bar.setValue(self.current_time)
        
        if self.remaining_time > 0:
            self.timer_label.setText(f'{self.remaining_time} / {self.timer_duration}')
            self.setWindowTitle(f'{self.remaining_time} / {self.timer_duration}')
        else:
            self.timer_label.setText('Timer expired')
            self.timer.stop()
            subprocess.run(['notify-send', 'NOUVEAU', 'SUJET ;)'])
            # Perform action here, such as displaying a message or running a command
            self.remaining_time = self.timer_duration
            self.current_time = 0
            self.timer.start()

    def mousePressEvent(self, event):
        if event.button() == Qt.LeftButton:
            self.dragging = True
            self.offset = event.pos()

    def mouseMoveEvent(self, event):
        if self.dragging:
            self.move(self.pos() + event.pos() - self.offset)

    def mouseReleaseEvent(self, event):
        if event.button() == Qt.LeftButton:
            self.dragging = False

if __name__ == '__main__':
    app = QApplication(sys.argv)
    widget = TimerWidget()
    widget.show()
    sys.exit(app.exec_())
