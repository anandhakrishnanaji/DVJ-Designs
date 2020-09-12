import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../widgets/alertBox.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Auth>(context).obtainSliderItems(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : snapshot.hasError
                    ? Alertbox(snapshot.error.toString())
                    : Container(
                        child: Carousel(
                          images: snapshot.data
                              .map((e) => NetworkImage(e))
                              .toList(),
                        ),
                      ));
  }
}
