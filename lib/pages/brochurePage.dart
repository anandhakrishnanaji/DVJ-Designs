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
    final url =
        'http://dvj-design.com/api_dvj/Serv_v1/brochure?session=${Provider.of<Auth>(context).session}';

    return Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        json.decode(snapshot.data)['data']['brochure'];
                    return GridView.builder(
                      itemCount: _list.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) => BrochureTile(
                          _list[index]['brochure_image'],
                          _list[index]['brochure_name'],
                          _list[index]['brochure_pdf']),
                    );
                  }
                }),
          ],
        ));
  }
}
