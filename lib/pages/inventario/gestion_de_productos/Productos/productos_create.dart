import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductWidget extends StatefulWidget {
  const AddProductWidget({Key? key}) : super(key: key);

  @override
  _AddProductWidgetState createState() => _AddProductWidgetState();
}

class _AddProductWidgetState extends State<AddProductWidget> {
  final _formKey = GlobalKey<FormState>();

  String _productName = '';
  String _description = '';
  int _precio = 0;
  String _categoria = '';

  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Insumo'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Card(
        margin: EdgeInsets.all(16),
        color: Color.fromARGB(255, 255, 255, 255),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_image != null) ...[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    height: 200,
                    child: Image.file(_image!, fit: BoxFit.cover, width: double.infinity),
                  ),
                  SizedBox(height: 16),
                ],
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: Icon(Icons.add_photo_alternate, size: 30, color: Color.fromARGB(255, 4, 75, 134),),
                  label: Text(
                    'Añadir imagen',
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 4, 75, 134),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
                
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nombre insumo',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 4, 75, 134)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese el nombre del insumo';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _productName = value!;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Descripción',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 4, 75, 134)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese una descripción';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _description = value!;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Precio',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 4, 75, 134)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese el precio';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _precio = int.parse(value!);
                  },
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Proveedor',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 4, 75, 134),
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 4, 75, 134), // Establece el color del texto del label a blanco
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor selecciona un proveedor';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _categoria= value!;
                    });
                  },
                  onSaved: (value) {
                    _categoria = value!;
                  },
                  items: ['KFC', 'Fortnite'].map((provider) {
                    return DropdownMenuItem<String>(
                      value: provider,
                      child: Text(provider),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // TODO: Save the product to the database
                    }
                  },
                  style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 4, 75, 134)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}

