import 'package:flutter/material.dart';
import 'package:elite_manager/widgets/cards.dart';

class ProvidersScreen extends StatelessWidget {
  const ProvidersScreen({super.key});
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proveedores'),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardItem(
                title: 'Gestión de proveedores',
                imagePath: 'assets/gestionProd.png',
                routeName: 'listaprov',
              ),
              CardItem(
                title: 'Gestión de órdenes de compra',
                imagePath: 'assets/gestionIns.png',
                routeName: 'ordenescompra',
              ),
            ],
          ),
        ),
      ),
    );
  }
}


