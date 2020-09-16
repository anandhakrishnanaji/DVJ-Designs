import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../providers/auth.dart';
import '../widgets/alertBox.dart';
import '../widgets/brochureTile.dart';

class BrochurePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final url =
        'http://dvj-design.com/api_dvj/Serv_v1/brochure?session=${Provider.of<Auth>(context).session}';

    return Container(
        height: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
                future: http.get(url),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  else if (snapshot.hasError) {
                    showDialog(
                        context: context,
                        child: Alertbox(snapshot.error.toString()));
                    return SizedBox();
                  } else {
                    final List _list =
                        json.decode(snapshot.data.body)['data']['brochure'];
                    return Container(
                      width: width,
                      height: height,
                      child: GridView.builder(
                        itemCount: _list.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.6,
                        ),
                        itemBuilder: (context, index) => BrochureTile(
                            Uri.decodeFull(_list[index]['brochure_image']),
                            _list[index]['brochure_name'].replaceAll('+', ' '),
                            _list[index]['brochure_pdf']),
                      ),
                    );
                  }
                }),
          ],
        ));
  }
}
