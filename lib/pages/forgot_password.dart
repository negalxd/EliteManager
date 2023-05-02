import 'dart:convert';
import 'config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

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
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  hintText: 'Correo electrónico',
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _isLoading ? null : _sendResetPasswordEmail,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Enviar correo'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendResetPasswordEmail() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      _showSnackbar('Debes ingresar un correo electrónico');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('http://${Configuracion.apiurl}/Api/reset-password/');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': email});

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        _showSnackbar('Se ha enviado un correo con las instrucciones para restablecer tu contraseña.');
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        _showSnackbar('Error al enviar correo. Intenta de nuevo más tarde.');
      }
    } catch (e) {
      _showSnackbar('Error al enviar correo. Intenta de nuevo más tarde.');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}