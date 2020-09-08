import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/productProvider.dart';

class ProductsTile extends StatelessWidget {
  final Products product;
  ProductsTile(this.product);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: null,
      child: Container(
        height: 0.3 * height,
        width: 0.43 * width,
        child: Column(
          children: <Widget>[
            Image.asset(
              product.imageUri,
              fit: BoxFit.cover,
            ),
            Container(
              child: Text(product.name, style: TextStyle(color: Colors.white)),
              decoration: BoxDecoration(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
