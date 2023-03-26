import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi aplicación de inventarios',
      theme: ThemeData(
        primaryColor: Color(0xff0066cc),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          color: Color(0xff0066cc),
          actionsIconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: LoginScreen(), // Página de inicio ahora es la pantalla de login
    );
  }
}


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {
              // Acción del botón de ayuda
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  hintText: 'Nombre de usuario',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  hintText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Acción del botón de inicio de sesión
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text('Iniciar sesión'),
            ),
            TextButton(
              onPressed: () {
                // Acción del botón de olvido de contraseña
              },
              child: Text('¿Olvidaste tu contraseña?'),
            ),
          ],
        ),
      ),
    );
  }
}


class HomeScreen extends StatelessWidget {
  final List<String> _menuItems = [    'Inventarios',    'Proveedores',    'Ventas',  ];

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
            icon: Icon(Icons.person),
            onPressed: () {
              // Acceder al perfil del usuario
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: _menuItems.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return const DrawerHeader(
                child: Text('Elite Manager'),
              );
            }
            return ListTile(
              title: Text(_menuItems[index - 1]),
              onTap: () {
                Navigator.pop(context);
                // Navegar a la pantalla correspondiente
                if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InventoryScreen(),
                    ),
                  );
                } else if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProvidersScreen(),
                    ),
                  );
                } else if (index == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SalesScreen(),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.blue,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InventoryScreen(),
                    ),
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
            SizedBox(height: 10),
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.blue,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProvidersScreen(),
                    ),
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
            SizedBox(height: 10),
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.blue,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SalesScreen(),
                    ),
                  );
                },
                child: const Center(
                  child: Text(
                    'Ventas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
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


class InventoryScreen extends StatelessWidget {
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
            Icon(Icons.inventory, size: 50),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Acción del botón
              },
              child: Text('Gestion de productos'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Acción del botón
              },
              child: Text('Gestion de Insumos'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProvidersScreen extends StatelessWidget {
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

class SalesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ventas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart, size: 50),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Acción del botón
              },
              child: Text('Gestión de Clientes'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Acción del botón
              },
              child: Text('Gestión de Cotizaciones'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Acción del botón
              },
              child: Text('Gestión de ordenes de trabajo'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Acción del botón
              },
              child: Text('Gestión de ventas'),
            ),
          ],
        ),
      ),
    );
  }
}