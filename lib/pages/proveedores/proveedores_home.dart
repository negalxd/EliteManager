import 'package:flutter/material.dart';

class ProvidersScreen extends StatelessWidget {
  const ProvidersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proveedores'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_shipping, size: 50),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Acción del botón
              },
              child: const Text('Gestion de proveedores'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Acción del botón
              },
              child: const Text('Gestion de ordenes de compra'),
            ),
          ],
        ),
      ),
    );
  }
}