import tkinter as tk
from main import LARGE_FONT
from pages.customers import Customers
from pages.products import Products
from pages.drones import Drones

class StartPage(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="Drone Dispatch System", font=LARGE_FONT)
        label.pack(pady=10, padx=10)

        button1 = tk.Button(self, text="Customers", command=lambda: controller.show_frame(Customers))
        button1.pack()

        button2 = tk.Button(self, text="Products", command=lambda: controller.show_frame(Products))
        button2.pack()

        button3 = tk.Button(self, text="Drones", command=lambda: controller.show_frame(Drones))
        button3.pack()
