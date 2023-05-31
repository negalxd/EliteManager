import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importante: Agregar esta línea
import 'package:elite_manager/pages/ventas/gestion_clientes_cotizaciones/gestion_clientes_item.dart';

class CotizacionesScreen extends StatefulWidget {
  final List<Map<String, dynamic>> productosSeleccionados;

  const CotizacionesScreen({required this.productosSeleccionados});

  @override
  _CotizacionesScreenState createState() => _CotizacionesScreenState();
}

class _CotizacionesScreenState extends State<CotizacionesScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredProductos = [];
  List<Map<String, dynamic>> _productosSeleccionados = [];

  @override
  void initState() {
    super.initState();
    _productosSeleccionados = widget.productosSeleccionados;
    _getProductos();
  }

  void _getProductos() {
    setState(() {
      _filteredProductos = _productosSeleccionados.toList();
    });
  }

  void _filterProductos(String query) {
    setState(() {
      _filteredProductos = _productosSeleccionados
          .where((producto) =>
              producto['nombre'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _crearCotizacion() {
    // Obtener los productos con sus cantidades correspondientes
    List<Map<String, dynamic>> cotizacion = _filteredProductos
        .where((producto) => producto['cantidad'] != null && producto['cantidad'] > 0)
        .map((producto) {
      return {
        'nombre': producto['nombre'],
        'precio': producto['precio'],
        'cantidad': producto['cantidad'],
      };
    }).toList();

    // Navegar a la siguiente vista y pasar la lista de productos de la cotización
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CotizacionItemCard(cotizacion: cotizacion),
      ),
    );
  }

  bool _isValidQuantity(String value) {
    final RegExp quantityRegExp = RegExp(r'^\d+$');
    return quantityRegExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos seleccionados'),
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
                    title: Text(producto['nombre']),
                    subtitle: Text('\$ ${producto['precio']}'),
                    trailing: Container(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ], // Utilizar solo dígitos
                        onChanged: (value) {
                          // Validar la cantidad ingresada
                          if (_isValidQuantity(value)) {
                            // Actualizar la cantidad del producto
                            setState(() {
                              producto['cantidad'] = int.parse(value);
                            });
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Cantidad',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _crearCotizacion,
            child: Text('Crear cotización'),
          ),
        ],
      ),
    );
  }
}