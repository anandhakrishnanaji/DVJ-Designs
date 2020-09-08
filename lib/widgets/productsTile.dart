import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/productProvider.dart';
import '../pages/productListPage.dart';

class ProductsTile extends StatelessWidget {
  final Products product;
  ProductsTile(this.product);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(ProductListPage.routeName, arguments: product.list),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Image.asset(
                product.imageUri,
                width: 0.43 * width,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 0.43 * width,
              child: Text(product.name,
                  style:
                      TextStyle(color: Colors.white, fontSize: 0.049 * width)),
              decoration: BoxDecoration(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
