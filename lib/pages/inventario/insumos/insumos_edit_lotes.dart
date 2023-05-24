import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:elite_manager/pages/config.dart';

class EditLotesWidget extends StatefulWidget {
  const EditLotesWidget({Key? key}) : super(key: key);

  @override
  _EditLotesWidgetState createState() => _EditLotesWidgetState();
}

class _EditLotesWidgetState extends State<EditLotesWidget> {
  final _formKey = GlobalKey<FormState>();

  int loteID = 0;
  int insumoID = 0;
  String n_lote = '';
  int stock = 0;
  String comentarios = '';
  String fecha_vencimiento = '';
  final _commentsController = TextEditingController();

  final _expiryDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _commentsController.text = comentarios;
    _expiryDateController.text = '';
  }

  @override
  void dispose() {
    _commentsController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchLoteID();
  }

  Future<void> _fetchLoteID() async {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (arguments != null && arguments.containsKey('id_lote')) {
      setState(() {
        loteID = int.parse(arguments['id_lote'].toString());
      });
      await _getLoteRequest(); // Obtener los datos del lote al cargar la pantalla de edición
    }
  }

  Future<void> _getLoteRequest() async {
  final url = 'http://${Configuracion.apiurl}/Api/lotes-insumos/$loteID/';
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData != null) {
        setState(() {
          n_lote = responseData['n_lote'];
          stock = responseData['stock'];
          comentarios = responseData['comentarios'];
          fecha_vencimiento = responseData['fecha_vencimiento'];
          insumoID = responseData['insumo'];

          // Establecer la fecha de caducidad en el controlador correspondiente
          _expiryDateController.text = fecha_vencimiento;

          // Actualizar el valor del controlador de comentarios
          _commentsController.text = comentarios;
        });
      }
    } else {
      print('Error en la solicitud GET: ${response.statusCode}');
    }
  } catch (error) {
    print('Error en la solicitud GET: $error');
  }
}

  Future<void> _sendPutRequest() async {
    final url = 'http://${Configuracion.apiurl}/Api/lotes-insumos/$loteID/';
    final data = {
      "stock": stock,
      "comentarios": comentarios,
      "insumo": insumoID,
    };
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Éxito en la solicitud PUT
        print('Solicitud PUT exitosa');
        // Volver a la lista y actualizarla
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lote actualizado correctamente'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
        Navigator.pushReplacementNamed(context, 'insumositemlote', arguments: {'id_insumo': insumoID});
      } else {
        // Error en la solicitud PUT
        print('Error en la solicitud PUT: ${response.statusCode}');
      }
    } catch (error) {
      print('Error en la solicitud PUT: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar Lote $n_lote'),
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
                    controller: TextEditingController(text: stock.toString()),
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
                      setState(() {
                        stock = int.parse(value!);
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _expiryDateController,
                    decoration: InputDecoration(
                      labelText: 'Fecha de caducidad',
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true, // Desactivar la edición manual de la fecha
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _commentsController,
                    decoration: InputDecoration(
                      labelText: 'Comentarios',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 4, 75, 134)),
                      ),
                    ),
                    validator: (value) {
                      // Puedes personalizar las validaciones según tus necesidades
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        comentarios = value!;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _sendPutRequest(); // Llamar a la función para enviar la solicitud PUT
                      }
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
