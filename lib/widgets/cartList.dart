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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Image',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Product Name',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Qty/Pcs',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Remove',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )),
          Consumer<ProductProvider>(
            builder: (context, value, child) => Column(
              children: value.cartlist.map<Widget>((e) => CartTile(e)).toList(),
            ),
          )
        ],
      ),
    );
  }
}
