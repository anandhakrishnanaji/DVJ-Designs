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
    return Container(
      height: 0.3 * height,
      width: 0.43 * width,
      child: Column(
        children: <Widget>[],
      ),
    );
  }
}
