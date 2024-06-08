import tkinter as tk
from main import LARGE_FONT

class Customers(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="Customers Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)

class AddCustomer(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="Add Customer Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)

class IncreaseCustomerCredit(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="Increase Customer Credit Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)

class RemoveCustomer(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="Remove Customer Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)
