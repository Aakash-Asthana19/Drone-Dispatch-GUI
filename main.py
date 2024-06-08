import tkinter as tk
from tkinter import ttk
from tkinter import messagebox, simpledialog
import mysql.connector

from pages.start_page import StartPage
from pages.customers import Customers, AddCustomer, IncreaseCustomerCredit, RemoveCustomer
from pages.products import Products, AddProduct, RemoveProduct
from pages.drones import Drones, AddDrone, RepairRefuelDrone, RemoveDrone
from pages.pilots import Pilots, AddDronePilot, RemoveDronePilot
from pages.orders import Orders, AddOrderLine, BeginOrder, CancelOrder, DeliverOrder, SwapDroneControl
from pages.views import Views, SQLTableViewerDPR, SQLTableViewerCCC, SQLTableViewerDTC, SQLTableViewerMPP, SQLTableViewerOIP, SQLTableViewerRD, SQLTableViewerSSO

LARGE_FONT = ("Verdana", 12)

class Phase4(tk.Tk):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        container = tk.Frame(self)
        container.pack(side="top", fill="both", expand=True)
        container.grid_rowconfigure(0, weight=1)
        container.grid_columnconfigure(0, weight=1)

        self.frames = {}
        for F in (StartPage, Customers, Products, Drones, Pilots, Orders, Views,
                  AddCustomer, IncreaseCustomerCredit, RemoveCustomer, AddProduct, RemoveProduct,
                  AddDrone, RepairRefuelDrone, RemoveDrone, AddDronePilot, AddOrderLine,
                  BeginOrder, CancelOrder, DeliverOrder, SwapDroneControl, RemoveDronePilot, 
                  SQLTableViewerDPR, SQLTableViewerCCC, SQLTableViewerDTC, SQLTableViewerMPP, 
                  SQLTableViewerOIP, SQLTableViewerRD, SQLTableViewerSSO):
            frame = F(container, self)
            self.frames[F] = frame
            frame.grid(row=0, column=0, sticky="nsew")
            frame.geometry = ("300x300")

        self.show_frame(StartPage)

    def show_frame(self, cont):
        frame = self.frames[cont]
        frame.tkraise()

if __name__ == "__main__":
    app = Phase4()
    app.mainloop()
