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
      appBar: AppBar(
        title: const Text(
          "Balance",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 5,
      ),
      drawer: const Sidebar(),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blueGrey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            _buildBotonesSuperior(),
            Expanded(child: mostrarIngresos ? _buildIngresos() : _buildEgresos()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (mostrarIngresos) {
            _mostrarFormularioIngreso(context);
          } else {
            _mostrarFormularioEgreso(context);
          }
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildBotonesSuperior() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => setState(() => mostrarIngresos = true),
          style: ElevatedButton.styleFrom(
            backgroundColor: mostrarIngresos ? Colors.blue : Colors.grey[300],
            foregroundColor: mostrarIngresos ? Colors.white : Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: const Text("Ingresos"),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () => setState(() => mostrarIngresos = false),
          style: ElevatedButton.styleFrom(
            backgroundColor: !mostrarIngresos ? Colors.blue : Colors.grey[300],
            foregroundColor: !mostrarIngresos ? Colors.white : Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
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
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  title: Text(
                    ingreso["producto"],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Cantidad: ${ingreso["cantidad"]} - Total: \$${ingreso["total"]}",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  leading: const Icon(Icons.attach_money, color: Colors.green),
                ),
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
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  title: Text(
                    egreso["producto"],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Cantidad: ${egreso["cantidad"]} - Total: \$${egreso["total"]}",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  leading: const Icon(Icons.money_off, color: Colors.red),
                ),
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
