// Aqui se importan los packages del archivo de rutas de cada carpeta
import 'package:elite_manager/pages/inventario/insumos/insumos_edit_lotes.dart';
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
    'insumoslistcreate': (BuildContext context) => AddInsumo(),
    ///////////////////////////insumos-Lotes///////////////////////////////
    'insumositemlote': (BuildContext context) => const SuppliesLoteScreen(),
    'insumositemlotecreate': (BuildContext context) => const AddLotesWidget(),
    'insumositemloteedit': (BuildContext context) => const EditLotesWidget(),
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
    'ordenescompra': (BuildContext context) => OrdersScreen(),
    ///////////////////////////Ventas///////////////////////////////
    'gestionVentas': (BuildContext context) => VentasListWidget(),
    'ventasitem': (BuildContext context) => const VentasItemCard(),
    ////////////////Ventas-Gestion de ordenes de trabajo////////////
    'gestionOrdenes': (BuildContext context) => OrdenesTrabajoScreen(),
    //'ordenestrabajoitem': (BuildContext context) => const OrdenesTrabajoItemCard(),
    //'ordentrabajoscreatee': (BuildContext context) => const AddOrdenesTrabajoWidget(),
    //'ordenestrabajoedit': (BuildContext context) => const EditOrdenesTrabajoWidget(),
    'gestionClientes': (BuildContext context) => CotizacionesProductScreen(),
    'crearcliente': (BuildContext context) => const AddUserInfoWidget(),
    'itemscotizacion': (BuildContext context) => CotizacionesScreen(),
  };
  


  static Route<dynamic> onGenerateRoute(RouteSettings settings){
    return MaterialPageRoute(
      builder: (context) => const ErrorPage(),
    );
  }
}