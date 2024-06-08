import tkinter as tk
from main import LARGE_FONT

class Products(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="Products Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)

class AddProduct(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="Add Product Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)

class RemoveProduct(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="Remove Product Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)
