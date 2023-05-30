import 'package:flutter/material.dart';

class VentasItemCard extends StatefulWidget {
  const VentasItemCard({Key? key}) : super(key: key);

  @override
  _VentasItemCardState createState() => _VentasItemCardState();
}

class _VentasItemCardState extends State<VentasItemCard> {
  String idventa = '';
  String codventa = '';
  List<Map<String, dynamic>> prodventa = [];
  String fechaventa = '';
  String totalventa = '';
  String cajaventa = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchVentas();
  }

  Future<void> _fetchVentas() async {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (arguments != null &&
        arguments.containsKey('id_ven') &&
        arguments.containsKey('cod_ven') &&
        arguments.containsKey('prod_ven') &&
        arguments.containsKey('fecha_ven') &&
        arguments.containsKey('total_ven') &&
        arguments.containsKey('caja_ven')) {
      setState(() {
        idventa = arguments['id_ven'].toString();
        codventa = arguments['cod_ven'].toString();
        prodventa = List<Map<String, dynamic>>.from(arguments['prod_ven']);
        fechaventa = arguments['fecha_ven'].toString();
        totalventa = _calculateTotal(prodventa).toString();
        cajaventa = arguments['caja_ven'].toString();
      });
    }
  }

  int _calculateTotal(List<Map<String, dynamic>> products) {
    int total = 0;
    for (final product in products) {
      total += product['precio'] as int;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(codventa),
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
                    //centrar la imagen
                    Center(
                      child:
                    Image.asset('assets/elitelogo.png', width: 175.0),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          
                          Expanded(
                            child: Text(
                              codventa,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
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
                            'Productos:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: prodventa.map((producto) {
                              String nombreProducto = producto['nombre'];
                              int precioProducto = producto['precio'];

                              return Text(
                                '$nombreProducto - \$$precioProducto',
                                style: TextStyle(fontSize: 16.0),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            'Fecha venta:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            fechaventa,
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            'Total:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '\$$totalventa',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            'Caja $cajaventa',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/descargar.jpeg',
                      height: 250,
                    ),
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

