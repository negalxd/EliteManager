import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Olvidaste tu contraseña'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  hintText: 'Correo electrónico',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Acción del botón de enviar correo
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title:const Text('Correo enviado'),
                      content:const Text('Se ha enviado un correo con las instrucciones para restablecer tu contraseña.'),
                      actions: <Widget>[
                        TextButton(
                          child:const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child:const Text('Enviar correo'),
            ),
          ],
        ),
      ),
    );
  }
}