// Aqui se importan los packages del archivo de rutas de cada carpeta
import 'package:elite_manager/pages/pages.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const initialRoute = 'lista';

  static final routes = <String, WidgetBuilder>{
    'login': (BuildContext context) => const LoginPage(),
    'home': (BuildContext context) => HomePage(),
    'error': (BuildContext context) => const ErrorPage(),
    'forgot_password': (BuildContext context) => const ForgotPasswordScreen(),
    'inventario': (BuildContext context) => const InventoryScreen(),
    'proveedores': (BuildContext context) => const ProvidersScreen(),
    'ventas': (BuildContext context) => const SalesScreen(),
    ///////////////////////////insumos///////////////////////////////
    'insumos': (BuildContext context) => const SuppliesScreen(),
    ///////////////////////////productos///////////////////////////////
    'productoshome': (BuildContext context) => const ProductHomeScreen(),
    ///////////////////////////productos-Categorias///////////////////////////////
    'categorias': (BuildContext context) => const CategoriesScreen(),
    ///////////////////////////productos-Productos///////////////////////////////
    'productospag': (BuildContext context) => const ProductPagScreen(),
    ///////////////////////////
  };
  static Route<dynamic> onGenerateRoute(RouteSettings settings){
    return MaterialPageRoute(
      builder: (context) => const ErrorPage(),
    );
  }
}