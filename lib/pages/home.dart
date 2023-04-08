import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<String> _menuItems = [   'Inventarios',    'Proveedores',    'Ventas'  ];
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Completinis'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(
                      context,
                      'error');
                  }
          ),
        ],
      ),
drawer: Drawer(
  child: Column(
    children: [
      const DrawerHeader(
        child: Text('Elite Manager'),
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
                      'inventario');
                  } else if (index == 1) {
                    Navigator.pushNamed(
                      context,'proveedores');
                  } else if (index == 2) {
                    Navigator.pushNamed(
                      context,'ventas');
                  }
                },
              );
        }

        ),
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.logout),
        title: const Text('Cerrar sesion'),
        iconColor: Colors.red,
        onTap: () {
          Navigator.pushNamed(context,'login');
        },
      ),
    ],
  ),
),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,'inventario',
                  );
                },
                child: const Center(
                  child: Text(
                    'Inventarios',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 100,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,'proveedores'
                  );
                },
                child: const Center(
                  child: Text(
                    'Proveedores',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 100,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,'ventas'
                  );
                },
                child: const Center(
                  child: Text(
                    'Ventas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
