import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:elite_manager/pages/config.dart';

class ProductosScreen extends StatefulWidget {
  @override
  _ProductosScreenState createState() => _ProductosScreenState();
}

class _ProductosScreenState extends State<ProductosScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _productos = [];

  List<Map<String, dynamic>> _filteredProductos = [];


  @override
  void initState() {
    super.initState();
    _getProductos();
  }

  final utf8decoder = const Utf8Decoder();

  void _getProductos() async {
  final response = await http.get(Uri.parse('http://${Configuracion.apiurl}/Api/productos/'));
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

  void _confirmDelete(Map<String, dynamic> producto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Eliminar producto"),
          content: Text("¿Está seguro que desea eliminar el producto ${producto['nombre']}?, esta acción no se puede deshacer."),
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
                _deleteProducto(producto);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteProducto(Map<String, dynamic> producto) async {
  final response = await http.delete(Uri.parse('http://${Configuracion.apiurl}/Api/productos/${producto['producto_id']}/'));
  if (response.statusCode == 200) {
    setState(() {
      _productos.remove(producto);
      _filteredProductos = _productos;
    });
  //mostrar Snack de confirmacion de eliminacion
  // ignore: use_build_context_synchronously
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('El producto ${producto['nombre']} ha sido eliminado correctamente'),
      backgroundColor: Colors.red,
    ));
  } else {
    print('Error al eliminar el producto');
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('productos disponibles'),
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
              suffixIcon: IconButton(
                color: Color.fromARGB(255, 4, 75, 134),
                icon: const Icon(Icons.add_box),
                onPressed: () {
                  Navigator.pushNamed(context, 'productoscreate');
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredProductos.length,
            itemBuilder: (BuildContext context, int index) {
              final producto = _filteredProductos[index];
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
                  image: producto['imagen'] != null ? NetworkImage(producto['imagen']) : const AssetImage('assets/defaultproducto.jpg') as ImageProvider,
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
                ? Text('Precio: ${producto['precio']}')
                : Text(
                  'Precio: ${producto['precio']}',
                  style: const TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  color: const Color.fromARGB(255, 182, 30, 19),
                  onPressed: () {
                    _confirmDelete(producto);
                  },
                ),
                onTap: () {
                List<String> categoriasProd = List<String>.from(producto['categorias']);
                Navigator.pushNamed(context, 'productositem', arguments: {
                  'id_prod': producto['producto_id'],
                  'nombre_prod': producto['nombre'],
                  'descr_prod': producto['descripcion'],
                  'precio_prod': producto['precio'],
                  'categorias_prod': categoriasProd,
                  'imagen_prod': producto['imagen'],
                  'estado_prod': producto['estado'],
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