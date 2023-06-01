import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:elite_manager/pages/config.dart';

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
  List<String> selectedCategories = [];
  List<Map<String, dynamic>> allCategories = [];

  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  final utf8decoder = const Utf8Decoder();

  Future<void> _fetchCategories() async {
    final response = await http.get(
      Uri.parse('http://${Configuracion.apiurl}/Api/producto-categorias/'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> categoriesData =
          jsonDecode(utf8decoder.convert(response.bodyBytes));

      setState(() {
        allCategories = categoriesData
            .map((category) => Map<String, dynamic>.from(category))
            .toList();
      });
    } else {
      print('Error al obtener las categorías');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir producto'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.all(16),
          color: Color.fromARGB(255, 255, 255, 255),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
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
                      child: Image.file(
                        _image!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: Icon(
                      Icons.add_photo_alternate,
                      size: 30,
                      color: Color.fromARGB(255, 4, 75, 134),
                    ),
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
                      labelText: 'Nombre producto',
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 4, 75, 134)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese el nombre del producto';
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
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 4, 75, 134)),
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
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 4, 75, 134)),
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
                  Wrap(
                    children: allCategories.isNotEmpty
                        ? allCategories.map((category) {
                            final categoryName =
                                category['nombre'].toString();
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: FilterChip(
                                label: Text(categoryName),
                                selected: selectedCategories
                                    .contains(categoryName),
                                onSelected: (isSelected) {
                                  setState(() {
                                    if (isSelected) {
                                      selectedCategories.add(categoryName);
                                    } else {
                                      selectedCategories.remove(categoryName);
                                    }
                                  });
                                },
                              ),
                            );
                          }).toList()
                        : [
                            Text('No existen categorías creadas.'),
                          ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        _addProduct(
                          _productName,
                          _precio,
                          _description,
                          selectedCategories,
                          _image, // Agregar la imagen al método
                        );

                        _formKey.currentState!.reset();
                        setState(() {
                          _image = null;
                          selectedCategories.clear();
                        });
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 4, 75, 134)),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
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

void _addProduct(
  String nombre,
  int precio,
  String descripcion,
  List<String> categorias,
  File? imagen,
) async {
  var url = Uri.parse('http://${Configuracion.apiurl}/Api/productos/');
  var request = http.MultipartRequest('POST', url);

  request.fields['nombre'] = nombre;
  request.fields['precio'] = precio.toString();
  request.fields['estado'] = true.toString();
  request.fields['descripcion'] = descripcion;

  // Agregar categorías individualmente
  // Agregar categorías individualmente
  for (var i = 0; i < categorias.length; i++) {
    request.fields['categorias[$i]'] = categorias[i]; // deberia ser asi request.fields['categorias[$i]'] = categorias[i];
  }

  if (imagen != null) {
    var stream = http.ByteStream(Stream.castFrom(imagen.openRead()));
    var length = await imagen.length();

    var multipartFile = http.MultipartFile(
      'imagen',
      stream,
      length,
      filename: imagen.path.split('/').last,
    );

    request.files.add(multipartFile);
  }

  print('Aquí está la solicitud que se envía:');
  print(request);

  var response = await request.send();

  if (response.statusCode == 201) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('El producto $nombre ha sido añadido correctamente'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.of(context).pop();
    Navigator.pushReplacementNamed(context, 'productospag');
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error al añadir el producto'),
        backgroundColor: Colors.red,
      ),
    );
    print('Error al añadir el producto');
  }
}
}
