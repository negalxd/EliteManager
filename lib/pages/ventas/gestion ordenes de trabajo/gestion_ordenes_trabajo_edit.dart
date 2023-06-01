import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:elite_manager/pages/config.dart';

class EditOrdenesWidget extends StatefulWidget {
  const EditOrdenesWidget({Key? key}) : super(key: key);

  @override
  _EditOrdenesWidgetState createState() => _EditOrdenesWidgetState();
}

class _EditOrdenesWidgetState extends State<EditOrdenesWidget> {
  final _formKey = GlobalKey<FormState>();

  String idot = '';
  String codot = '';
  String _prioridad = '';
  String tipoOT = '';
  String equipo = '';
  String resumen = '';
  DateTime? fechaObjetivo;
  String creacionot = '';
  bool statusot = false;
  String resumenot = '';

  TextEditingController _expiryDateController = TextEditingController(); // Controlador para el campo de fecha

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchOrdenName();
  }

  Future<String> _fetchOrdenName() async {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (arguments != null &&
        arguments.containsKey('id_ot') &&
        arguments.containsKey('cod_ot') &&
        arguments.containsKey('prioridad_ot') &&
        arguments.containsKey('tipo_ot') &&
        arguments.containsKey('equipo_ot') &&
        arguments.containsKey('fecha_ot') &&
        arguments.containsKey('created_ot') &&
        arguments.containsKey('estado_ot') &&
        arguments.containsKey('resumen_ot')) {
      idot = arguments['id_ot'].toString();
      codot = arguments['cod_ot'].toString();
      _prioridad = arguments['prioridad_ot'].toString();
      tipoOT = arguments['tipo_ot'].toString();
      equipo = arguments['equipo_ot'].toString();
      fechaObjetivo = DateTime.parse(arguments['fecha_ot']);
      creacionot = arguments['created_ot'].toString();
      statusot = arguments['estado_ot'] as bool;
      resumen = arguments['resumen_ot'].toString();
    }
    return _prioridad;
  }

  @override
  void dispose() {
    _expiryDateController.dispose(); // Liberar el controlador al salir del widget
    super.dispose();
  }

  Future<void> _selectExpiryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaObjetivo ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        fechaObjetivo = picked;
        _expiryDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Orden $codot'),
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
                        borderSide: BorderSide(color: Color.fromARGB(255, 4, 75, 134)),
                      ),
                    ),
                    value: _prioridad, // Valor seleccionado actualmente
                    items: [
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
                  DropdownButtonFormField<bool>(
                    decoration: InputDecoration(
                      labelText: 'Establecer Estado',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 4, 75, 134)),
                      ),
                    ),
                    value: statusot, // Valor seleccionado actualmente
                    items: [
                      DropdownMenuItem(
                        value: true,
                        child: Text('En proceso'),
                      ),
                      DropdownMenuItem(
                        value: false,
                        child: Text('Terminada'),
                      ),
                    ],
                    validator: (value) {
                      if (value == null) {
                        return 'Por favor seleccione un estado';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        statusot = value!;
                      });
                    },
                    onSaved: (value) {
                      statusot = value!;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Tipo de Orden de Trabajo',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 4, 75, 134)),
                      ),
                    ),
                    initialValue: tipoOT, // Establecer el valor inicial del campo
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
                      onTap: () => _selectExpiryDate(context), // Cambio: Agregar onTap para mostrar el selector de fecha
                    ),
                  ),
                  ),
                  Text('Fecha de creación: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(creacionot))}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Equipo',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 4, 75, 134)),
                      ),
                    ),
                    initialValue: equipo, // Establecer el valor inicial del campo
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
                        borderSide: BorderSide(color: Color.fromARGB(255, 4, 75, 134)),
                      ),
                    ),
                    initialValue: resumen, // Establecer el valor inicial del campo
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
                        _updateOrdenes();
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

  Future<void> _updateOrdenes() async {
    final apiUrl = 'http://${Configuracion.apiurl}/Api/ordenes-trabajo/$idot/';

    final body = {
      'prioridad': _prioridad,
      'tipo': tipoOT,
      'equipo': equipo,
      'fecha_objetivo': DateFormat('yyyy-MM-dd').format(fechaObjetivo!),
      'resumen': resumen,
      'estado': statusot,
    };
print('Request Body: $body');
    final response = await http.put(
      Uri.parse(apiUrl),
      headers:{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
print('Response code: ${response.statusCode}');
print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      // Orden actualizada exitosamente
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, 'gestionOrdenes');
      //snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Orden de Trabajo Actualizada correctamente'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // Error al actualizar la orden
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al actualizar la Orden de Trabajo'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
