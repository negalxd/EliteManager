import 'package:flutter/material.dart';
import 'package:elite_manager/widgets/cards.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Inventarios'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, 'profile');
            },
          ),
        ],
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardItem(
                title: 'Gestion de productos',
                imagePath: 'assets/gestionProd.png',
                routeName: 'productoshome',
              ),
              CardItem(
                title: 'Gestion de Insumos',
                imagePath: 'assets/gestionIns.png',
                routeName: 'insumoslist',
              ),
            ],
          ),
        ),
      ),
    );
  }
}