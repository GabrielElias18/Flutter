import 'package:flutter/material.dart';
import 'detalles_producto_screen.dart';
import 'formulario_producto.dart';
import '../widgets/sidebar.dart';

class InventarioScreen extends StatefulWidget {
  const InventarioScreen({super.key});

  @override
  _InventarioScreenState createState() => _InventarioScreenState();
}

class _InventarioScreenState extends State<InventarioScreen> {
  List<Map<String, dynamic>> productos = [
    {"id": 1, "nombre": "Laptop Gamer", "cantidad": 10, "categoria": "Laptops", "precioCompra": 700, "precioVenta": 1000},
    {"id": 2, "nombre": "iPhone 14", "cantidad": 5, "categoria": "Celulares", "precioCompra": 800, "precioVenta": 1200},
  ];

  void agregarProducto(Map<String, dynamic> nuevoProducto) {
    setState(() {
      productos.add(nuevoProducto);
    });
  }

  void actualizarProducto(Map<String, dynamic> productoActualizado) {
    setState(() {
      int index = productos.indexWhere((p) => p["id"] == productoActualizado["id"]);
      if (index != -1) {
        productos[index] = productoActualizado;
      }
    });
  }

  void eliminarProducto(int id) {
    setState(() {
      productos.removeWhere((p) => p["id"] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inventario")),
      drawer: const Sidebar(),
      body: ListView.builder(
        itemCount: productos.length,
        itemBuilder: (context, index) {
          final producto = productos[index];
          return ListTile(
            title: Text(producto["nombre"]),
            subtitle: Text("Cantidad: ${producto["cantidad"]} - Precio Venta: \$${producto["precioVenta"]}"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetallesProductoScreen(
                    producto: producto,
                    actualizarProducto: actualizarProducto,
                    eliminarProducto: eliminarProducto,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mostrarFormularioProducto(context, agregarProducto);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
