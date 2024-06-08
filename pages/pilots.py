import tkinter as tk
from main import LARGE_FONT

class Pilots(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="Pilots Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)

class AddDronePilot(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="Add Drone Pilot Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)

class RemoveDronePilot(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="Remove Drone Pilot Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)
