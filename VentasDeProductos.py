import tkinter as tk
from tkinter import ttk
from tkinter import messagebox
import re

class VentaProductosApp:
    def __init__(self, master):
        self.master = master
        self.master.title("Sistema de Venta de Productos")
        
        self.productos = {
            "Camiseta": 15.99,
            "Pantalones": 29.99,
            "Zapatos": 49.99,
            "Gorra": 9.99
        }

        # Stock inicial de productos
        self.stock = {
            producto: 10 for producto in self.productos
        }

        self.carrito = {}
        self.botones_eliminar = {}
        
        style = ttk.Style()
        style.theme_use("clam")  # Cambia el tema a "clam"

        self.label_producto = ttk.Label(master, text="Producto:")
        self.label_producto.grid(row=0, column=0)
        
        self.producto_var = tk.StringVar()
        self.producto_var.set("Camiseta")
        self.producto_menu = ttk.Combobox(master, textvariable=self.producto_var, values=list(self.productos.keys()))
        self.producto_menu.grid(row=0, column=1)
        
        self.label_cantidad = ttk.Label(master, text="Cantidad:")
        self.label_cantidad.grid(row=1, column=0)
        
        self.cantidad_var = tk.StringVar()
        self.cantidad_var.set("1")
        self.cantidad_entry = ttk.Entry(master, textvariable=self.cantidad_var)
        self.cantidad_entry.grid(row=1, column=1)
        
        self.agregar_button = ttk.Button(master, text="Agregar al carrito", command=self.agregar_carrito)
        self.agregar_button.grid(row=2, columnspan=2)
        
        self.label_carrito = ttk.Label(master, text="Carrito:")
        self.label_carrito.grid(row=3, columnspan=2)
        
        self.carrito_text = tk.Text(master, height=10, width=40)
        self.carrito_text.grid(row=4, columnspan=2)
        
        self.generar_factura_button = ttk.Button(master, text="Generar Factura", command=self.generar_factura)
        self.generar_factura_button.grid(row=5, columnspan=2)
        
        self.total_label = ttk.Label(master, text="Total:")
        self.total_label.grid(row=6, column=0)
        
        self.total_var = tk.StringVar()
        self.total_var.set("$0.00")
        self.total_label_valor = ttk.Label(master, textvariable=self.total_var)
        self.total_label_valor.grid(row=6, column=1)
        
        self.ver_stock_button = ttk.Button(master, text="Ver Stock", command=self.ver_stock)
        self.ver_stock_button.grid(row=7, columnspan=2)
        
    def agregar_carrito(self):
        producto = self.producto_var.get()
        cantidad = self.cantidad_var.get()
        
        if not re.match(r'^\d+$', cantidad):
            messagebox.showerror("Error", "La cantidad debe ser un número entero positivo.")
            return
        
        cantidad = int(cantidad)
        if cantidad <= 0:
            messagebox.showerror("Error", "La cantidad debe ser un número entero positivo.")
            return
        
        if cantidad > self.stock[producto]:
            messagebox.showerror("Error", f"No hay suficiente stock disponible. Stock actual: {self.stock[producto]}")
            return
        
        if producto in self.carrito:
            self.carrito[producto] += cantidad
        else:
            self.carrito[producto] = cantidad
        
        self.stock[producto] -= cantidad  # Actualizar el stock disponible
        self.actualizar_carrito()
        
    def actualizar_carrito(self):
        self.carrito_text.delete('1.0', tk.END)
        total = 0
        for producto, cantidad in self.carrito.items():
            precio = self.productos[producto]
            total += precio * cantidad
            self.carrito_text.insert(tk.END, f"{producto}: {cantidad} x ${precio:.2f}\n")
            if producto not in self.botones_eliminar:
                self.botones_eliminar[producto] = ttk.Button(self.master, text="Eliminar", command=lambda prod=producto: self.eliminar_del_carrito(prod))
                self.botones_eliminar[producto].grid(row=len(self.botones_eliminar)+4, column=0)
        self.total_var.set(f"${total:.2f}")
        
    def eliminar_del_carrito(self, producto):
        cantidad = self.carrito[producto]
        del self.carrito[producto]
        self.stock[producto] += cantidad
        self.actualizar_carrito()
        
    def generar_factura(self):
        if not self.carrito:
            messagebox.showerror("Error", "El carrito está vacío. Agrega productos antes de generar una factura.")
            return
        
        factura = "Factura\n\n"
        total = 0
        for producto, cantidad in self.carrito.items():
            precio = self.productos[producto]
            subtotal = precio * cantidad
            factura += f"{producto}: {cantidad} x ${precio:.2f} = ${subtotal:.2f}\n"
            total += subtotal
        factura += f"\nTotal: ${total:.2f}"
        
        # Actualizar el stock y limpiar el carrito
        for producto, cantidad in self.carrito.items():
            self.stock[producto] -= cantidad
        self.carrito = {}
        self.actualizar_carrito()  # Actualizar la interfaz
        
        messagebox.showinfo("Factura Generada", factura)
        
    def ver_stock(self):
        stock_window = tk.Toplevel(self.master)
        stock_window.title("Stock de Productos")
        
        stock_text = tk.Text(stock_window, height=10, width=40)
        stock_text.pack()
        
        for producto, cantidad in self.stock.items():
            stock_text.insert(tk.END, f"{producto}: {cantidad}\n")

def main():
    root = tk.Tk()
    app = VentaProductosApp(root)
    root.mainloop()

if __name__ == "__main__":
    main()