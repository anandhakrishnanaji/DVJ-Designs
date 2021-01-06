import 'package:flutter/material.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:provider/provider.dart';

import '../providers/productProvider.dart';
import '../pages/productPreviePage.dart';
import './textfieldDialog.dart';
import '../pages/productListPage.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final String title;
  ProductTile(this.product, this.title);

  Future<void> _share() async {
    try {
      var request = await HttpClient().getUrl(Uri.parse(product.imageUrl));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file(
          'DVJ DESIGNS', '${product.name}.jpg', bytes, 'image/jpg');
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    print(product.bigImageUrl);
    return InkWell(
      child: Container(
        width: double.infinity,
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
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          product.imageUrl,
                        ))),
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
                        TextStyle(color: Colors.white, fontSize: 0.037 * width),
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
                        onTap: () async => await showDialog(
                                context: context,
                                builder: (contex) => TextfieldDialog(product))
                            .then((value) {
                          if (value == 1) {
                            var currentScaffold =
                                globalScaffoldKey.currentState;
                            currentScaffold.showSnackBar(SnackBar(
                              content: Text('Item added to cart'),
                              action: SnackBarAction(
                                  textColor: Colors.grey[300],
                                  label: 'Go to Enquiry',
                                  onPressed: () {
                                    print('hrllokunno');
                                    Provider.of<ProductProvider>(
                                            currentScaffold.context,
                                            listen: false)
                                        .homecallback(4);
                                    Navigator.of(currentScaffold.context)
                                        .popUntil((route) => route.isFirst);
                                  }),
                            ));
                          }
                        }),
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
