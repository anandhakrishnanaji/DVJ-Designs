import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/productProvider.dart';
import '../widgets/productsTile.dart';

class ProductsListPage extends StatelessWidget {
  static const routeName = '/productslistspage';
  @override
  Widget build(BuildContext context) {
    final List<Products> products =
        Provider.of<ProductProvider>(context, listen: false).productslist;
    double _crossAxisSpacing = 6, _mainAxisSpacing = 12, _aspectRatio = 1;
    int _crossAxisCount = 2;
    double screenWidth = MediaQuery.of(context).size.width;
    var width = (screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var height = width / _aspectRatio;
    final screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('assets/images/logo.png'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 0.0273 * screenheight),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 0.03 * screenheight),
              child: Text(
                'Products',
                style: TextStyle(fontSize: 0.041 * screenheight),
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
                itemBuilder: (context, index) => ProductsTile(products[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
