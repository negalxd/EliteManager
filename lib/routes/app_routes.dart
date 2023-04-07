// Aqui se importan los packages del archivo de rutas de cada carpeta
import 'package:elite_manager/pages/pages.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const initialRoute = 'lista';

  static final routes = <String, WidgetBuilder>{
    'login': (BuildContext context) => const LoginPage(),
    'home': (BuildContext context) => const HomePage(),
    'error': (BuildContext context) => const ErrorPage(),
    'forgot_password': (BuildContext context) => const ForgotPasswordScreen(),

  };
  static Route<dynamic> onGenerateRoute(RouteSettings settings){
    return MaterialPageRoute(
      builder: (context) => const ErrorPage(),
    );
  }
}