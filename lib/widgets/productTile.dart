import 'package:flutter/material.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'dart:typed_data';

import '../providers/productProvider.dart';
import '../pages/productPreviePage.dart';
import './textfieldDialog.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final String title;
  ProductTile(this.product, this.title);

  Future<void> _share() async {
    try {
      var request = await HttpClient().getUrl(Uri.parse(product.imageUrl));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('DVJ DESIGNS', '${product.name}.jpg', bytes, 'image/jpg',
          text: 'https://www.dvj-design.com/Product.php?name=$title');
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(0.0136 * height),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
                child: InkWell(
              onTap: () => Navigator.of(context).pushNamed(
                  ProductPreview.routeName,
                  arguments: product.bigImageUrl),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            )),
            Container(
              decoration: BoxDecoration(color: Colors.black),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name,
                    style:
                        TextStyle(color: Colors.white, fontSize: 0.04 * width),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 0.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: () => showDialog(
                            context: context,
                            builder: (context) => TextfieldDialog(product)),
                        child: Container(
                          margin: EdgeInsets.only(left: 0.024 * width),
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
                          onPressed: _share)
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
