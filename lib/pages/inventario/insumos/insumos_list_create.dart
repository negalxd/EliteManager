// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';


// class AddCategoryInsumoWidget extends StatefulWidget {
//   const AddCategoryInsumoWidget({Key? key}) : super(key: key);

//   @override
//   _AddCategoryInsumoWidgetState createState() => _AddCategoryInsumoWidgetState();
// }

// class _AddCategoryInsumoWidgetState extends State<AddCategoryInsumoWidget> {
//   final _formKey = GlobalKey<FormState>();

//   String _categoriaName = '';


//   File? _image;

//   Future<void> _pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

//     setState(() {
//       _image = File(pickedFile!.path);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Añadir Categoria Insumo'),
//         centerTitle: true,
//       ),
//       resizeToAvoidBottomInset: true,
//       body: SingleChildScrollView(
//         child: Card(
//         margin: EdgeInsets.all(16),
//         color: Color.fromARGB(255, 255, 255, 255),
//         elevation: 8,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         child: Padding(
//           padding: EdgeInsets.all(16),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 if (_image != null) ...[
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: Colors.white,
//                     ),
//                     height: 200,
//                     child: Image.file(_image!, fit: BoxFit.cover, width: double.infinity),
//                   ),
//                   SizedBox(height: 16),
//                 ],
//                 ElevatedButton.icon(
//                   onPressed: _pickImage,
//                   icon: Icon(Icons.add_photo_alternate, size: 30, color: Color.fromARGB(255, 4, 75, 134),),
//                   label: Text(
//                     'Añadir imagen',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: const Color.fromARGB(255, 4, 75, 134),
//                     ),
//                   ),
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all<Color>(
//                       Color.fromARGB(255, 255, 255, 255),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Nombre categoria',
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(color: Color.fromARGB(255, 4, 75, 134)),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Por favor ingrese el nombre de la categoria';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _categoriaName = value!;
//                   },
//                 ),
//                 SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _formKey.currentState!.save();
//                       // TODO: Save the product to the database
//                     }
//                   },
//                   style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 4, 75, 134)),
//                   foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//                   ),
//                   child: Text('Guardar'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       ),
//     );
//   }
// }