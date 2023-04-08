import 'package:flutter/material.dart';

class ProvidersScreen extends StatelessWidget {
  const ProvidersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proveedores'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_shipping, size: 50),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Acción del botón
              },
              child: Text('Gestion de proveedores'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Acción del botón
              },
              child: Text('Gestion de ordenes de compra'),
            ),
          ],
        ),
      ),
    );
  }
}