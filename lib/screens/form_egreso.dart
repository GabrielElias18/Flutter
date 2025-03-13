import 'package:flutter/material.dart';

class FormEgreso extends StatefulWidget {
  final List<Map<String, dynamic>> productos;

  const FormEgreso({super.key, required this.productos});

  @override
  _FormEgresoState createState() => _FormEgresoState();
}

class _FormEgresoState extends State<FormEgreso> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic>? productoSeleccionado;
  int cantidad = 0;
  double precioCompra = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Agregar Egreso"),
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
                  precioCompra = value?["precioCompra"] ?? 0;
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
              decoration: const InputDecoration(labelText: "Precio de Compra"),
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: precioCompra.toStringAsFixed(2)),
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
              final egreso = {
                "producto": productoSeleccionado!["nombre"],
                "cantidad": cantidad,
                "precioCompra": precioCompra,
                "total": cantidad * precioCompra,
              };
              Navigator.of(context).pop(egreso);
            }
          },
          child: const Text("Guardar"),
        ),
      ],
    );
  }
}
