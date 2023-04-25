import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:elite_manager/pages/config.dart';

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
        await http.get(Uri.parse('http://${Configuracion.apiurl}/Api/prov-insumos/'));
    final List<dynamic> responseData =
        json.decode(utf8decoder.convert(response.bodyBytes));
    setState(() {
      _insumos = responseData.cast<Map<String, dynamic>>();
      print(_insumos);
    });
  }

  void _getProveedor() async {
    final response =
        await http.get(Uri.parse('http://${Configuracion.apiurl}/Api/proveedores/'));
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

  final response = await http.post(Uri.parse('http://${Configuracion.apiurl}/Api/insumos/'),
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

