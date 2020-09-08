import 'package:flutter/material.dart';

import '../providers/productProvider.dart';
import '../widgets/productTile.dart';

class ProductListPage extends StatelessWidget {
  static const routeName = '/productlistpage';
  @override
  Widget build(BuildContext context) {
    final List<Product> products = ModalRoute.of(context).settings.arguments;
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    double _crossAxisSpacing = 6, _mainAxisSpacing = 12, _aspectRatio = 0.75;
    int _crossAxisCount = 2;
    double screenWidth = MediaQuery.of(context).size.width;
    var width = (screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var height = width / _aspectRatio;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('assets/images/logo.png'),
      ),
      body: Container(
          //margin: EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'PRODUCTS',
              style: TextStyle(fontSize: 30),
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _crossAxisCount,
                crossAxisSpacing: _crossAxisSpacing,
                mainAxisSpacing: _mainAxisSpacing,
                childAspectRatio: _aspectRatio,
              ),
              itemBuilder: (context, index) => ProductTile(products[index]),
            ),
          ),
        ],
      )),
    );
  }
}
