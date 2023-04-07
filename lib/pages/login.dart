import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                Navigator.pushNamed( context, 'home'               
                );
              },
              child: const Text('Iniciar sesión'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'forgot_password'
                );
              },
              child: const Text('¿Olvidaste tu contraseña?'),
            ),
          ],
        ),
      ),
    );
  }
}