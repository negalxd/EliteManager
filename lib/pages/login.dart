import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Config {
  static  String appName = "Empresa XYZ";
  static  String apiURL = '192.168.1.3';
  static  const loginAPI = "Api/login/";
  static  const obtenertokenAPI = "Api/api-token-auth/";
}
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

  //final urllogin = Uri.parse("http://192.168.1.108/api/login/");
  final urllogin = Uri.http(Config.apiURL, Config.loginAPI);

  //final urlobtenertoken = Uri.parse("http://192.168.1.108/api/api-token-auth/");
  final urlobtenertoken = Uri.http(Config.apiURL, Config.obtenertokenAPI);
  final headers = {"Content-Type": "application/json;charset=UTF-8"};


@override
Widget build(BuildContext context) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
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
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
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
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, 'forgot_password');
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 4, 75, 134),
            ),
            child: const Text('¿Olvidaste tu contraseña?'),
          ),
          const Expanded(child: SizedBox()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 180,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/wave.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
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
    //final data = Map.from(jsonDecode(res.body));
    if (res.statusCode == 400) {
      showSnackbar("error");
      return;
    }
    if (res.statusCode != 200) {
      showSnackbar("Ha habido un error al obtener usuario y contraseña");
    }
    final res2 = await http.post(urlobtenertoken,
        headers: headers, body: jsonEncode(datosdelposibleusuario));
    final data2 = Map.from(jsonDecode(res2.body));
    if (res2.statusCode == 400) {
      showSnackbar("error");
      return;
    }
    if (res2.statusCode != 200) {
      showSnackbar("Ha habido un error con el token");
    }
    final token = data2["token"];
    final user = Usuario(
        username: nameController.text,
        password: passwordController.text,
        token: token);
    // ignore: use_build_context_synchronously
    //Navigator.push(context,MaterialPageRoute(builder: (context) => Home()),);
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(
      context,
      'home',
    );
  }
}