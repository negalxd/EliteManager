import 'package:flutter/material.dart';

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
            Text('Completinis'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, 'error');
            },
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
                Navigator.pushNamed(context, 'login');
              },
            ),
          ],
        ),
      ),
      body: Center(
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
    );
  }
}

class CardItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final String routeName;

  CardItem({required this.title, required this.imagePath, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Card(
        child: Container(
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      ' ',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        clipBehavior: Clip.antiAlias,
      ),
    );
  }
}
