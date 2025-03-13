import 'package:flutter/material.dart';
import 'formulario_producto.dart';

class DetallesProductoScreen extends StatelessWidget {
  final Map<String, dynamic> producto;
  final Function actualizarProducto;
  final Function eliminarProducto;

  const DetallesProductoScreen({
    super.key,
    required this.producto,
    required this.actualizarProducto,
    required this.eliminarProducto,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(producto["nombre"])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Categoría: ${producto["categoria"]}", style: const TextStyle(fontSize: 18)),
            Text("Cantidad disponible: ${producto["cantidad"]}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text("Editar"),
                  onPressed: () {
                    mostrarFormularioProducto(context, actualizarProducto, producto: producto);
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.delete, color: Colors.white),
                  label: const Text("Eliminar"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    eliminarProducto(producto["id"]);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
