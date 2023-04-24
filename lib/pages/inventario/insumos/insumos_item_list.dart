import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InsumosScreen extends StatefulWidget {
  @override
  _InsumosScreenState createState() => _InsumosScreenState();
}

class _InsumosScreenState extends State<InsumosScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _insumos = [];
  List<Map<String, dynamic>> _filteredInsumos = [];

  @override
  void initState() {
    super.initState();
    _getInsumos();
  }

  final utf8decoder = const Utf8Decoder();

  void _getInsumos() async {
  final response = await http.get(Uri.parse('http://192.168.1.4/Api/insumos/'));
  final List<dynamic> responseData = json.decode(utf8decoder.convert(response.bodyBytes));
  setState(() {
    _insumos = responseData.cast<Map<String, dynamic>>();
    _filteredInsumos = _insumos.toList();
  });
}


  void _filterInsumos(String query) {
    setState(() {
      _filteredInsumos = _insumos
          .where((insumo) =>
              insumo['prov_insumo_nombre']
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              insumo['proveedor_nombre']
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  void _confirmDelete(Map<String, dynamic> insumo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Eliminar insumo"),
          content: Text("¿Está seguro que desea eliminar el insumo ${insumo['prov_insumo_nombre']}?"),
          actions: [
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Eliminar"),
              onPressed: () {
                _deleteInsumo(insumo);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteInsumo(Map<String, dynamic> insumo) async {
  final response = await http.delete(Uri.parse('http://192.168.1.4/Api/insumos/${insumo['id']}/'));
  if (response.statusCode == 204) {
    setState(() {
      _insumos.remove(insumo);
      _filteredInsumos = _insumos;
    });
  //mostrar Snack de confirmacion de eliminacion
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('El insumo ${insumo['prov_insumo_nombre']} ha sido eliminado correctamente'),
    ));
  } else {
    print('Error al eliminar el insumo');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insumos disponibles'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField( 
              controller: _searchController,
              onChanged: _filterInsumos,
              decoration: InputDecoration(
                hintText: 'Buscar insumos',
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredInsumos.length,
              itemBuilder: (BuildContext context, int index) {
                final insumo = _filteredInsumos[index];
                return ListTile(
                  title: Text(insumo['prov_insumo_nombre']),
                  subtitle: Text(insumo['proveedor_nombre']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _confirmDelete(insumo);
                    },
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'insumositemlote');
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'insumoslistcreate');
        },
        child: Icon(Icons.add),
      ),
    );
  }

}             
