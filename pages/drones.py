import tkinter as tk
from main import LARGE_FONT

class Drones(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="Drones Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)

class AddDrone(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="Add Drone Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)

class RepairRefuelDrone(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="Repair/Refuel Drone Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)

class RemoveDrone(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="Remove Drone Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)
