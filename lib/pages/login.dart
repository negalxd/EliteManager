import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
        actions: [
          TextButton(
            child: const Text('Ayuda'),
            style: TextButton.styleFrom(
              primary: Color.fromARGB(255, 0, 0, 0),
            ), 
            onPressed: () {
              // Acción del botón de ayuda
            },
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
                  hintText: 'Nombre de usuario',
                  prefixIcon: Icon(Icons.person),
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
                  hintText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Acción del botón de inicio de sesión
                Navigator.pushNamed(context, 'home');
              },
              child: const Text('Iniciar sesión'),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 4, 75, 134),
                onPrimary: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                minimumSize: const Size(0, 50),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'forgot_password'
                );
              },
              child: const Text('¿Olvidaste tu contraseña?'),
              style: TextButton.styleFrom(
                primary: Color.fromARGB(255, 4, 75, 134),
              ),  
            ),
            const Expanded(child: SizedBox()),
            Align(
              alignment: Alignment.bottomCenter,
              child:
            Container(
              height: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/wave.png'),
                  fit: BoxFit.fitWidth,
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