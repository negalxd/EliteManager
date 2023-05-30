import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:elite_manager/pages/config.dart';
import 'package:elite_manager/pages/ventas/gestion_clientes_cotizaciones/gestion_clientes_cotizacion.dart';

class CotizacionesProductScreen extends StatefulWidget {
  @override
  _CotizacionesProductScreenState createState() =>
      _CotizacionesProductScreenState();
}

class _CotizacionesProductScreenState
    extends State<CotizacionesProductScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _productos = [];
  List<Map<String, dynamic>> _filteredProductos = [];
  List<Map<String, dynamic>> _selectedProductos = [];

  @override
  void initState() {
    super.initState();
    _getProductos();
  }

  final utf8decoder = const Utf8Decoder();

  void _getProductos() async {
    final response = await http
        .get(Uri.parse('http://${Configuracion.apiurl}/Api/productos-list/'));
    final List<dynamic> responseData =
        json.decode(utf8decoder.convert(response.bodyBytes));
    setState(() {
      _productos = responseData.cast<Map<String, dynamic>>();
      _filteredProductos = _productos.toList();
    });
    print(_filteredProductos);
  }

  void _filterProductos(String query) {
    setState(() {
      _filteredProductos = _productos
          .where((producto) =>
              producto['nombre'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _crearCotizacion() {
    if (_selectedProductos.isNotEmpty) {
      final List<Map<String, dynamic>> productosSeleccionados = List<Map<String, dynamic>>.from(_selectedProductos);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CotizacionesScreen(
            productosSeleccionados: productosSeleccionados,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos disponibles'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterProductos,
              decoration: InputDecoration(
                hintText: 'Buscar productos',
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredProductos.length,
              itemBuilder: (BuildContext context, int index) {
                final producto = _filteredProductos[index];
                final bool isSelected = _selectedProductos.contains(producto);
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
                        placeholder:
                            const AssetImage('assets/Loading_icon.gif'),
                        image: producto['imagen'] != null
                            ? NetworkImage(producto['imagen'])
                            : const AssetImage('assets/defaultproducto.jpg')
                                as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: producto['estado'] == true
                        ? Text(producto['nombre'])
                        : Text(
                            producto['nombre'],
                            style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                    subtitle: producto['estado'] == true
                        ? Text('\$ ${producto['precio']}')
                        : Text('\$ ${producto['precio']} (No disponible)',
                            style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            )),
                    trailing: IconButton(
                      icon: isSelected
                          ? const Icon(Icons.check_box)
                          : const Icon(Icons.check_box_outline_blank),
                      onPressed: () {
                        setState(() {
                          if (isSelected) {
                            _selectedProductos.remove(producto);
                          } else {
                            _selectedProductos.add(producto);
                          }
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _crearCotizacion,
        icon: const Icon(Icons.add),
        label: const Text('Crear cotización'),
        backgroundColor:
            _selectedProductos.isNotEmpty ? Colors.blue : Colors.grey,
      ),
    );
  }
}