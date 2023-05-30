import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:elite_manager/pages/config.dart';

class CotizacionesScreen extends StatefulWidget {
  @override
  _CotizacionesScreenState createState() => _CotizacionesScreenState();
}

class _CotizacionesScreenState extends State<CotizacionesScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _productos = [];
  List<Map<String, dynamic>> _filteredProductos = [];
  Map<int, int> _selectedProductos = {};

  @override
  void initState() {
    super.initState();
    _getProductos();
  }

  final utf8decoder = const Utf8Decoder();

  void _getProductos() async {
    final response = await http.get(Uri.parse('http://${Configuracion.apiurl}/Api/productos-list/'));
    final List<dynamic> responseData = json.decode(utf8decoder.convert(response.bodyBytes));
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
              producto['nombre']
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  void _crearCotizacion() {
    // Aquí puedes realizar cualquier acción con los productos seleccionados
    for (var entry in _selectedProductos.entries) {
      int productId = entry.key;
      int quantity = entry.value;
      Map<String, dynamic> producto = _productos.firstWhere((prod) => prod['id'] == productId);
      print('Producto: ${producto['nombre']}, Cantidad: $quantity');
      // Realizar las acciones que necesites con cada producto y su cantidad
    }
    // Restablecer la lista de productos seleccionados
    setState(() {
      _selectedProductos = {};
    });

    // Navegar a la pantalla de crear cotización
    Navigator.pushNamed(context, 'crearcliente');
  }

  void _setCantidad(int productId, String value) {
    final cantidad = int.tryParse(value) ?? 0;
    if (cantidad >= 0) {
      setState(() {
        _selectedProductos[productId] = cantidad;
      });
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
                final bool isSelected = _selectedProductos.containsKey(producto['id']);
                int selectedQuantity = _selectedProductos[producto['id']] ?? 0;
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
                        image: producto['imagen'] != null
                            ? NetworkImage(producto['imagen'])
                            : const AssetImage('assets/defaultproducto.jpg') as ImageProvider,
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
                        ? Text('Precio: \$ ${producto['precio']}')
                        : Text(
                            'Precio: \$ ${producto['precio']}',
                            style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 40,
                          child: TextFormField(
                            initialValue: selectedQuantity.toString(),
                            keyboardType: TextInputType.number,
                            onChanged: (value) => _setCantidad(producto['id'], value),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 4),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Aquí puedes realizar acciones adicionales al hacer clic en un producto
                      // List<String> categoriasProd = List<String>.from(producto['categorias']);
                      // Navigator.pushNamed(context, 'productositem', arguments: {
                      //   'id_prod': producto['producto_id'],
                      //   'nombre_prod': producto['nombre'],
                      //   'descr_prod': producto['descripcion'],
                      //   'precio_prod': producto['precio'],
                      //   'categorias_prod': categoriasProd,
                      //   'imagen_prod': producto['imagen'],
                      //   'estado_prod': producto['estado'],
                      // });
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _selectedProductos.isNotEmpty ? _crearCotizacion : null,
            child: const Text('Crear cotización'),
          ),
        ],
      ),
    );
  }
}