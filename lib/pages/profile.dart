import 'dart:convert';
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
    print(data1);

    
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
            margin: const EdgeInsets.symmetric(horizontal: 20),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                ClipOval(
                  child: Container(
                    width: 150,
                    height: 150,
                    child: _profileImageUrl.isNotEmpty
                        ? Image.network(
                            'http://${Configuracion.apiurl}/$_profileImageUrl',
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/defaultimage.png',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildInfoRow(Icons.person, 'Nombre de usuario', _username),
                      const SizedBox(height: 10),
                      _buildInfoRow(Icons.person_outline, 'Nombre', _name),
                      const SizedBox(height: 10),
                      _buildInfoRow(Icons.email, 'Correo electrónico', _email),
                    ],
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

Widget _buildInfoRow(IconData icon, String label, String value) {
  return Row(
    children: [
      Icon(icon, color: Color.fromRGBO(8, 76, 132, 1)),
      const SizedBox(width: 10),
      Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}
}



