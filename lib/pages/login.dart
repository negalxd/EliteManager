import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wave/wave.dart';
import 'package:wave/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:elite_manager/pages/config.dart';

class Usuario {
  String username;
  String password;
  String token;

  Usuario({
    required this.username,
    required this.password,
    required this.token,
  });

  factory Usuario.fromJson(Map json) {
    return Usuario(
      username: json["username"],
      password: json["password"],
      token: json["token"],
    );
  }
}

class LoginPage extends StatefulWidget {
   const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;

  //final urllogin = Uri.parse("http://192.168.1.108/api/login/");
  final urllogin = Uri.http(Configuracion.apiurl, Configuracion.loginAPI);

  //final urlobtenertoken = Uri.parse("http://192.168.1.108/api/api-token-auth/");
  final urlobtenertoken = Uri.http(Configuracion.apiurl, Configuracion.obtenertokenAPI);
  final headers = {"Content-Type": "application/json;charset=UTF-8"};


@override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Image.asset(
          'assets/elitelogo.png',
          height: kToolbarHeight * 0.8,
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 0, 0, 0),
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'help');
            },
            child: const Text('Ayuda'),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [Colors.blue, Colors.lightBlue.shade200],
                    [Colors.blue.shade800, Colors.lightBlue.shade400],
                  ],
                  durations: [35000, 19440],
                  heightPercentages: [0.8, 0.87],
                  blur: const MaskFilter.blur(BlurStyle.solid, 5),
                ),
                waveAmplitude: 20,
                size: const Size(
                  double.infinity,
                  double.infinity,
                ),
              ),
            ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //centrar el titulo
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Iniciar sesión',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
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
                    child: TextField(
                      obscureText: _isObscure,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color.fromARGB(255, 4, 75, 134)),
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                        ),
                        labelText: 'Contraseña',
                        labelStyle: const TextStyle(color: Color.fromARGB(255, 4, 75, 134)),
                        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 4, 75, 134),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                minimumSize: const Size(0, 50),
              ),
              child: const Text('Iniciar sesión'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'forgot_password');
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 4, 75, 134),
              ),
              child: const Text('¿Olvidaste tu contraseña?'),
            ),
            ],
          ),
        ),
      ),
    ],  
    ),
);  
}




  void showSnackbar(String msg) {
  final snack = SnackBar(
    content: Text(msg),
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snack);
}


  Future<void> login() async {
    if (nameController.text.isEmpty || passwordController.text.isEmpty) {
      showSnackbar(
          "${nameController.text.isEmpty ? "Usuario" : ""} ${passwordController.text.isEmpty ? "Contraseña" : ""} requerido");
      return;
    }
    final datosdelposibleusuario = {
      "username": nameController.text,
      "password": passwordController.text
    };
    final res = await http.post(urllogin,
        headers: headers, body: jsonEncode(datosdelposibleusuario));
    final data = Map.from(jsonDecode(res.body));
    if (res.statusCode == 400) {
      showSnackbar("error");
      return;
    }
    if (res.statusCode != 200) {
      showSnackbar("Ha habido un error al obtener usuario y contraseña");
      return;
    }
    final res2 = await http.post(urlobtenertoken,
        headers: headers, body: jsonEncode(datosdelposibleusuario));
    final data2 = jsonDecode(res2.body);
    if (res2.statusCode == 400) {
      showSnackbar("error");
      return;
    }
    if (res2.statusCode != 200) {
      showSnackbar("Ha habido un error con el token");
    }
    final token = data2["token"];
    final userid = data["user_id"];
    print(userid);
    // print(token);
    // print(userid);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', userid);
    // ignore: use_build_context_synchronously
    //Navigator.push(context,MaterialPageRoute(builder: (context) => Home()),);
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(
      context,
      'home',
    );
  }
}