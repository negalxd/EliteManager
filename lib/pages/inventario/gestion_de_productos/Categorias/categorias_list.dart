
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:elite_manager/pages/config.dart';
import 'dart:async';

class CategoriasScreen extends StatefulWidget {
  @override
  _CategoriasScreenState createState() => _CategoriasScreenState();
}

class _CategoriasScreenState extends State<CategoriasScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _categorias = [];
  ValueNotifier<List<Map<String, dynamic>>> _filteredCategorias = ValueNotifier<List<Map<String, dynamic>>>([]);
  
  @override
  void initState() {
    super.initState();
    _getCategorias();
  }

  @override
  void dispose() {
    _filteredCategorias.dispose();
    super.dispose();
  }

  final utf8decoder = const Utf8Decoder();

  void _getCategorias() async {
    final response = await http.get(Uri.parse('http://${Configuracion.apiurl}/Api/producto-categorias/'));
    final List<dynamic> responseData = json.decode(utf8decoder.convert(response.bodyBytes));
    setState(() {
      _categorias = responseData.cast<Map<String, dynamic>>();
      _filteredCategorias.value = _categorias.toList();
    });
  }

  void _filterCategorias(String query) {
    setState(() {
      _filteredCategorias.value = _categorias
          .where((categoria) =>
              categoria['nombre']
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  void _confirmDelete(Map<String, dynamic> categoria) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Eliminar categoría"),
          content: Text("¿Está seguro que desea eliminar la categoría ${categoria['nombre']}?, esta acción no se puede deshacer."),
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
                Navigator.of(context).pop();
                _deleteCategoria(categoria);
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteCategoria(Map<String, dynamic> categoria) async {
    final response = await http.delete(Uri.parse('http://${Configuracion.apiurl}/Api/producto-categorias/${categoria['cat_id']}/'));
    if (response.statusCode == 204) {
      setState(() {
        _categorias.remove(categoria);
        _filteredCategorias.value = _categorias;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('La categoría ${categoria['nombre']} ha sido eliminada correctamente'),
      ));
    } else {
      print('Error al eliminar la categoría');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorías disponibles'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterCategorias,
              decoration: InputDecoration(
                hintText: 'Buscar categorías',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  color: const Color.fromARGB(255, 4, 75, 134),
                  icon: const Icon(Icons.add_box),
                  onPressed: () {
                    Navigator.pushNamed(context, 'categoriaslistcreate');
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<List<Map<String, dynamic>>>(
              valueListenable: _filteredCategorias,
              builder: (BuildContext context, List<Map<String, dynamic>> categorias, Widget? child) {
                if (categorias.isNotEmpty) {
                  return ListView.builder(
                    itemCount: categorias.length,
                    itemBuilder: (BuildContext context, int index) {
                      final categoria = categorias[index];
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
                          title: Text(categoria['nombre']),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            color: const Color.fromARGB(255, 182, 30, 19),
                            onPressed: () {
                              _confirmDelete(categoria);
                            },
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              'categoriasedit',
                              arguments: {
                                'cat_id': categoria['cat_id'],
                                'nombre_categoria': categoria['nombre'],
                              },
                            );
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}