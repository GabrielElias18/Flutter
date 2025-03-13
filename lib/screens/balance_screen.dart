import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import 'form_ingreso.dart';
import 'form_egreso.dart';
import 'inventario_screen.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  _BalanceScreenState createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  List<Map<String, dynamic>> ingresos = [];
  List<Map<String, dynamic>> egresos = [];
  bool mostrarIngresos = true;

  // Usar los productos desde InventarioScreen
  final List<Map<String, dynamic>> productos = InventarioScreen().createState().productos;

  void agregarIngreso(Map<String, dynamic> ingreso) {
    setState(() {
      ingresos.add(ingreso);
    });
  }

  void agregarEgreso(Map<String, dynamic> egreso) {
    setState(() {
      egresos.add(egreso);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Balance")),
      drawer: const Sidebar(),
      body: Column(
        children: [
          _buildBotonesSuperior(),
          Expanded(child: mostrarIngresos ? _buildIngresos() : _buildEgresos()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (mostrarIngresos) {
            _mostrarFormularioIngreso(context);
          } else {
            _mostrarFormularioEgreso(context);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBotonesSuperior() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => setState(() => mostrarIngresos = true),
          child: const Text("Ingresos"),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () => setState(() => mostrarIngresos = false),
          child: const Text("Egresos"),
        ),
      ],
    );
  }

  Widget _buildIngresos() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Ingresos", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: ingresos.length,
            itemBuilder: (context, index) {
              final ingreso = ingresos[index];
              return ListTile(
                title: Text(ingreso["producto"]),
                subtitle: Text("Cantidad: ${ingreso["cantidad"]} - Total: \$${ingreso["total"]}"),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEgresos() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Egresos", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: egresos.length,
            itemBuilder: (context, index) {
              final egreso = egresos[index];
              return ListTile(
                title: Text(egreso["producto"]),
                subtitle: Text("Cantidad: ${egreso["cantidad"]} - Total: \$${egreso["total"]}"),
              );
            },
          ),
        ),
      ],
    );
  }

  void _mostrarFormularioIngreso(BuildContext context) async {
    final resultado = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => FormIngreso(productos: productos),
    );
    if (resultado != null) {
      agregarIngreso(resultado);
    }
  }

  void _mostrarFormularioEgreso(BuildContext context) async {
    final resultado = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => FormEgreso(productos: productos),
    );
    if (resultado != null) {
      agregarEgreso(resultado);
    }
  }
}
