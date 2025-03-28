import 'package:flutter/material.dart';
import 'screens/login.dart';
// Importamos la pantalla de inventario

void main() {
  runApp(const InventarioApp());
}

class InventarioApp extends StatelessWidget {
  const InventarioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(), // Usamos el widget importado
    );
  }
}
