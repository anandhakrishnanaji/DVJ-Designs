import 'package:flutter/material.dart';

import '../providers/productProvider.dart';
import '../widgets/productTile.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Product> products = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('assets/images/logo.png'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: products.map((e) => ProductTile(e)).toList(),
      ),
    );
  }
}
