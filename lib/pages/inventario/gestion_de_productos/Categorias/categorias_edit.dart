import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:elite_manager/pages/config.dart';

class EditCategoryProductWidget extends StatefulWidget {
  const EditCategoryProductWidget({Key? key}) : super(key: key);

  @override
  _EditCategoryProductWidgetState createState() => _EditCategoryProductWidgetState();
}

class _EditCategoryProductWidgetState extends State<EditCategoryProductWidget> {
  final _formKey = GlobalKey<FormState>();
  String idcategoria = '';
  String _categoriaNameActual = '';

  Future<String> _fetchCategoriaName() async {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (arguments != null && arguments.containsKey('producto_id') && arguments.containsKey('nombre_categoria')) {
      idcategoria = arguments['producto_id'].toString();
      _categoriaNameActual = arguments['nombre_categoria'].toString();
      print(idcategoria);
      print(_categoriaNameActual);
    }
    return _categoriaNameActual;
  }

  String _categoriaProdName = '';

  void _updateCategoria() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final response = await http.put(Uri.parse('http://${Configuracion.apiurl}/Api/producto-categorias/$idcategoria/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nombre': _categoriaProdName,
        }));

      Navigator.of(context).pop();
      Navigator.pushNamed(context, 'categorias');

      final responseData = jsonDecode(response.body);
      print(responseData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: _fetchCategoriaName(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Cargando...');
            } else if (snapshot.hasData) {
              return Text('Actualizar categoría: ${snapshot.data}');
            } else {
              return Text('Actualizar categoría');
            }
          },
        ),
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
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nombre categoría',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 4, 75, 134)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese el nombre de la categoría';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _categoriaProdName = value!;
                    },
                  ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _updateCategoria();
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 4, 75, 134)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text('Actualizar'),
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