import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:elite_manager/pages/config.dart';

class SuppliesLoteScreen extends StatefulWidget {
  const SuppliesLoteScreen({Key? key}) : super(key: key);

  @override
  _SuppliesLoteScreenState createState() => _SuppliesLoteScreenState();
}

class _SuppliesLoteScreenState extends State<SuppliesLoteScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _lotesInsumos = [];
  List<Map<String, dynamic>> _filteredLotesInsumos = [];

  int insumoId = 0;
  String nombreInsumo = '';

  @override
  void initState() {
    super.initState();
    _fetchLotesInsumos();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchInsumoId();
    _fetchLotesInsumos();
  }

  Future<void> _fetchInsumoId() async {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (arguments != null &&
        arguments.containsKey('id_insumo') && 
        arguments.containsKey('nombre_insumo')) {
      setState(() {
        insumoId = int.parse(arguments['id_insumo'].toString());
        nombreInsumo = arguments['nombre_insumo'].toString();
      });
    }
  }

  Future<void> _fetchLotesInsumos() async {
    final url = 'http://${Configuracion.apiurl}/Api/lotes-insumos/lotes/$insumoId/';
    final response = await http.get(Uri.parse(url));
    print('Response: ${response.body}');
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        _lotesInsumos = responseData.cast<Map<String, dynamic>>();
        _filteredLotesInsumos = _lotesInsumos.toList();
      });
    } else {
      // Manejar el error de la solicitud HTTP aquí
    }
  }

  void _filterLotesInsumos(String query) {
    setState(() {
      _filteredLotesInsumos = _lotesInsumos
          .where((loteInsumo) =>
              loteInsumo['n_lote'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }


  void _confirmDelete(Map<String, dynamic> loteInsumo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Eliminar Lote"),
          content: Text("¿Está seguro que desea eliminar el lote ${loteInsumo['n_lote']}?, esta acción no se puede deshacer."),
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
                _deleteInsumo(loteInsumo);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteInsumo(Map<String, dynamic> loteInsumo) async {
  final response = await http.delete(Uri.parse('http://${Configuracion.apiurl}/Api/lotes-insumos/${loteInsumo['id']}/'));
  if (response.statusCode == 200) {
    setState(() {
      _lotesInsumos.remove(loteInsumo);
      _filteredLotesInsumos = _lotesInsumos;
    });
  //mostrar Snack de confirmacion de eliminacion
  // ignore: use_build_context_synchronously
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('El Lote ${loteInsumo['n_lote']} ha sido eliminado correctamente'),
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
        title: Text('Lotes de $nombreInsumo'),
      ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterLotesInsumos,
                    decoration: InputDecoration(
                      hintText: 'Buscar lotes',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                color: Color.fromARGB(255, 4, 75, 134),
                icon: const Icon(Icons.add_box),
                onPressed: () {
                  Navigator.pushNamed(context, 'insumositemlotecreate', arguments: {'id_insumo': insumoId, 'nombre_insumo': nombreInsumo});
                },
              ),
                    ),
                  ),
                ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredLotesInsumos.length,
                itemBuilder: (BuildContext context, int index) {
                  final loteInsumo = _filteredLotesInsumos[index];
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
                      image: AssetImage('assets/gestionProd.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                    title: loteInsumo['estado'] == true
                    ? Text(loteInsumo['n_lote'])
                    : Text(
                      loteInsumo['n_lote'],
                      style: const TextStyle(
                        color: Color.fromARGB(255, 182, 30, 19),
                      ),
                    ),
                    subtitle: loteInsumo['estado'] == true 
                    ? Text('${loteInsumo['stock']}')
                    : Text(
                      'Lote caducado',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 182, 30, 19),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: const Color.fromARGB(255, 182, 30, 19),
                      onPressed: () {
                        _confirmDelete(loteInsumo);
                      },
                    ),
                    onTap: () {
                    Navigator.pushNamed(context, 'insumositemloteedit', arguments: {'id_lote': loteInsumo['id']});
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
