import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:elite_manager/pages/config.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isLoading = false;
  late String idproducto;
  late String _nameproducto;
  late String categorias;
  late String precioproducto;
  late String imageUrl;
  late String descripcionproducto;
  late bool statusproducto;
  late Stream<bool> statusStream;

  List<String> categoriasList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchProductoName();
    statusStream = _getStatusStream();
  }

Future<String> _fetchProductoName() async {
  final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
  if (arguments != null &&
      arguments.containsKey('id_prod') &&
      arguments.containsKey('nombre_prod') &&
      arguments.containsKey('descr_prod') &&
      arguments.containsKey('precio_prod') &&
      arguments.containsKey('categorias_prod') &&
      arguments.containsKey('imagen_prod') &&
      arguments.containsKey('estado_prod')) {
    idproducto = arguments['id_prod'].toString();
    _nameproducto = arguments['nombre_prod'].toString();
    descripcionproducto = arguments['descr_prod'].toString();
    precioproducto = arguments['precio_prod'].toString();
    categorias = arguments['categorias_prod'].toString();
    imageUrl = arguments['imagen_prod'].toString();
    statusproducto = arguments['estado_prod'] as bool;
  }

  // Eliminar los corchetes [ y ] de la cadena de categorías
  // si la categoría viene vacía
  if (categorias == '[]') {
    categorias = '';
    categoriasList = [];
  } else {
    categorias = categorias.substring(1, categorias.length - 1);
  }
  categoriasList = categorias.split(',').map((categoria) => categoria.trim()).toList();


  print(categoriasList);

  //Si la imagen viene null poner una por defecto desde assets
  if (imageUrl == 'null') {
    imageUrl = 'null';
  }

  return _nameproducto;
}

  Stream<bool> _getStatusStream() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 3)); // Actualizar cada 5 segundos
      yield await _fetchProductoStatus();
    }
  }

  Future<bool> _fetchProductoStatus() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://${Configuracion.apiurl}/Api/productos/$idproducto/'),
        headers: {'Content-Type': 'application/json'},
      );

      final responseData = jsonDecode(response.body);
      print(responseData);

      final newProductoStatus = responseData['estado'] as bool?;
      return newProductoStatus ?? false;
    } catch (error) {
      // Manejar el error de la API
      print(error);
      return statusproducto;
    }
  }

  Future<void> _updateProductoStatus(bool newStatus) async {
    try {
      final response = await http.put(
        Uri.parse(
            'http://${Configuracion.apiurl}/Api/productos/$idproducto/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'estado': newStatus,
        }),
      );

      final responseData = jsonDecode(response.body);

      final newProductoStatus = responseData['estado'] as bool?;
      if (newProductoStatus != null) {
        setState(() {
          statusproducto = newProductoStatus;
        });
      }
      print('se logro');

    } catch (error) {
      print('Error en la API');
      print(error);
      // Mostrar un mensaje de error o realizar alguna acción de recuperación
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_nameproducto),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                margin: EdgeInsets.all(35.0),
                color: Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200.0,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                        child: FadeInImage(
                          image: imageUrl.isNotEmpty && imageUrl != 'null' 
                            ? NetworkImage(imageUrl)
                            : AssetImage('assets/defaultproducto.jpg') as ImageProvider,
                          placeholder:
                              AssetImage('assets/Loading_icon.gif'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              _nameproducto,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          StreamBuilder<bool>(
                            stream: statusStream,
                            initialData: statusproducto,
                            builder: (context, snapshot) {
                              final isSwitchLoading =
                                  snapshot.connectionState ==
                                          ConnectionState.waiting ||
                                      snapshot.data == null;
                              final currentStatus = snapshot.data ?? false;
                              return isSwitchLoading
                                  ? CircularProgressIndicator()
                                  : Switch(
                                      value: currentStatus,
                                      onChanged: (value) {
                                        _updateProductoStatus(value);
                                      },
                                      activeColor: Colors.white,
                                      activeTrackColor:
                                          Theme.of(context).primaryColor,
                                      inactiveTrackColor: Colors.grey[300],
                                    );
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Precio:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '\$ $precioproducto',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            'Descripción:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            descripcionproducto,
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            'Categorías:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Wrap(
                          spacing: 8.0,
                          children: categorias == '' || categoriasList.length == 0 || categoriasList == null
                              ? [
                                  Text(
                                    "No tiene categorías asociadas.",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ]
                              : categoriasList.map((categoria) {
                                  return Chip(
                                    label: Text(categoria),
                                    backgroundColor: Theme.of(context).primaryColor,
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                  );
                                }).toList(),
                        )
                        ],
                      ),
                    ),
                    SizedBox(height: 40.0),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:elite_manager/pages/config.dart';

// class ProductCard extends StatefulWidget {
//   const ProductCard({Key? key}) : super(key: key);

//   @override
//   _ProductCardState createState() => _ProductCardState();
// }

// class _ProductCardState extends State<ProductCard> {
//   bool isLoading = false;
//   late String idproducto;
//   late String _nameproducto;
//   late List<dynamic> categorias;
//   late String precioproducto;
//   late String imageUrl;
//   late String descripcionproducto;
//   late bool statusproducto;
//   late Stream<bool> statusStream;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _fetchProductoName();
//     statusStream = _getStatusStream();
//   }

//   Future<String> _fetchProductoName() async {
//     final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
//     if (arguments != null &&
//         arguments.containsKey('id_prod') &&
//         arguments.containsKey('nombre_prod') &&
//         arguments.containsKey('descr_prod') &&
//         arguments.containsKey('precio_prod') &&
//         arguments.containsKey('categorias_prod') &&
//         arguments.containsKey('imagen_prod') &&
//         arguments.containsKey('estado_prod')) {
//       idproducto = arguments['id_prod'].toString();
//       _nameproducto = arguments['nombre_prod'].toString();
//       descripcionproducto = arguments['descr_prod'].toString();
//       precioproducto = arguments['precio_prod'].toString();
//       categorias = List<dynamic>.from(arguments['categorias_prod']);
//       imageUrl = arguments['imagen_prod'].toString();
//       statusproducto = arguments['estado_prod'] as bool;
//     }

//     return _nameproducto;
//   }

// @override
// Widget build(BuildContext context) {
//   List<dynamic> categorias = []; // reemplaza esto con la forma en que obtienes las categorías

//   List<String> categoriasList = categorias
//       .map((categoria) => categoria['nombre'].toString())
//       .toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_nameproducto),
//         centerTitle: true,
//       ),
//       resizeToAvoidBottomInset: true,
//       body: Container(
//         margin: EdgeInsets.symmetric(horizontal: 10.0),
//         child: ConstrainedBox(
//           constraints: BoxConstraints(
//             maxWidth: MediaQuery.of(context).size.width,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Card(
//                 elevation: 4.0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16.0),
//                 ),
//                 margin: EdgeInsets.all(35.0),
//                 color: Color.fromARGB(255, 255, 255, 255),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       height: 200.0,
//                       width: double.infinity,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(16.0),
//                           topRight: Radius.circular(16.0),
//                         ),
//                         child: FadeInImage(
//                           image: imageUrl.isNotEmpty && imageUrl != 'null' 
//                             ? NetworkImage(imageUrl)
//                             : AssetImage('assets/defaultproducto.jpg') as ImageProvider,
//                           placeholder:
//                               AssetImage('assets/Loading_icon.gif'),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(10.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               _nameproducto,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18.0,
//                               ),
//                             ),
//                           ),
//                           StreamBuilder<bool>(
//                             stream: statusStream,
//                             initialData: statusproducto,
//                             builder: (context, snapshot) {
//                               final isSwitchLoading =
//                                   snapshot.connectionState ==
//                                           ConnectionState.waiting ||
//                                       snapshot.data == null;
//                               final currentStatus = snapshot.data ?? false;
//                               return isSwitchLoading
//                                   ? CircularProgressIndicator()
//                                   : Switch(
//                                       value: currentStatus,
//                                       onChanged: (value) {
//                                         _updateProductoStatus(value);
//                                       },
//                                       activeColor: Colors.white,
//                                       activeTrackColor:
//                                           Theme.of(context).primaryColor,
//                                       inactiveTrackColor: Colors.grey[300],
//                                     );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 12.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Precio:',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16.0,
//                             ),
//                           ),
//                           SizedBox(height: 4.0),
//                           Text(
//                             precioproducto,
//                             style: TextStyle(fontSize: 16.0),
//                           ),
//                           SizedBox(height: 12.0),
//                           Text(
//                             'Descripción:',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16.0,
//                             ),
//                           ),
//                           SizedBox(height: 4.0),
//                           Text(
//                             descripcionproducto,
//                             style: TextStyle(fontSize: 16.0),
//                           ),
//                           SizedBox(height: 12.0),
//                           Text(
//                             'Categorías:',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16.0,
//                             ),
//                           ),
//                           SizedBox(height: 4.0),
//                           Wrap(
//                             spacing: 8.0,
//                             children: categoriasList.length == 0
//                                 ? [
//                                     Text(
//                                       "No tiene categorías asociadas",
//                                       style: TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 16.0,
//                                       ),
//                                     ),
//                                   ]
//                                 : categoriasList.map((categoria) {
//                                     return Chip(
//                                       label: Text(categoria),
//                                       backgroundColor: Theme.of(context).primaryColor,
//                                       labelStyle: TextStyle(
//                                         color: Colors.white,
//                                       ),
//                                     );
//                                   }).toList(),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 40.0),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20.0),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Stream<bool> _getStatusStream() async* {
//     while (true) {
//       await Future.delayed(Duration(seconds: 3)); // Actualizar cada 5 segundos
//       yield await _fetchProductoStatus();
//     }
//   }

//   Future<bool> _fetchProductoStatus() async {
//     try {
//       final response = await http.get(
//         Uri.parse(
//             'http://${Configuracion.apiurl}/Api/productos/$idproducto/'),
//         headers: {'Content-Type': 'application/json'},
//       );

//       final responseData = jsonDecode(response.body);
//       print(responseData);

//       final newProductoStatus = responseData['estado'] as bool?;
//       return newProductoStatus ?? false;
//     } catch (error) {
//       // Manejar el error de la API
//       print(error);
//       return statusproducto;
//     }
//   }

//   Future<void> _updateProductoStatus(bool newStatus) async {
//     try {
//       final response = await http.put(
//         Uri.parse(
//             'http://${Configuracion.apiurl}/Api/productos/$idproducto/'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'estado': newStatus,
//         }),
//       );

//       final responseData = jsonDecode(response.body);

//       final newProductoStatus = responseData['estado'] as bool?;
//       if (newProductoStatus != null) {
//         setState(() {
//           statusproducto = newProductoStatus;
//         });
//       }
//     } catch (error) {
//       // Manejar el error de la API
//       print(error);
//       // Mostrar un mensaje de error o realizar alguna acción de recuperación
//     }
//   }
// }
