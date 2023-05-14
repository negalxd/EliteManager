import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:elite_manager/pages/config.dart';

class Providerlist extends StatefulWidget {
  @override
  _ProviderlistState createState() => _ProviderlistState();
}

class _ProviderlistState extends State<Providerlist> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _proveedores = [];
  List<Map<String, dynamic>> _filteredproveedores = [];


  @override
    void initState() {
    super.initState();
    _getproveedores();
  }

  final utf8decoder = const Utf8Decoder();

  void _getproveedores() async {
  final response = await http.get(Uri.parse('http://${Configuracion.apiurl}/Api/proveedores/'));
  final List<dynamic> responseData = json.decode(utf8decoder.convert(response.bodyBytes));
  setState(() {
    _proveedores = responseData.cast<Map<String, dynamic>>();
    _filteredproveedores = _proveedores.toList();
  });
  print(_filteredproveedores);
}

  void _filterProviders(String query) {
    setState(() {
      _filteredproveedores = _proveedores
          .where((proveedores) =>
              proveedores['nombre']
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              proveedores['nombre']
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Providers disponibles'),
    ),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            onChanged: _filterProviders,
            decoration: const InputDecoration(
              hintText: 'Buscar Providers',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredproveedores.length,
            itemBuilder: (BuildContext context, int index) {
              final proveedores = _filteredproveedores[index];
            return Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
              leading: CircleAvatar(
                child: FadeInImage(
                  placeholder: const AssetImage('assets/Loading_icon.gif'),
                  image: proveedores['image_proveedor'] != null ? NetworkImage(proveedores['image_proveedor']) : const AssetImage('assets/defaultproducto.jpg') as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
                title: Text(proveedores['nombre']),
                subtitle: Text('${proveedores['email']}'),
                onTap: () {
                  Navigator.pushNamed(context, 'productositem');
                },
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
