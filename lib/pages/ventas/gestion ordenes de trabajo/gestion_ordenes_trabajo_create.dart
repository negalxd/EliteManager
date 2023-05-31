import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:elite_manager/pages/config.dart';


final _expiryDateController = TextEditingController();

Future<void> _selectExpiryDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(Duration(days: 365)),
  );
  if (picked != null) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(picked); // Formatear la fecha en el formato deseado
    _expiryDateController.text = formattedDate;
  } else {
    _expiryDateController.text = '';
  }
}



class AddOrdenesWidget extends StatefulWidget {
  const AddOrdenesWidget({Key? key}) : super(key: key);

  @override
  _AddOrdenesWidgetState createState() => _AddOrdenesWidgetState();
}

class _AddOrdenesWidgetState extends State<AddOrdenesWidget> {
  final _formKey = GlobalKey<FormState>();

  String _prioridad = '';
  String tipoOT = '';
  String equipo = '';
  String resumen = '';
  String fechaObjetivo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Orden de Trabajo'),
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
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Establecer Prioridad',
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 4, 75, 134)),
                      ),
                    ),
                    value: _prioridad, // Valor seleccionado actualmente
                    items: [
                      DropdownMenuItem(
                        value: '',
                        child: Text('Por favor seleccione una prioridad'),
                      ),
                      DropdownMenuItem(
                        value: 'Alta',
                        child: Text('Alta'),
                      ),
                      DropdownMenuItem(
                        value: 'Media',
                        child: Text('Media'),
                      ),
                      DropdownMenuItem(
                        value: 'Baja',
                        child: Text('Baja'),
                      ),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor seleccione una prioridad';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _prioridad = value!;
                      });
                    },
                    onSaved: (value) {
                      _prioridad = value!;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Tipo de Orden de Trabajo',
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 4, 75, 134)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese un tipo de orden de trabajo';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      tipoOT = value!;
                    },
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                  onTap: () => _selectExpiryDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: _expiryDateController,
                      decoration: InputDecoration(
                        labelText: 'Fecha Objetivo (Límite)',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor ingrese la fecha objetivo';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        fechaObjetivo = value!;
                      },
                    ),
                  ),
                ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Equipo',
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 4, 75, 134)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese el equipo';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      equipo = value!;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Resumen',
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 4, 75, 134)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese el resumen';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      resumen = value!;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        _addOrden(
                          _prioridad,
                          tipoOT,
                          equipo,
                          resumen,
                          fechaObjetivo,
                        );
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

  Future<void> _addOrden(
      String prioridad, String tipoOT, String equipo, String resumen, String fechaObjetivo) async {
    final response = await http.post(
      Uri.parse('http://${Configuracion.apiurl}/Api/ordenes-trabajo/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "prioridad": prioridad,
        "tipo": tipoOT,
        "equipo": equipo,
        "fecha_objetivo": fechaObjetivo,
        "resumen": resumen,
      }),
    );

    if (response.statusCode == 201) {
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, 'gestionOrdenes');
      //snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Orden de Trabajo creada correctamente'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      //snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al crear la Orden de Trabajo'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
