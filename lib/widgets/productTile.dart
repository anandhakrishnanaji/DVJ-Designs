import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/productProvider.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  ProductTile(this.product);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      child: Container(
        height: 0.3 * height,
        width: 0.43 * width,
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
        child: Column(
          children: <Widget>[
            Image.asset(
              product.imageUrl,
              fit: BoxFit.fitHeight,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black),
              child: Column(
                children: <Widget>[
                  Text(
                    product.name,
                    style: TextStyle(color: Colors.white),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: null,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white)),
                          child: Text(
                            'ADD',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          onPressed: null)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
