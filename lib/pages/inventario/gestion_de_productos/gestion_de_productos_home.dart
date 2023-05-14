import 'package:flutter/material.dart';
import 'package:elite_manager/widgets/cards.dart';


class ProductHomeScreen extends StatelessWidget {
  const ProductHomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Gestión de Productos'),
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
                title: 'Productos',
                imagePath: 'assets/gestionProd.png',
                routeName: 'productospag',
              ),
              CardItem(
                title: 'Categorias',
                imagePath: 'assets/gestionIns.png',
                routeName: 'categorias',
              ),
            ],
          ),
        ),
      ),
    );
  }
}