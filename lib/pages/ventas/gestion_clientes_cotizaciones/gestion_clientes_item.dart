import 'package:flutter/material.dart';

class CotizacionItemCard extends StatelessWidget {
  final List<Map<String, dynamic>> cotizacion;

  const CotizacionItemCard({Key? key, required this.cotizacion}) : super(key: key);

  void _enviarCotizacion(BuildContext context, String nombre, String correo) {
    // Aquí puedes implementar la lógica para enviar la cotización por correo
    // Utiliza los valores de "nombre" y "correo" para enviar la información

    // Por ejemplo, puedes mostrar un diálogo de confirmación:
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
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalCotizacion = 0;

    cotizacion.forEach((producto) {
      final int precioProducto = producto['precio'];
      final int cantidadProducto = producto['cantidad'];
      int totalProducto = precioProducto * cantidadProducto;
      totalCotizacion += totalProducto;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cotización'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            margin: EdgeInsets.all(35.0),
            color: const Color.fromARGB(255, 253, 253, 253), // Cambiar el color del fondo a azul
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
                      color: const Color.fromRGBO(8, 76, 132, 1), // Cambiar el color del texto a blanco
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cotizacion.length,
                  itemBuilder: (BuildContext context, int index) {
                    final producto = cotizacion[index];
                    final String nombreProducto = producto['nombre'];
                    final int precioProducto = producto['precio'];
                    final int cantidadProducto = producto['cantidad'];
                    int totalProducto = precioProducto * cantidadProducto;

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12.0),
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
                          color: const Color.fromRGBO(8, 76, 132, 1), // Cambiar el color del texto a blanco
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
                                    SizedBox(height: 8.0), // Agregar margen superior
                                    TextField(
                                      onChanged: (value) {
                                        nombre = value;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Nombre',
                                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                                      ),
                                    ),
                                    SizedBox(height: 8.0), // Agregar espacio entre campos
                                    TextField(
                                      onChanged: (value) {
                                        correo = value;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Correo',
                                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      _enviarCotizacion(context, nombre, correo);
                                    },
                                    child: Text('Enviar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancelar'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 250, 250, 250), // Cambiar el color del botón a azul
                          onPrimary: const Color.fromRGBO(8, 76, 132, 1), // Cambiar el color del texto a blanco
                          padding: EdgeInsets.symmetric(horizontal: 24.0), // Ajustar el espaciado interno del botón
                        ),
                        child: Text('Enviar cotización'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}