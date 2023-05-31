import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
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

class AddLotesWidget extends StatefulWidget {
  const AddLotesWidget({Key? key}) : super(key: key);

  @override
  _AddLotesWidgetState createState() => _AddLotesWidgetState();
}

class _AddLotesWidgetState extends State<AddLotesWidget> {
   final _formKey = GlobalKey<FormState>();

  int insumoId = 0;
  int stock = 0;
  String nombreInsumo = '';
  String fecha_vencimiento = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchInsumoId();
  }

  Future<void> _fetchInsumoId() async {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (arguments != null && arguments.containsKey('id_insumo') && arguments.containsKey('nombre_insumo')) {
      setState(() {
        insumoId = int.parse(arguments['id_insumo'].toString());
        nombreInsumo = arguments['nombre_insumo'].toString();
      });
    }
  }

  Future<void> _sendPostRequest() async {
    final url = 'http://${Configuracion.apiurl}/Api/lotes-insumos/'; 
    final data = {
      "stock": stock,
      "fecha_vencimiento": DateFormat('yyyy-MM-dd').format(DateTime.parse(fecha_vencimiento)),
      "insumo": insumoId
    };
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        // Éxito en la solicitud POST
        print('Solicitud POST exitosa');
        //volver a la lista y que este actualizada
        //Snack de confirmacion de creacion
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lote creado correctamente'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
        Navigator.pushReplacementNamed(context, 'insumositemlote', arguments: {'id_insumo': insumoId, 'nombre_insumo': nombreInsumo});


      } else {
        // Error en la solicitud POST
        print('Error en la solicitud POST: ${response.statusCode}');
      }
    } catch (error) {
      print('Error en la solicitud POST: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Lote'),
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
                      labelText: 'Stock del lote',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 4, 75, 134)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese el stock del lote';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      stock = int.parse(value!);
                    },
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                  onTap: () => _selectExpiryDate(context),
                  child: AbsorbPointer(
                  child: TextFormField(
                    controller: _expiryDateController,
                    decoration: InputDecoration(
                      labelText: 'Fecha de caducidad',
                      border: OutlineInputBorder(),
                    ),
                    onTap: () => _selectExpiryDate(context),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese la fecha de caducidad';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      fecha_vencimiento = value!;
                    },
                  ),
                ),  
                ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _sendPostRequest(); // Llamar a la función para enviar la solicitud POST
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