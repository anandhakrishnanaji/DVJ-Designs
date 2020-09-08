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
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: ListTile(
        leading: Image.asset(
          widget.cproduct.product.imageUrl,
          width: 40,
          height: 40,
        ),
        title: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.cproduct.product.name,
                  style: TextStyle(fontSize: 30),
                ))),
        trailing: Container(
          width: 0.35 * width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 40,
                child: TextFormField(
                  initialValue: widget.cproduct.quantity.toString(),
                  onFieldSubmitted: (value) =>
                      Provider.of<ProductProvider>(context).changequantity(
                          widget.cproduct.product.id, int.parse(value)),
                ),
              ),
              IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 40,
                    color: Colors.black,
                  ),
                  onPressed: () =>
                      Provider.of<ProductProvider>(context, listen: false)
                          .removefromcart(widget.cproduct.product.id))
            ],
          ),
        ),
      ),
    );
  }
}
