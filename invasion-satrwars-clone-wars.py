import json
import random
from PyQt5.QtWidgets import QApplication, QWidget, QVBoxLayout, QLabel, QListWidget, QPushButton, QLineEdit, QMessageBox, QListWidgetItem
from PyQt5.QtGui import QColor

class Card:
    def __init__(self, name, location, position="_"):
        self.name = name
        self.location = location
        self.position = position

class ColoredCardItem(QListWidgetItem):
    def __init__(self, text, color=QColor()):
        super().__init__(text)
        self.setForeground(color)

class CardManager:
    def __init__(self):
        self.pile = []
        self.discard_pile = []
        self.last_invasion_cards = []
        self.current_invasion = 0

    def add_card(self, name, location, position="_"):
        card = Card(name, location, position)
        self.pile.append(card)

    def invade(self, invasion):
        self.last_invasion_cards = []  # Reset the list for each invasion
        for _ in range(invasion):
            if self.pile:
                # Randomly select a card from the pile
                card = random.choice(self.pile)
                self.pile.remove(card)
                self.discard_pile.append(card)
                self.last_invasion_cards.append(card)
            else:
                QMessageBox.information(None, "No More Cards", "No more cards in the pile.")
                break

        self.current_invasion = invasion

    def save_to_json(self, filename, card_list):
        with open(filename, 'w') as json_file:
            json.dump([vars(card) for card in card_list], json_file)

    def load_from_json(self, filename):
        try:
            with open(filename, 'r') as json_file:
                data = json.load(json_file)
                return [Card(card_data['name'], card_data['location'], card_data.get('position')) for card_data in data]
        except FileNotFoundError:
            return []

    def load_default_pile(self, filename):
        # Clear existing lists before loading the default pile
        self.pile.clear()
        self.discard_pile.clear()

        default_pile = self.load_from_json(filename)
        self.pile.extend(default_pile)

    def clear_pile(self):
        self.pile.clear()

class CardManagerApp(QWidget):
    def __init__(self):
        super().__init__()

        self.card_manager = CardManager()

        self.init_ui()

    def init_ui(self):
        layout = QVBoxLayout()

        load_default_button = QPushButton("Load Default", self)
        load_default_button.clicked.connect(self.load_default_pile)
        layout.addWidget(load_default_button)

        label_pile = QLabel("Pile:")
        layout.addWidget(label_pile)

        self.list_pile = QListWidget()
        layout.addWidget(self.list_pile)

        label_discard_pile = QLabel("Discard Pile:")
        layout.addWidget(label_discard_pile)

        self.list_discard_pile = QListWidget()
        layout.addWidget(self.list_discard_pile)

        self.label_invasion = QLabel("Current Invasion: 0")
        layout.addWidget(self.label_invasion)

        self.invasion_input = QLineEdit(self)
        self.invasion_input.setPlaceholderText("Enter Invasion Number")
        layout.addWidget(self.invasion_input)

        invade_button = QPushButton("Invade", self)
        invade_button.clicked.connect(self.perform_invasion)
        layout.addWidget(invade_button)

        self.load_cards()

        self.setLayout(layout)
        self.setWindowTitle('PROTOTYPE of Invasion Card Manager : Starwars Clone Wars (pandemic)')
        self.show()

    def load_cards(self):
        self.list_pile.clear()
        self.list_discard_pile.clear()

        for card in self.card_manager.pile:
            self.list_pile.addItem(f"{card.name}, {card.location}, {card.position}")

        for card in self.card_manager.discard_pile:
            item = ColoredCardItem(f"{card.name}, {card.location}, {card.position}")

            send_back_button = QPushButton(f"{card.name}, {card.location}, {card.position} ", self)
            send_back_button.clicked.connect(lambda _, c=card: self.send_back_card(c))

            self.list_discard_pile.addItem(item)
            self.list_discard_pile.setItemWidget(item, send_back_button)

        # Color only the last invasion cards in green
        for item_index in range(self.list_discard_pile.count() - len(self.card_manager.last_invasion_cards), self.list_discard_pile.count()):
            item = self.list_discard_pile.item(item_index)
            if item:
                item.setForeground(QColor("green"))

        self.label_invasion.setText(f"Current Invasion: {self.card_manager.current_invasion}")

    def send_back_card(self, card):
        # Add logic to send the card back to the pile or perform any other action
        card.position = "TOP"
        self.card_manager.pile.append(card)
        self.card_manager.discard_pile.remove(card)
        self.update_lists()

    def perform_invasion(self):
        invasion_text = self.invasion_input.text()
        try:
            invasion = int(invasion_text)
        except ValueError:
            QMessageBox.warning(self, "Invalid Invasion", "Please enter a valid number for invasion.")
            return

        self.card_manager.invade(invasion)
        self.update_lists()

    def update_lists(self):
        self.list_pile.clear()
        self.list_discard_pile.clear()

        for card in self.card_manager.pile:
            self.list_pile.addItem(f"{card.name}, {card.location}, {card.position}")

        for card in self.card_manager.discard_pile:
            item = ColoredCardItem(f"{card.name}, {card.location}, {card.position}")

            send_back_button = QPushButton(f"{card.name}, {card.location}, {card.position} ", self)
            send_back_button.clicked.connect(lambda _, c=card: self.send_back_card(c))

            self.list_discard_pile.addItem(item)
            self.list_discard_pile.setItemWidget(item, send_back_button)

        # Color only the last invasion cards in green
        for item_index in range(self.list_discard_pile.count() - len(self.card_manager.last_invasion_cards), self.list_discard_pile.count()):
            item = self.list_discard_pile.item(item_index)
            if item:
                item.setForeground(QColor("green"))

        self.label_invasion.setText(f"Current Invasion: {self.card_manager.current_invasion}")

    def load_default_pile(self):
        # Load the default pile without affecting the discard pile
        self.card_manager.load_default_pile('default_pile.json')

        # Update the GUI
        self.update_lists()

if __name__ == '__main__':
    app = QApplication([])
    ex = CardManagerApp()
    app.exec_()
