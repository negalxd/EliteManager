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
    'profile': (BuildContext context) => const ProfileScreen(userId: 1,),
    'help': (BuildContext context) => const HelpScreen(),
    ///////////////////////////insumos///////////////////////////////
    // 'insumos': (BuildContext context) => const SuppliesScreen(),
    'insumoslist': (BuildContext context) => InsumosScreen(),
    'insumositemlote': (BuildContext context) => const SuppliesLoteScreen(),
    'insumositemcreate': (BuildContext context) => const AddInsumosWidget(),
    'insumoslistcreate': (BuildContext context) => AddInsumo(),
    ///////////////////////////productos///////////////////////////////
    'productoshome': (BuildContext context) => const ProductHomeScreen(),
    'productospag': (BuildContext context) => ProductosScreen(),
    'productositem': (BuildContext context) => const ProductCard(),
    'productoscreate': (BuildContext context) => const AddProductWidget(),
    ///////////////////////////productos-Categorias///////////////////////////////
    'categorias': (BuildContext context) => CategoriasScreen(),
    'categoriaslistcreate': (BuildContext context) => const AddCategoryProductWidget(),
    'categoriasedit': (BuildContext context) => const EditCategoryProductWidget(),
    ///////////////////////////Proveedores///////////////////////////////
    'listaprov': (BuildContext context) => Providerlist(),
    'proveedoresitem': (BuildContext context) => ProviderItemCard(),
  };
  


  static Route<dynamic> onGenerateRoute(RouteSettings settings){
    return MaterialPageRoute(
      builder: (context) => const ErrorPage(),
    );
  }
}