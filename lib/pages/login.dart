import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: const Text('Login'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 0, 0, 0),
            ), 
            onPressed: () {
              // Acción del botón de ayuda
            },
            child: const Text('Ayuda'),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            const Text(
              'Iniciar sesión',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ), 
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.all(10),
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 4, 75, 134)),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  labelText: 'Nombre de usuario',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 4, 75, 134)),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 4, 75, 134)),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 4, 75, 134)),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Acción del botón de inicio de sesión
                Navigator.pushNamed(context, 'home');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 4, 75, 134),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                minimumSize: const Size(0, 50),
              ),
              child: const Text('Iniciar sesión'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'forgot_password'
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 4, 75, 134),
              ),
              child: const Text('¿Olvidaste tu contraseña?'),  
            ),
            const Expanded(child: SizedBox()),
            Align(
              alignment: Alignment.bottomCenter,
              child:
            Container(
              height: 180,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/wave.png'),
                  fit: BoxFit.fitHeight,
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