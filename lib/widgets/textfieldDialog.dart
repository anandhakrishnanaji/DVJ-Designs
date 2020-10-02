import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/productProvider.dart';
import '../providers/auth.dart';

class TextfieldDialog extends StatefulWidget {
  final Product product;
  // final Function callback;
  TextfieldDialog(this.product, );
  @override
  _TextfieldDialogState createState() => _TextfieldDialogState();
}

class _TextfieldDialogState extends State<TextfieldDialog> {
  TextEditingController _quantity = new TextEditingController();

  @override
  void initState() {
    _quantity.text = '1';
    super.initState();
  }

  bool _isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }

  bool _isError = false;

  @override
  void dispose() {
    _quantity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String _session = Provider.of<Auth>(context, listen: false).session;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return AlertDialog(
      title: Text('Add to Cart'),
      content: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 0.2 * height),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ListTile(
              leading: Image.network(
                widget.product.imageUrl,
                width: 0.1 * width,
                height: 0.1 * width,
              ),
              title: Container(
                  padding: EdgeInsets.symmetric(horizontal: 0.048 * width),
                  child: Text(
                    widget.product.name,
                    style: TextStyle(fontSize: 0.02 * height),
                  )),
            ),
            TextField(
              controller: _quantity,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Product Quantity',
                errorText: _isError ? 'Invalid Quantity' : null,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                border: OutlineInputBorder(),
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () => Navigator.pop(context,0), child: Text('Cancel')),
        FlatButton(
            onPressed: () {
              setState(() => _isError = false);
              if (_isNumeric(_quantity.text) &&
                  int.parse(_quantity.text) > 0 &&
                  int.parse(_quantity.text) < 100000) {
                Provider.of<ProductProvider>(context, listen: false).addtocart(
                    widget.product, _session, int.parse(_quantity.text));
                Navigator.pop(context,1);
              } else
                setState(() => _isError = true);
            },
            child: Text('Add to Cart'))
      ],
    );
  }
}
