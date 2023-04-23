// import 'package:flutter/material.dart';

// class SuppliesScreen extends StatefulWidget {
//   const SuppliesScreen({Key? key}) : super(key: key);

//   @override
//   _SuppliesScreenState createState() => _SuppliesScreenState();
// }

// class _SuppliesScreenState extends State<SuppliesScreen> {
//   List<String> _listItems = ['Salchichas','Panes','Papitas','Palta', 'Tomates','Ketchup', 'Mostaza', 'Item 8','Item 9','Item 10'];

//   List<String> _filteredItems = [];

//   TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _filteredItems = _listItems;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Gestión de Insumos'),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.person),
//             onPressed: () {
//               Navigator.pushNamed(context, 'error');
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//                    Container(
//             margin: const EdgeInsets.only(bottom: 10.0),
//             padding: const EdgeInsets.all(10.0),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _searchController,
//                     onChanged: (value) {
//                       setState(() {
//                         _filteredItems = _listItems
//                             .where((item) =>
//                                 item.toLowerCase().contains(value.toLowerCase()))
//                             .toList();
//                       });
//                     },
//                     decoration: InputDecoration(
//                       hintText: 'Buscar',
//                       prefixIcon: Icon(Icons.search),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.clear),
//                   onPressed: () {
//                     setState(() {
//                       _searchController.text = '';
//                       _filteredItems = _listItems;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _filteredItems.length,
//               itemBuilder: (context, index) {
//                 return InkWell(
//                   onTap: () {
//                     Navigator.pushNamed(context, 'insumoslist');
//                   },
//                   child: Card(
//                     margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
//                     child: ListTile(
//                       leading: Container(
//                         width: 50.0,
//                         child: Image.asset('assets/gestionProd.png'),
//                       ),
//                       title: Text(_filteredItems[index]),
//                       subtitle: Text('Stock del insumo ${index + 1}'),
//                     ),
//                   ),
//                 );
//               },
//             ),  
//           ),
//           Container(
//             width: double.infinity,
//             margin: const EdgeInsets.symmetric(horizontal: 100.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, 'insumoslistcreate');
//               },
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: const Color.fromARGB(255, 255, 255, 255), backgroundColor: const Color.fromARGB(255, 4, 75, 134),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//               ),
//               child: const Text('Agregar Categoria'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }