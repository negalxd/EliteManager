import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:elite_manager/pages/config.dart';

class ProviderItemCard extends StatefulWidget {
  const ProviderItemCard({Key? key}) : super(key: key);

  @override
  _ProviderItemCardState createState() => _ProviderItemCardState();
}

class _ProviderItemCardState extends State<ProviderItemCard> {
  bool isLoading = false;
  late String idproveedor;
  late String _nameproveedor;
  late String phoneproveedor;
  late String imageUrl;
  late String emailproveedor;
  late bool statusproveedor;
  late Stream<bool> statusStream;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchProveedorName();
    statusStream = _getStatusStream();
  }

  Future<String> _fetchProveedorName() async {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (arguments != null &&
        arguments.containsKey('id_prov') &&
        arguments.containsKey('nombre_prov') &&
        arguments.containsKey('phone_prov') &&
        arguments.containsKey('email_prov') &&
        arguments.containsKey('image_prov') &&
        arguments.containsKey('estado_prov')) {
      idproveedor = arguments['id_prov'].toString();
      _nameproveedor = arguments['nombre_prov'].toString();
      phoneproveedor = arguments['phone_prov'].toString();
      emailproveedor = arguments['email_prov'].toString();
      imageUrl = arguments['image_prov'].toString();
      statusproveedor = arguments['estado_prov'] as bool;
    }
    return _nameproveedor;
  }

  Stream<bool> _getStatusStream() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 5)); // Actualizar cada 5 segundos
      yield await _fetchProveedorStatus();
    }
  }

  Future<bool> _fetchProveedorStatus() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://${Configuracion.apiurl}/Api/proveedores/$idproveedor/'),
        headers: {'Content-Type': 'application/json'},
      );

      final responseData = jsonDecode(response.body);
      print(responseData);

      final newProveedorStatus = responseData['estado'] as bool?;
      return newProveedorStatus ?? false;
    } catch (error) {
      // Manejar el error de la API
      print(error);
      return statusproveedor;
    }
  }

  Future<void> _updateProveedorStatus(bool newStatus) async {
    try {
      final response = await http.put(
        Uri.parse(
            'http://${Configuracion.apiurl}/Api/proveedores/$idproveedor/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'estado': newStatus,
        }),
      );

      final responseData = jsonDecode(response.body);

      final newProveedorStatus = responseData['estado'] as bool?;
      if (newProveedorStatus != null) {
        setState(() {
          statusproveedor = newProveedorStatus;
        });
      }
    } catch (error) {
      // Manejar el error de la API
      print(error);
      // Mostrar un mensaje de error o realizar alguna acción de recuperación
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_nameproveedor),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                margin: EdgeInsets.all(35.0),
                color: Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200.0,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                        child: FadeInImage(
                          image: NetworkImage(imageUrl),
                          placeholder:
                              AssetImage('assets/images/placeholder.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              _nameproveedor,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          StreamBuilder<bool>(
                            stream: statusStream,
                            initialData: statusproveedor,
                            builder: (context, snapshot) {
                              final isSwitchLoading =
                                  snapshot.connectionState ==
                                          ConnectionState.waiting ||
                                      snapshot.data == null;
                              final currentStatus = snapshot.data ?? false;
                              return isSwitchLoading
                                  ? CircularProgressIndicator()
                                  : Switch(
                                      value: currentStatus,
                                      onChanged: (value) {
                                        _updateProveedorStatus(value);
                                      },
                                      activeColor: Colors.white,
                                      activeTrackColor:
                                          Theme.of(context).primaryColor,
                                      inactiveTrackColor: Colors.grey[300],
                                    );
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Teléfono:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            phoneproveedor,
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            'Correo electrónico:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            emailproveedor,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.0),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}