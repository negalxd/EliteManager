import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const url = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ';
    final uri = Uri.parse(url);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('¡Lo siento, ha ocurrido un error!'),
            const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  launchUrl(uri);
                },
                child: const Text('Ver solución'),
              ),
          ],
        ),
      ),
    );
  }
}