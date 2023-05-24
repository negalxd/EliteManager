import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const HelpScreen({Key? key});

  final String phoneNumber = '+56942042069';
  final String email = 'EliteManager@soporte.com';
  final String adminName = 'Elite Manager Team';

  void openYT() async {
    const youtubeUrl = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ';
    final uri = Uri.parse(youtubeUrl);
    await launchUrl(uri);
}

  void sendEmail() async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: email,
  );
  await launchUrl(emailLaunchUri);
}

  _launchPhone() async {
  const phoneNumber = '+56942042069';
  //abrira la aplicacion de llamadas
  final Uri phoneLaunchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(phoneLaunchUri);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayuda'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/elitelogo.png',
              fit: BoxFit.fitHeight,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(adminName),
                      trailing: const SizedBox(
                        width: 30,
                        height: 30,
                        child: Icon(Icons.touch_app),
                      ),
                      onTap: openYT,
                    ),
                    ListTile(
                    leading: const Icon(Icons.email),
                    title: Text(email),
                    trailing: const SizedBox(
                      width: 30,
                      height: 30,
                      child: Icon(Icons.touch_app),
                    ),
                    onTap: sendEmail,
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: Text(phoneNumber),
                    trailing: const SizedBox(
                      width: 30,
                      height: 30,
                      child: Icon(Icons.touch_app),
                    ),
                    onTap: _launchPhone,
                  ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
