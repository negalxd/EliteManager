import 'dart:convert';
import 'package:elite_manager/theme/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:elite_manager/pages/config.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileScreen extends StatefulWidget {
  final int? userId;

  const ProfileScreen({Key? key, this.userId}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = '';
  String _name = '';
  String _email = '';
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
      Uri.parse('http://${Configuracion.apiurl}/Api/profiles/$id/')
    );
    final profilenameResponse = await http.get(
      Uri.parse('http://${Configuracion.apiurl}/Api/user/$id/'),
      headers: {'Authorization': 'Basic ${base64Encode(utf8.encode(Configuracion.superuser))}'},
    );
    const utf8decoder = Utf8Decoder();
    // decodificar con utf8.decode
    final data1 = json.decode(utf8decoder.convert(profilenameResponse.bodyBytes));

    
    setState(() {
      _username = data1['username'];
      //comprobar si el nombre está vacío
      if (data1['first_name'] == '' || data1['last_name'] == '') {
        _name = 'Sin nombre';
      } else {
        _name = '${data1['first_name']} ${data1['last_name']}';
      }
      //comprobar si el correo está vacío
      if (data1['email'] == '') {
        _email = 'Sin correo';
      } else {
        _email = '${data1['email']}';
      }
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
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Card(
            margin: const EdgeInsets.all(10),
            color: Colors.white,
            elevation: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 150,
                  backgroundImage: _profileImageUrl.isNotEmpty
                      ? NetworkImage('http://${Configuracion.apiurl}/$_profileImageUrl')
                      : const AssetImage('assets/defaultimage.png') as ImageProvider<Object>?,
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _username,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _name,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _email,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}





}



