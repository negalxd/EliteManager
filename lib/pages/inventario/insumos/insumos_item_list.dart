import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:elite_manager/pages/config.dart';

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
  final response = await http.get(Uri.parse('http://${Configuracion.apiurl}/Api/insumos/'));
  final List<dynamic> responseData = json.decode(utf8decoder.convert(response.bodyBytes));
  setState(() {
    _insumos = responseData.cast<Map<String, dynamic>>();
    _filteredInsumos = _insumos.toList();
  });
  print(_filteredInsumos);
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
          title: const Text("Eliminar insumo"),
          content: Text("¿Está seguro que desea eliminar el insumo ${insumo['prov_insumo_nombre']}?, esta acción no se puede deshacer."),
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
  final response = await http.delete(Uri.parse('http://${Configuracion.apiurl}/Api/insumos/${insumo['id']}/'));
  if (response.statusCode == 204) {
    setState(() {
      _insumos.remove(insumo);
      _filteredInsumos = _insumos;
    });
  //mostrar Snack de confirmacion de eliminacion
  // ignore: use_build_context_synchronously
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('El insumo ${insumo['prov_insumo_nombre']} ha sido eliminado correctamente'),
      backgroundColor: Colors.red,
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
              suffixIcon: IconButton(
                color: Color.fromARGB(255, 4, 75, 134),
                icon: const Icon(Icons.add_box),
                onPressed: () {
                  Navigator.pushNamed(context, 'insumoslistcreate');
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredInsumos.length,
            itemBuilder: (BuildContext context, int index) {
              final insumo = _filteredInsumos[index];
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
                  image: insumo['image_insumo'] != null ? NetworkImage(insumo['image_insumo']) : const AssetImage('assets/defaultproducto.jpg') as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),

                title: Text(insumo['prov_insumo_nombre']),
                subtitle: Text('${insumo['proveedor_nombre']}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  color: const Color.fromARGB(255, 182, 30, 19),
                  onPressed: () {
                    _confirmDelete(insumo);
                  },
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'insumositemlote', arguments: {
                      'id_insumo': insumo['id'],
                      'nombre_insumo': insumo['prov_insumo_nombre'],
                      });
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
