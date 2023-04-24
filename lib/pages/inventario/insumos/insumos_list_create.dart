import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AddInsumo extends StatefulWidget {
  @override
  _AddInsumoState createState() => _AddInsumoState();
}

class _AddInsumoState extends State<AddInsumo> {
  List<Map<String, dynamic>> _insumos = [];
  List<Map<String, dynamic>> _proveedores = [];
  String? _selectedProveedorId;
  String? _selectedInsumoId;

  @override
  void initState() {
    super.initState();
    _getInsumos();
    _getProveedor();
  }

  final utf8decoder = const Utf8Decoder();

  void _getInsumos() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.4/Api/prov-insumos/'));
    final List<dynamic> responseData =
        json.decode(utf8decoder.convert(response.bodyBytes));
    setState(() {
      _insumos = responseData.cast<Map<String, dynamic>>();
      print(_insumos);
    });
  }

  void _getProveedor() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.4/Api/proveedores/'));
    final List<dynamic> responseData =
        json.decode(utf8decoder.convert(response.bodyBytes));
    setState(() {
      _proveedores = responseData.cast<Map<String, dynamic>>();
      print(_proveedores);
    });
  }

  void _addInsumo() async {
  if (_selectedProveedorId == null || _selectedInsumoId == null) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Por favor seleccione un proveedor e insumo.'),
    ));
    return;
  }

  final response = await http.post(Uri.parse('http://192.168.1.4/Api/insumos/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'proveedor': _selectedProveedorId,
      'prov_insumo': _selectedInsumoId,
    }));
  Navigator.pop(context);
  Navigator.pushNamed(context, 'insumoslist');
  final responseData = jsonDecode(response.body);
  print(responseData);
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insumos'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Proveedor:'),
            DropdownButton<String>(
              value: _selectedProveedorId,
              onChanged: (value) {
                setState(() {
                  _selectedProveedorId = value;
                  _selectedInsumoId = null; // reset selected insumo
                });
              },
              items: [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text('Selecciona un proveedor'),
                ),
                ..._proveedores
                  .map((proveedor) => DropdownMenuItem<String>(
                        value: proveedor['id'].toString(),
                        child: Text(proveedor['nombre']),
                      ))
                  .toList(),
              ],
            ),
            SizedBox(height: 16),
            Text('Insumo:'),
            DropdownButton<String>(
              value: _selectedInsumoId,
              onChanged: (_selectedProveedorId == null)
                  ? null
                  : (value) {
                      setState(() {
                        _selectedInsumoId = value;
                      });
                    },
              items: (_selectedProveedorId == null)
                  ? []
                  : _insumos
                      .where((insumo) =>
                          insumo['proveedor'].toString() ==
                          _selectedProveedorId)
                      .map((insumo) => DropdownMenuItem<String>(
                            value: insumo['id'].toString(),
                            child: Text(insumo['nombre']),
                          ))
                      .toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addInsumo,
        child: Icon(Icons.add),
      ),
    );
  }

}


// class AddInsumo extends StatefulWidget {
//   @override
//   _AddInsumoState createState() => _AddInsumoState();
// }

// class _AddInsumoState extends State<AddInsumo> {
//   List<Map<String, dynamic>> _insumos = [];
//   List<Map<String,  dynamic>> _proveedores = [];


//   @override
//   void initState() {
//     super.initState();
//     _getInsumos();
//     _getProveedor();
//   }
// final utf8decoder = const Utf8Decoder();
//   void _getInsumos() async {
//   final response = await http.get(Uri.parse('http://192.168.1.4/Api/prov-insumos/'));
//   final List<dynamic> responseData = json.decode(utf8decoder.convert(response.bodyBytes));
//   setState(() {
//     _insumos = responseData.cast<Map<String, dynamic>>();
//     print(_insumos);
//   });
// }

// void _getProveedor() async {
//   final response = await http.get(Uri.parse('http://192.168.1.4/Api/proveedores/'));
//   final List<dynamic> responseData = json.decode(utf8decoder.convert(response.bodyBytes));
//   setState(() {
//     _proveedores = responseData.cast<Map<String, dynamic>>();
//     print(_proveedores);
//   });
// }


// //mostrar json obtenido por _getInsumos en el widget
//   @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text('Insumos'),
//       centerTitle: true,
//     ),
//     body: ListView.builder(
//       itemCount: _insumos.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           // title: Text(_insumos[index]['id'].toString()),
//           // title: Text(_insumos[index]['nombre'].toString()),
//           // subtitle: Text(_proveedores[index]['nombre'].toString()),
//         );
//       },
//     ),
//   );
// }
        




  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Añadir Categoria Insumo'),
  //       centerTitle: true,
  //     ),
  //     resizeToAvoidBottomInset: true,
  //     body: SingleChildScrollView(
  //       child: Card(
  //       margin: EdgeInsets.all(16),
  //       color: Color.fromARGB(255, 255, 255, 255),
  //       elevation: 8,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //       child: Padding(
  //         padding: EdgeInsets.all(16),
  //         child: Form(
  //           key: _formKey,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.stretch,
  //             children: [
  //               if (_image != null) ...[
  //                 Container(
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(8),
  //                     color: Colors.white,
  //                   ),
  //                   height: 200,
  //                   child: Image.file(_image!, fit: BoxFit.cover, width: double.infinity),
  //                 ),
  //                 SizedBox(height: 16),
  //               ],
  //               ElevatedButton.icon(
  //                 onPressed: _pickImage,
  //                 icon: Icon(Icons.add_photo_alternate, size: 30, color: Color.fromARGB(255, 4, 75, 134),),
  //                 label: Text(
  //                   'Añadir imagen',
  //                   style: TextStyle(
  //                     fontSize: 18,
  //                     color: const Color.fromARGB(255, 4, 75, 134),
  //                   ),
  //                 ),
  //                 style: ButtonStyle(
  //                   backgroundColor: MaterialStateProperty.all<Color>(
  //                     Color.fromARGB(255, 255, 255, 255),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 20),
  //               TextFormField(
  //                 decoration: InputDecoration(
  //                   labelText: 'Nombre insumo',
  //                   border: OutlineInputBorder(
  //                     borderSide: BorderSide(color: Color.fromARGB(255, 4, 75, 134)),
  //                   ),
  //                 ),
  //                 validator: (value) {
  //                   if (value!.isEmpty) {
  //                     return 'Por favor ingrese el nombre del insumo';
  //                   }
  //                   return null;
  //                 },
  //                 onSaved: (value) {
  //                   _categoriaName = value!;
  //                 },
  //               ),
  //               SizedBox(height: 16),
  //               ElevatedButton(
  //                 onPressed: () {
  //                   if (_formKey.currentState!.validate()) {
  //                     _formKey.currentState!.save();
                      
  //                   }
  //                 },
  //                 style: ButtonStyle(
  //                 backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 4, 75, 134)),
  //                 foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
  //                 ),
  //                 child: Text('Guardar'),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //     ),
  //   );
  // }
