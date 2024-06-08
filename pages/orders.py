import tkinter as tk
from main import LARGE_FONT

class Orders(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="Orders Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)

class AddOrderLine(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="Add Order Line Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)

class BeginOrder(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="Begin Order Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)

class CancelOrder(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="Cancel Order Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)

class DeliverOrder(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="Deliver Order Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)

class SwapDroneControl(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="Swap Drone Control Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)
