import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';


class ProfileScreen extends StatefulWidget {
  final int? userId;

  const ProfileScreen({Key? key, this.userId}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = '';
  String _profileImageUrl = '';

  @override
  void initState() {
    super.initState();
    _getUserProfile();
  }

  Future<void> _getUserProfile() async {
    //shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    // print('$id');

    final profileResponse = await http.get(
      Uri.parse('http://192.168.1.4/Api/profiles/$id/'),
    );
    final profilenameResponse = await http.get(
      Uri.parse('http://192.168.1.4/Api/user/$id/'),
      headers: {'Authorization': 'Basic ${base64Encode(utf8.encode('negal:12345'))}'},
    );
    final data1 = json.decode(profilenameResponse.body);
    setState(() {
      _username = data1['username'];
    });

    final data2 = json.decode(profileResponse.body);
    if (data2 is Map) {
      final profileImageUrl = data2['image_profile']?.toString();
      if (profileImageUrl != null) {
        setState(() {
          _profileImageUrl = profileImageUrl;
        });
      } else {
        // Manejar el caso de error
        print('Error: la clave "image_profile" no existe en el mapa');
      }
    } else {
      // Manejar el caso de error
      print('Error: data2 no es un objeto');
    }
  }



@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Perfil'),
    ),
    body: 
    Center(
      child: 
      Column(
      children: [
        const SizedBox(height: 20),
        CircleAvatar(
          radius: 50,
          backgroundImage: _profileImageUrl.isNotEmpty
    ? NetworkImage('http://192.168.1.4/$_profileImageUrl')
    : const AssetImage('assets/defaultimage.png') as ImageProvider<Object>?,
        ),
        const SizedBox(height: 20),
        Text(
          _username,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    ),
  );
}

}



