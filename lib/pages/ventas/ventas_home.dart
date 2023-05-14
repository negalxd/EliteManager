import  'package:flutter/material.dart' ;
import 'package:elite_manager/widgets/cards.dart';


class SalesScreen extends StatelessWidget {
  const SalesScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ventas'),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardItem(
                title: 'Gestión de Clientes',
                imagePath: 'assets/gestionInvent.png',
                routeName: 'gestionClientes',
              ),
              const SizedBox(height: 10),
              CardItem(
                title: 'Gestión de Ordenes de Trabajo',
                imagePath: 'assets/gestionIns.png',
                routeName: 'gestionOrdenes',
              ),
              const SizedBox(height: 10),
              CardItem(
                title: 'Gestión de Ventas',
                imagePath: 'assets/gestionProd.png',
                routeName: 'gestionVentas',
              ),
            ],
          ),
        ),
      ),
    );
  }
}