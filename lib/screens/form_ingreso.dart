import 'package:flutter/material.dart';

class FormIngreso extends StatefulWidget {
  final List<Map<String, dynamic>> productos;

  const FormIngreso({super.key, required this.productos});

  @override
  _FormIngresoState createState() => _FormIngresoState();
}

class _FormIngresoState extends State<FormIngreso> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic>? productoSeleccionado;
  int cantidad = 0;
  double precioVenta = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Agregar Ingreso"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<Map<String, dynamic>>(
              decoration: const InputDecoration(labelText: "Producto"),
              items: widget.productos.map((producto) {
                return DropdownMenuItem(
                  value: producto,
                  child: Text(producto["nombre"]),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  productoSeleccionado = value;
                  precioVenta = value?["precioVenta"] ?? 0;
                });
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: "Cantidad"),
              keyboardType: TextInputType.number,
              onChanged: (value) => setState(() {
                cantidad = int.tryParse(value) ?? 0;
              }),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: "Precio de Venta"),
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: precioVenta.toStringAsFixed(2)),
              readOnly: true,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate() && productoSeleccionado != null) {
              final ingreso = {
                "producto": productoSeleccionado!["nombre"],
                "cantidad": cantidad,
                "precioVenta": precioVenta,
                "total": cantidad * precioVenta,
              };
              Navigator.of(context).pop(ingreso);
            }
          },
          child: const Text("Guardar"),
        ),
      ],
    );
  }
}
