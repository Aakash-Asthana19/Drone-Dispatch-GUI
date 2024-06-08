import tkinter as tk
from main import LARGE_FONT

class Views(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="Views Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)

class SQLTableViewerDPR(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="SQL Table Viewer DPR Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)

class SQLTableViewerCCC(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="SQL Table Viewer CCC Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)

class SQLTableViewerDTC(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="SQL Table Viewer DTC Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)

class SQLTableViewerMPP(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="SQL Table Viewer MPP Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)

class SQLTableViewerOIP(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="SQL Table Viewer OIP Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)

class SQLTableViewerRD(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="SQL Table Viewer RD Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)

class SQLTableViewerSSO(tk.Frame):
    def __init__(self, parent, controller):
        super().__init__(parent)
        label = tk.Label(self, text="SQL Table Viewer SSO Page", font=LARGE_FONT)
        label.pack(pady=10, padx=10)
