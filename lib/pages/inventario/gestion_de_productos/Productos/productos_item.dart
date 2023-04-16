import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String description;
  final List<String> categories;

  const ProductCard({
    required this.imageUrl,
    required this.productName,
    required this.description,
    required this.categories, required bool isActive,
  });

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(productName),
    ),
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
              color: Color.fromARGB(255, 255, 255, 255), // set background color to white
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
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            productName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        Switch(
                          value: false,
                          onChanged: null,
                          activeColor: Theme.of(context).primaryColor,
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.grey[300],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      description,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Wrap(
                      spacing: 8.0,
                      children: categories
                          .map((category) => Chip(label: Text(category)))
                          .toList(),
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