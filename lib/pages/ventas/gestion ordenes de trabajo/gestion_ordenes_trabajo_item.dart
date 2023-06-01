import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrdenItemCard extends StatefulWidget {
  const OrdenItemCard({Key? key}) : super(key: key);

  @override
  _OrdenItemCardState createState() => _OrdenItemCardState();
}

class _OrdenItemCardState extends State<OrdenItemCard> {
  late String idot;
  late String codot;
  late String _prioridadot;
  late String tipoot;
  late String fechaot;
  late String creacionot;
  late String equipoot;
  late bool statusot;
  late String resumenot;

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
      _prioridadot = arguments['prioridad_ot'].toString();
      tipoot = arguments['tipo_ot'].toString();
      equipoot = arguments['equipo_ot'].toString();
      fechaot = arguments['fecha_ot'].toString();
      creacionot = arguments['created_ot'].toString();
      statusot = arguments['estado_ot'] as bool;
      resumenot = arguments['resumen_ot'].toString();
    }
    return _prioridadot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orden de Trabajo'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: SingleChildScrollView(
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
                            image: AssetImage('assets/gestionProd.png'),
                            placeholder:
                                AssetImage('assets/Loading_icon.gif'),
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
                                codot,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                statusot == true ? 'En Proceso' : 'Terminada',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: statusot == true ? Color.fromARGB(255, 219, 140, 37) : Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                side: BorderSide.none,
                              ),
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
                              'Prioridad:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            RichText(
                              text: TextSpan(
                                text: '',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: _prioridadot,
                                    style: TextStyle(
                                      color: _prioridadot == 'Alta'
                                          ? Colors.red
                                          : _prioridadot == 'Media'
                                              ? Color.fromARGB(255, 223, 171, 3)
                                              : Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              'Tipo de orden de trabajo:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              tipoot,
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              'Equipo:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              equipoot,
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              'Fecha de creación:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              DateFormat('dd-MM-yyyy').format(DateTime.parse(creacionot)),
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              'Fecha Límite:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              DateFormat('dd-MM-yyyy').format(DateTime.parse(fechaot)),
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              'Resumen:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              resumenot,
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 12.0),
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
      ),
    );
  }
}

