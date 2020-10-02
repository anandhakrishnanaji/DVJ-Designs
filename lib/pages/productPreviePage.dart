import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import './homePage.dart';

class ProductPreview extends StatelessWidget {
  static const routeName = '/productpreview';
  @override
  Widget build(BuildContext context) {
    final String imguri = ModalRoute.of(context).settings.arguments;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: InkWell(
              child: Image.asset('assets/images/logo.png'),
              onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  HomePage.routeName, (Route<dynamic> route) => false)),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 0.14 * width),
              child: SizedBox(),
            )
          ]),
      body: Container(
          child: PhotoView(
        imageProvider: NetworkImage(imguri),
        backgroundDecoration: BoxDecoration(color: Colors.white),
        minScale: PhotoViewComputedScale.contained * 0.6,
        maxScale: PhotoViewComputedScale.contained * 3,
      )),
    );
  }
}
