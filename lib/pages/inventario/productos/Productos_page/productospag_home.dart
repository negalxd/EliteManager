import 'package:flutter/material.dart';

class ProductPagScreen extends StatefulWidget {
  const ProductPagScreen({Key? key}) : super(key: key);

  @override
  _ProductPagScreen createState() => _ProductPagScreen();
}

class _ProductPagScreen extends State<ProductPagScreen> {
  List<String> _listItems = ['Completillo','Completoide','Estoy loco','Palta', 'Tomates','Ketchup', 'Mostaza', 'Item 8','Item 9','Item 10'];

  List<String> _filteredItems = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredItems = _listItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Productos'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, 'error');
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
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _filteredItems = _listItems
                      .where((item) =>
                          item.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                });
              },
              decoration: const InputDecoration(
                hintText: 'Buscar',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // Add logic for when the card is tapped
                  },
                  child: Card(
                    child: ListTile(
                      leading: const Icon(Icons.image),
                      title: Text(_filteredItems[index]),
                      subtitle: Text('Stock ${index + 1}'),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 100.0),
            child: ElevatedButton(
              onPressed: () {
                // Add logic to add a new item to the list here
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 255, 255, 255), backgroundColor: const Color.fromARGB(255, 4, 75, 134),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text('Agregar Producto'),
            ),
          ),
        ],
      ),
    );
  }
}