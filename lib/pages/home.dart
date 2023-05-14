import 'package:flutter/material.dart';
import 'package:elite_manager/widgets/cards.dart';

class HomePage extends StatelessWidget {
  final List<String> _menuItems = [    'Inventarios',    'Proveedores',    'Ventas',  ];

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Dominó'),
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
      drawer: Drawer(
  child: Column(
    children: [
      SizedBox(
        height: 150,
        child: DrawerHeader(
          child: Image.asset('assets/elitelogo.png'),
        ),
      ),
      Expanded(
        child: ListView.builder(
            itemCount: _menuItems.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(_menuItems[index]),
                onTap: () {
                  Navigator.pop(context);
                  // Navegar a la pantalla correspondiente
                  if (index == 0) {
                    Navigator.pushNamed(
                      context,
                      'inventario',
                    );
                  } else if (index == 1) {
                    Navigator.pushNamed(
                      context,
                      'proveedores',
                    );
                  } else if (index == 2) {
                    Navigator.pushNamed(
                      context,
                      'ventas',
                    );
                  }
                },
              );
            }),
      ),
      const Divider(),
      ListTile(
      leading: const Icon(Icons.logout),
      title: const Text('Cerrar sesion'),
      iconColor: Colors.red,
      onTap: () {
        Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
      },
    ),

    ],
  ),
),
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardItem(
                title: 'Inventarios',
                imagePath: 'assets/gestionInvent.png',
                routeName: 'inventario',
              ),
              CardItem(
                title: 'Proveedores',
                imagePath: 'assets/gestionProd.png',
                routeName: 'proveedores',
              ),
              CardItem(
                title: 'Ventas',
                imagePath: 'assets/gestionIns.png',
                routeName: 'ventas',
              ),
            ],
          ),
        ),
      ),
    );
  }
}