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
    final height = MediaQuery.of(context).size.height;
    return Container(
      child: ListTile(
        leading: Image.asset(
          widget.cproduct.product.imageUrl,
          width: 0.097 * width,
          height: 0.097 * width,
        ),
        title: Container(
            padding: EdgeInsets.symmetric(horizontal: 0.048 * width),
            child: Text(
              widget.cproduct.product.name,
              style: TextStyle(fontSize: 0.02 * height),
            )),
        trailing: Container(
          width: 0.35 * width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 0.097 * width,
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
                    size: 0.097 * width,
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
