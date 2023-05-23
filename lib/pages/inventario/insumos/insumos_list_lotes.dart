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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchProductoName();
    _fetchLotesInsumos();
  }

  Future<void> _fetchProductoName() async {
  final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
  if (arguments != null && arguments.containsKey('insumoId')) {
    setState(() {
      insumoId = int.parse(arguments['insumoId'].toString());
    });
  }
}

  Future<void> _fetchLotesInsumos() async {
    final response = await http.get(Uri.parse('http://${Configuracion.apiurl}/lotes-insumos/lotes/$insumoId/'));
    final List<dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));
    setState(() {
      _lotesInsumos = responseData.cast<Map<String, dynamic>>();
      _filteredLotesInsumos = _lotesInsumos.toList();
    });
  }

  void _filterLotesInsumos(String query) {
    setState(() {
      _filteredLotesInsumos = _lotesInsumos
          .where((loteInsumo) =>
              loteInsumo['n_lote'].toLowerCase().contains(query.toLowerCase()) ||
              loteInsumo['stock'].toString().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lotes Insumos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, 'profile');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterLotesInsumos,
                    decoration: const InputDecoration(
                      hintText: 'Buscar',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _searchController.text = '';
                      _filteredLotesInsumos = _lotesInsumos;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredLotesInsumos.length,
              itemBuilder: (context, index) {
                final loteInsumo = _filteredLotesInsumos[index];
                return InkWell(
                  onTap: () {
                    // Acción a realizar al hacer clic en un loteInsumo
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: ListTile(
                      leading: Container(
                        width: 50.0,
                        child: Image.asset('assets/vianesas.png'),
                      ),
                      title: Text(loteInsumo['n_lote']),
                      subtitle: Text('Stock: ${loteInsumo['stock']}'),
                    ),
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