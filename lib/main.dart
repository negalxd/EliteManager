import 'package:elite_manager/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:elite_manager/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elite Manager',
      debugShowCheckedModeBanner: false,
      theme: MyTheme.mytheme,
      initialRoute: 'login',
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}