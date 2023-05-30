import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:elite_manager/pages/config.dart';

class VentasListWidget extends StatefulWidget {
  @override
  _VentasListWidgetState createState() => _VentasListWidgetState();
}

class _VentasListWidgetState extends State<VentasListWidget> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _ventas = [];
  List<Map<String, dynamic>> _filteredVentas = [];

  @override
  void initState() {
    super.initState();
    _getVentas();
  }

  void _getVentas() async {
    final response = await http.get(Uri.parse('http://${Configuracion.apiurl}/Api/ventas/'));
    final List<dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));
    setState(() {
      _ventas = responseData.cast<Map<String, dynamic>>();
      _filteredVentas = _ventas.toList();
    });
    print(_filteredVentas);
  }

  void _filterVentas(String query) {
    setState(() {
      _filteredVentas = _ventas
          .where((ventas) =>
              ventas['cod_venta'].toLowerCase().contains(query.toLowerCase()) ||
              ventas['caja'].toString().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Ventas'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterVentas,
              decoration: const InputDecoration(
                hintText: 'Buscar Ventas',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredVentas.length,
              itemBuilder: (BuildContext context, int index) {
                final ventas = _filteredVentas[index];
                List<Map<String, dynamic>> productosVenta =
                    List<Map<String, dynamic>>.from(ventas['producto_items']);

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
                    title: Text(ventas['cod_venta']),
                    subtitle: RichText(
                      text: TextSpan(
                        text: '${ventas['fecha_venta']}\n',
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Caja: ',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          TextSpan(
                            text: '${ventas['caja']}',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        'ventasitem',
                        arguments: {
                          'id_ven': ventas['id'],
                          'cod_ven': ventas['cod_venta'],
                          'prod_ven': productosVenta,
                          'fecha_ven': ventas['fecha_venta'],
                          'total_ven': ventas['total_venta'],
                          'caja_ven': ventas['caja'],
                        },
                      );
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
