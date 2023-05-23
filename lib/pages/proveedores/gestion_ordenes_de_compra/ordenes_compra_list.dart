import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:elite_manager/pages/config.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _Orders = [];
  List<Map<String, dynamic>> _filteredOrders = [];

  @override
  void initState() {
    super.initState();
    _getOrders();
  }

  final utf8decoder = const Utf8Decoder();

  void _getOrders() async {
    final response = await http.get(Uri.parse('http://${Configuracion.apiurl}/Api/ordenes-compra/'));
    final List<dynamic> responseData = json.decode(utf8decoder.convert(response.bodyBytes));
    setState(() {
      _Orders = responseData.cast<Map<String, dynamic>>();
      _filteredOrders = _Orders.toList();
    });
    print(_filteredOrders);
  }

  void _filterOrders(String query) {
    setState(() {
      _filteredOrders = _Orders
          .where((Orders) =>
              Orders['proveedor_nombre']
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              Orders['proveedor_email']
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

Widget _buildCardSubtitle(Map<String, dynamic> order) {
  final isActive = order['estado'] == true;
  final color = isActive ? Colors.green : Color.fromARGB(255, 219, 140, 37);
  final statusText = isActive ? 'Orden Terminada' : 'Orden en proceso';
  
  return Row(
    children: [
      Icon(
        Icons.circle,
        color: color,
        size: 12.0,
      ),
      const SizedBox(width: 4.0),
      Text(
        statusText,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordenes de compra'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterOrders,
              decoration: InputDecoration(
                hintText: 'Buscar Ordenes',
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredOrders.length,
              itemBuilder: (BuildContext context, int index) {
                final order = _filteredOrders[index];
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
                        image: order['proveedor_image'] != null ? NetworkImage(order['proveedor_image']) : const AssetImage('assets/defaultproducto.jpg') as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(order['proveedor_nombre']),
                    subtitle: _buildCardSubtitle(order),
                    onTap: () {},
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