import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class CotizacionItemCard extends StatelessWidget {
  final List<Map<String, dynamic>> cotizacion;

  const CotizacionItemCard({Key? key, required this.cotizacion}) : super(key: key);

  Future<void> sendEmail(String nombre, String correo) async {
    String username = 'testeodecorrelocura@gmail.com';
    String password = 'ansrzdvhrlmzuvbe';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Elite Manager ')
      ..recipients.add(correo)
      ..subject = 'Cotización Elite Manager'
      ..text = buildEmailContent(nombre);

    try {
      final sendReport = await send(message, smtpServer);
      print('Correo enviado: ${sendReport.toString()}');
    } catch (e) {
      print('Error al enviar el correo: $e');
      throw Exception('Error al enviar el correo');
    }
  }

  String buildEmailContent(String nombre) {
    String content = 'Hola $nombre,\n\nAquí está tu cotización:\n\n';

    cotizacion.forEach((producto) {
      final String nombreProducto = producto['nombre'];
      final int precioProducto = producto['precio'];
      final int cantidadProducto = producto['cantidad'];
      int totalProducto = precioProducto * cantidadProducto;

      content += 'Producto: $nombreProducto\n';
      content += 'Precio: \$${precioProducto.toStringAsFixed(2)}\n';
      content += 'Cantidad: $cantidadProducto\n';
      content += 'SubTotal: \$${totalProducto.toStringAsFixed(2)}\n\n';
    });

    int totalCotizacion = calculateTotalCotizacion();
    content += 'Total de la cotización: \$${totalCotizacion.toStringAsFixed(2)}\n';

    return content;
  }

  int calculateTotalCotizacion() {
    int totalCotizacion = 0;

    cotizacion.forEach((producto) {
      final int precioProducto = producto['precio'];
      final int cantidadProducto = producto['cantidad'];
      int totalProducto = precioProducto * cantidadProducto;
      totalCotizacion += totalProducto;
    });

    return totalCotizacion;
  }

  void _enviarCotizacion(BuildContext context, String nombre, String correo) {
    sendEmail(nombre, correo)
      .then((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Cotización enviada'),
              content: Text('Se ha enviado la cotización a: $correo'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed('ventas');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('La cotización ha sido enviada con éxito.'),
                        backgroundColor: Colors.green,
                      ),
                    ); // Redirigir a la pantalla de ventas
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            );
          },
        );
      })
      .catchError((error) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error al enviar la cotización'),
              content: Text('Ocurrió un error al enviar la cotización. Por favor, inténtalo nuevamente.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            );
          },
        );
        print('Error al enviar el correo: $error');
      });
  }

  @override
  Widget build(BuildContext context) {
    int totalCotizacion = calculateTotalCotizacion();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cotización'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          margin: EdgeInsets.all(35.0),
          color: const Color.fromARGB(255, 253, 253, 253),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Productos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: const Color.fromRGBO(8, 76, 132, 1),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cotizacion.length,
                  itemBuilder: (BuildContext context, int index) {
                    final producto = cotizacion[index];
                    final String nombreProducto = producto['nombre'];
                    final int precioProducto = producto['precio'];
                    final int cantidadProducto = producto['cantidad'];
                    int totalProducto = precioProducto * cantidadProducto;

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Producto: $nombreProducto',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Precio: \$${precioProducto.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Cantidad: $cantidadProducto',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'SubTotal: \$${totalProducto.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 12.0),
                          Divider(height: 1.0),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 12.0),
                    Text(
                      'Total de la cotización:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: const Color.fromRGBO(8, 76, 132, 1),
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '\$${totalCotizacion.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 12.0),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            String nombre = '';
                            String correo = '';

                            return AlertDialog(
                              title: Text('Enviar cotización'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 8.0),
                                  TextField(
                                    onChanged: (value) {
                                      nombre = value;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Nombre',
                                      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  TextField(
                                    onChanged: (value) {
                                      correo = value;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Correo electrónico',
                                      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancelar'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (nombre.isNotEmpty && correo.isNotEmpty) {
                                      Navigator.of(context).pop();
                                      _enviarCotizacion(context, nombre, correo);
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Por favor, ingresa el nombre y el correo electrónico.'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                  child: Text('Enviar'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Enviar cotización'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}