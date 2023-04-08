
import 'package:flutter/material.dart';

class ProductHomeScreen extends StatelessWidget {
  const ProductHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventarios'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.inventory, size: 50),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,'productospag');
              },
              child: const Text('Productos'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,'categorias');
              },
              child: const Text('Categorias'),
            ),
          ],
        ),
      ),
    );
  }
}
