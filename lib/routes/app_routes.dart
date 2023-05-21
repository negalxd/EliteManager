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
    'productositem': (BuildContext context) => const ProductCard(imageUrl: 'https://phantom-marca.unidadeditorial.es/f6760f6b1e7e1e12d269072fc21bb930/crop/0x0/1319x878/resize/1320/f/jpg/assets/multimedia/imagenes/2022/09/13/16630610322957.jpg', productName: 'Fortnite BattleRoyale Season 69', description: 'Ut voluptate commodo laboris do tempor minim. Enim occaecat Lorem sit ex. Amet occaecat nostrud irure proident minim ex cillum nostrud dolore ullamco non ut non consectetur. Lorem laboris ut enim dolore aliquip mollit in ullamco consequat velit velit. In nisi in excepteur nostrud do commodo consectetur officia officia quis fugiat deserunt fugiat exercitation.', categories: ['fortnite', 'battleroyale'], isActive: true,),
    'productoscreate': (BuildContext context) => const AddProductWidget(),
    ///////////////////////////productos-Categorias///////////////////////////////
    'categorias': (BuildContext context) => CategoriasScreen(),
    'categoriaslistcreate': (BuildContext context) => const AddCategoryProductWidget(),
    'categoriasedit': (BuildContext context) => const EditCategoryProductWidget(),
    ///////////////////////////productos-Productos///////////////////////////////
    'productospag': (BuildContext context) => const ProductPagScreen(),
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