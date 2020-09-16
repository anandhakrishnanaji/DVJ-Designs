import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../widgets/alertBox.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Auth>(context, listen: false).obtainSliderItems(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else if (snapshot.hasError) {
            Future.delayed(
                Duration.zero,
                () => showDialog(
                    context: _, child: Alertbox(snapshot.error.toString())));
            return SizedBox();
          } else
            return Container(
              child: Carousel(
                // boxFit: BoxFit.contain,
                images: snapshot.data.map((e) => NetworkImage(e)).toList(),
              ),
            );
        });
  }
}
