import 'package:flutter/material.dart';
import 'screens/inventario_screen.dart'; // Importamos la pantalla de inventario

void main() {
  runApp(const InventarioApp());
}

class InventarioApp extends StatelessWidget {
  const InventarioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: InventarioScreen(), // Usamos el widget importado
    );
  }
}
