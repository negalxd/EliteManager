import 'package:flutter/material.dart';

class AddCategoryProductWidget extends StatefulWidget {
  const AddCategoryProductWidget({Key? key}) : super(key: key);

  @override
  _AddCategoryProductWidgetState createState() => _AddCategoryProductWidgetState();
}

class _AddCategoryProductWidgetState extends State<AddCategoryProductWidget> {
  final _formKey = GlobalKey<FormState>();

  String _categoriaProdName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Categoria'),
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
                    labelText: 'Nombre categoria',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 4, 75, 134)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese el nombre de la categoria';
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