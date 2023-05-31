// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:elite_manager/pages/config.dart';

// class OrdenesTrabajoScreen extends StatefulWidget {
//   @override
//   _OrdenesTrabajoScreenState createState() => _OrdenesTrabajoScreenState();
// }

// class _OrdenesTrabajoScreenState extends State<OrdenesTrabajoScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   List<Map<String, dynamic>> _OrdenesTrabajo = [];

//   List<Map<String, dynamic>> _FilteredOrdenesTrabajo = [];


//   @override
//   void initState() {
//     super.initState();
//     _getOrdenesTrabajo();
//   }

//   final utf8decoder = const Utf8Decoder();

//   void _getOrdenesTrabajo() async {
//   final response = await http.get(Uri.parse('http://${Configuracion.apiurl}/Api/ordenes-trabajo/'));
//   final List<dynamic> responseData = json.decode(utf8decoder.convert(response.bodyBytes));
//   setState(() {
//     _OrdenesTrabajo = responseData.cast<Map<String, dynamic>>();
//     _FilteredOrdenesTrabajo = _OrdenesTrabajo.toList();
//   });
//   print(_FilteredOrdenesTrabajo);
// }


//   void _filterordentrabajos(String query) {
//   setState(() {
//     _FilteredOrdenesTrabajo = _OrdenesTrabajo
//         .where((orden) =>
//             orden['cod_ot'].toString().contains(query) ||
//             orden['prioridad'].toString().toLowerCase().contains(query.toLowerCase()))
//         .toList();
//   });
// }

//   void _confirmDelete(Map<String, dynamic> ordentrabajo) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Eliminar orden de trabajo"),
//           content: Text("¿Está seguro que desea eliminar la orden de trabajo ${ordentrabajo['cod_ot']}?, esta acción no se puede deshacer."),
//           actions: [
//             TextButton(
//               child: const Text("Cancelar"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: const Text(
//                 "Eliminar",
//                 style: TextStyle(color: Colors.red),
//               ),
//               onPressed: () {
//                 _deleteordentrabajo(ordentrabajo);
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _deleteordentrabajo(Map<String, dynamic> ordentrabajo) async {
//   final response = await http.delete(Uri.parse('http://${Configuracion.apiurl}/Api/ordenes-trabajo/${ordentrabajo['id']}/'));
//   if (response.statusCode == 204) {
//     setState(() {
//       _OrdenesTrabajo.remove(ordentrabajo);
//       _FilteredOrdenesTrabajo = _OrdenesTrabajo;
//     });
//   //mostrar Snack de confirmacion de eliminacion
//   // ignore: use_build_context_synchronously
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text('La orden de trabajo ${ordentrabajo['cod_ot']} ha sido eliminada correctamente'),
//       backgroundColor: Colors.red,
//     ));
//   } else {
//     print('Error al eliminar el ordentrabajo');
//   }
// }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text('Ordenes de trabajo'),
//     ),
//     body: Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: TextField(
//             controller: _searchController,
//             onChanged: _filterordentrabajos,
//             decoration: InputDecoration(
//               hintText: 'Buscar ordenes de trabajo',
//               prefixIcon: const Icon(Icons.search),
//               suffixIcon: IconButton(
//                 color: Color.fromARGB(255, 4, 75, 134),
//                 icon: const Icon(Icons.add_box),
//                 onPressed: () {
//                   Navigator.pushNamed(context, 'ordentrabajoscreate');
//                 },
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: ListView.builder(
//             itemCount: _FilteredOrdenesTrabajo.length,
//             itemBuilder: (BuildContext context, int index) {
//               final ordentrabajo = _FilteredOrdenesTrabajo[index];
//               final bool estado = ordentrabajo['estado'] ?? false;
//               final Color colorEstado = estado ? Colors.green : Colors.red;

//               return Container(
//                 margin: const EdgeInsets.all(8.0),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.grey.shade300,
//                     width: 1.0,
//                   ),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: ListTile(
//                   leading: Container(
//                     width: 8.0,
//                     color: colorEstado,
//                   ),
//                   title: Text('Orden Nº ${ordentrabajo['cod_ot']}'),
//                   subtitle: RichText(
//                     text: TextSpan(
//                       text: '${ordentrabajo['fecha_objetivo']}\n',
//                       style: DefaultTextStyle.of(context).style,
//                       children: <TextSpan>[
//                         TextSpan(
//                           text: 'Prioridad: ',
//                           style: TextStyle(fontSize: 12, color: Colors.grey),
//                         ),
//                         TextSpan(
//                           text: '${ordentrabajo['prioridad']}',
//                           style: TextStyle(fontSize: 12),
//                         ),
//                       ],
//                     ),
//                   ),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.delete),
//                     color: const Color.fromARGB(255, 182, 30, 19),
//                     onPressed: () {
//                       _confirmDelete(ordentrabajo);
//                     },
//                   ),
//                   onTap: () {
//                     Navigator.pushNamed(context, 'ordentrabajositem', arguments: {
//                       'id_ot': ordentrabajo['id'],
//                       'cod_ot': ordentrabajo['cod_ot'],
//                       'prioridad_ot': ordentrabajo['prioridad'],
//                       'tipo_ot': ordentrabajo['tipo'],
//                       'equipo_ot': ordentrabajo['equipo'],
//                       'fecha_ot': ordentrabajo['fecha_objetivo'],
//                       'created_ot': ordentrabajo['fecha_creacion'],
//                       'estado_ot': ordentrabajo['estado'],
//                       'resumen_ot': ordentrabajo['resumen'],
//                     });
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     ),
//   );
// }



// }  

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:elite_manager/pages/config.dart';
import 'package:intl/intl.dart';

class OrdenesTrabajoScreen extends StatefulWidget {
  @override
  _OrdenesTrabajoScreenState createState() => _OrdenesTrabajoScreenState();
}

class _OrdenesTrabajoScreenState extends State<OrdenesTrabajoScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _OrdenesTrabajo = [];
  List<Map<String, dynamic>> _FilteredOrdenesTrabajo = [];

  @override
  void initState() {
    super.initState();
    _getOrdenesTrabajo();
  }

  final utf8decoder = const Utf8Decoder();

  void _getOrdenesTrabajo() async {
    final response = await http.get(Uri.parse('http://${Configuracion.apiurl}/Api/ordenes-trabajo/'));
    final List<dynamic> responseData = json.decode(utf8decoder.convert(response.bodyBytes));
    setState(() {
      _OrdenesTrabajo = responseData.cast<Map<String, dynamic>>();
      _FilteredOrdenesTrabajo = _OrdenesTrabajo.toList();
    });
    print(_FilteredOrdenesTrabajo);
  }

  void _filterordentrabajos(String query) {
    setState(() {
      _FilteredOrdenesTrabajo = _OrdenesTrabajo
          .where((orden) =>
              orden['cod_ot'].toString().contains(query) ||
              orden['prioridad'].toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _confirmDelete(Map<String, dynamic> ordentrabajo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Eliminar orden de trabajo"),
          content: Text("¿Está seguro que desea eliminar la orden de trabajo ${ordentrabajo['cod_ot']}?, esta acción no se puede deshacer."),
          actions: [
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                "Eliminar",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                _deleteordentrabajo(ordentrabajo);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteordentrabajo(Map<String, dynamic> ordentrabajo) async {
    final response = await http.delete(Uri.parse('http://${Configuracion.apiurl}/Api/ordenes-trabajo/${ordentrabajo['id']}/'));
    if (response.statusCode == 204) {
      setState(() {
        _OrdenesTrabajo.remove(ordentrabajo);
        _FilteredOrdenesTrabajo = _OrdenesTrabajo;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('La orden de trabajo ${ordentrabajo['cod_ot']} ha sido eliminada correctamente'),
        backgroundColor: Colors.red,
      ));
    } else {
      print('Error al eliminar la orden de trabajo');
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Ordenes de trabajo'),
    ),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            onChanged: _filterordentrabajos,
            decoration: InputDecoration(
              hintText: 'Buscar ordenes de trabajo',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                color: Color.fromARGB(255, 4, 75, 134),
                icon: const Icon(Icons.add_box),
                onPressed: () {
                  Navigator.pushNamed(context, 'ordentrabajoscreate');
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            'Mantén presionado para editar',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
          Expanded(
            child: ListView.builder(
              itemCount: _FilteredOrdenesTrabajo.length,
              itemBuilder: (BuildContext context, int index) {
                final ordentrabajo = _FilteredOrdenesTrabajo[index];
                final bool estado = ordentrabajo['estado'] ?? false;
                final Color colorEstado = estado ? Colors.green : Colors.red;

                return GestureDetector(
                  onLongPress: () {
                    Navigator.pushNamed(context, 'ordenestrabajoedit',
                        arguments: {
                          'id_ot': ordentrabajo['id'],
                          'cod_ot': ordentrabajo['cod_ot'],
                          'prioridad_ot': ordentrabajo['prioridad'],
                          'tipo_ot': ordentrabajo['tipo'],
                          'equipo_ot': ordentrabajo['equipo'],
                          'fecha_ot': ordentrabajo['fecha_objetivo'],
                          'created_ot': ordentrabajo['fecha_creacion'],
                          'estado_ot': ordentrabajo['estado'],
                          'resumen_ot': ordentrabajo['resumen'],
                        });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 8.0,
                        color: colorEstado,
                      ),
                      title: Text('Orden Nº ${ordentrabajo['cod_ot']}'),
                      subtitle: RichText(
                        text: TextSpan(
                          text: '${DateFormat('dd-MM-yyyy').format(DateTime.parse(ordentrabajo['fecha_objetivo']))}\n',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Prioridad: ',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            TextSpan(
                              text: '${ordentrabajo['prioridad']}',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        color: const Color.fromARGB(255, 182, 30, 19),
                        onPressed: () {
                          _confirmDelete(ordentrabajo);
                        },
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, 'ordentrabajositem', arguments: {
                          'id_ot': ordentrabajo['id'],
                          'cod_ot': ordentrabajo['cod_ot'],
                          'prioridad_ot': ordentrabajo['prioridad'],
                          'tipo_ot': ordentrabajo['tipo'],
                          'equipo_ot': ordentrabajo['equipo'],
                          'fecha_ot': ordentrabajo['fecha_objetivo'],
                          'created_ot': ordentrabajo['fecha_creacion'],
                          'estado_ot': ordentrabajo['estado'],
                          'resumen_ot': ordentrabajo['resumen'],
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
