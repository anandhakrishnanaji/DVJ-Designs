import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ProductPreview extends StatelessWidget {
  static const routeName = '/productpreview';
  @override
  Widget build(BuildContext context) {
    final String imguri = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('assets/images/logo.png'),
      ),
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
