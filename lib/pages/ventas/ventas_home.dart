import  'package:flutter/material.dart' ;

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ventas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_cart, size: 50),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Acción del botón
              },
              child: const Text('Gestión de Clientes'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Acción del botón
              },
              child: const Text('Gestión de Cotizaciones'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Acción del botón
              },
              child: const Text('Gestión de ordenes de trabajo'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Acción del botón
              },
              child: const Text('Gestión de ventas'),
            ),
          ],
        ),
      ),
    );
  }
}