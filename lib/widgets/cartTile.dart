import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/productProvider.dart';

class CartTile extends StatefulWidget {
  final CartProduct cproduct;
  CartTile(this.cproduct);

  @override
  _CartTileState createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Image.asset(
          widget.cproduct.product.imageUrl,
          width: 30,
          height: 30,
        ),
        title: Text(widget.cproduct.product.name),
        trailing: Row(
          children: <Widget>[
            Container(
              width: 40,
              child: TextFormField(
                initialValue: widget.cproduct.quantity,
                onFieldSubmitted: (value) =>
                    Provider.of<ProductProvider>(context).changequantity(
                        widget.cproduct.product.id, int.parse(value)),
              ),
            ),
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () =>
                    Provider.of<ProductProvider>(context, listen: false)
                        .removefromcart(widget.cproduct.product.id))
          ],
        ),
      ),
    );
  }
}
