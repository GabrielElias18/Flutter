import 'package:flutter/material.dart';

void mostrarFormularioProducto(BuildContext context, Function guardarProducto, {Map<String, dynamic>? producto}) {
  TextEditingController nombreController = TextEditingController(text: producto?["nombre"] ?? "");
  TextEditingController cantidadController = TextEditingController(text: producto?["cantidad"]?.toString() ?? "");
  TextEditingController precioCompraController = TextEditingController(text: producto?["precioCompra"]?.toString() ?? "");
  TextEditingController precioVentaController = TextEditingController(text: producto?["precioVenta"]?.toString() ?? "");
  String categoriaSeleccionada = producto?["categoria"] ?? "Laptops";

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(producto == null ? "Crear Producto" : "Editar Producto"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nombreController, decoration: const InputDecoration(labelText: "Nombre")),
            TextField(controller: cantidadController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Cantidad")),
            TextField(controller: precioCompraController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Precio de compra")),
            TextField(controller: precioVentaController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Precio de venta")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(onPressed: () {
            final nuevoProducto = {
              "id": producto?["id"] ?? DateTime.now().millisecondsSinceEpoch,
              "nombre": nombreController.text,
              "cantidad": int.parse(cantidadController.text),
              "precioCompra": double.parse(precioCompraController.text),
              "precioVenta": double.parse(precioVentaController.text),
              "categoria": categoriaSeleccionada,
            };
            guardarProducto(nuevoProducto);
            Navigator.pop(context);
          }, child: const Text("Guardar")),
        ],
      );
    },
  );
}
