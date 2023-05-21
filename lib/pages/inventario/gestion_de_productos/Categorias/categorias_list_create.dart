import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:elite_manager/pages/config.dart';

class AddCategoryProductWidget extends StatefulWidget {
  const AddCategoryProductWidget({Key? key}) : super(key: key);

  @override
  _AddCategoryProductWidgetState createState() => _AddCategoryProductWidgetState();
}

class _AddCategoryProductWidgetState extends State<AddCategoryProductWidget> {
  final _formKey = GlobalKey<FormState>();

  String _categoriaProdName = '';




void _addCategoria() async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();

    final response = await http.post(Uri.parse('http://${Configuracion.apiurl}/Api/producto-categorias/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nombre': _categoriaProdName,
      }));

    // Eliminar contexto para que no se pueda regresar a la pantalla anterior
    Navigator.of(context).pop();
    Navigator.pushReplacementNamed(context, 'categorias'); // Utilizar pushReplacementNamed en lugar de pushNamed

    final responseData = jsonDecode(response.body);
    print(responseData);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Categoría'),
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
                    _addCategoria();
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


