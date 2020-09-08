import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/productProvider.dart';
import '../widgets/productsTile.dart';

class ProductsListPage extends StatelessWidget {
  static const routeName = '/productlistspage';
  @override
  Widget build(BuildContext context) {
    final List<Products> products =
        Provider.of<ProductProvider>(context, listen: false).productslist;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('assets/images/logo.png'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: products.map((e) => ProductsTile(e)).toList(),
      ),
    );
  }
}
