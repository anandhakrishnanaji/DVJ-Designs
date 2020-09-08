import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/productProvider.dart';
import './cartTile.dart';

class CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              height: 30,
              decoration: BoxDecoration(color: Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Image'),
                  Text('Product Name'),
                  Text('Qty/Pcs'),
                  Text('Remove')
                ],
              )),
          Consumer<ProductProvider>(
            builder: (context, value, child) => Column(
              children: value.cartlist.map((e) => CartTile(e)).toList(),
            ),
          )
        ],
      ),
    );
  }
}
