import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../providers/auth.dart';
import '../widgets/alertBox.dart';
import '../widgets/brochureTile.dart';

class BrochurePage extends StatelessWidget {
  static const routeName='/brochurePage';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final url =
        'http://dvj-design.com/api_dvj/Serv_v1/brochure?session=${Provider.of<Auth>(context, listen: false).session}';

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: InkWell(
              child: Image.asset('assets/images/logo.png'),
              onTap: () => Navigator.of(context).pop()),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 0.14 * width),
              child: SizedBox(),
            )
          ]),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 0.04 * height, horizontal: 7),
        child: FutureBuilder(
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
                    child: ListView(children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    alignment: Alignment.center,
                    child: Text(
                      'Brochures',
                      style: TextStyle(fontSize: 0.041 * height),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: double.infinity),
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
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
                          Uri.decodeFull(_list[index]['brochure_pdf'])),
                    ),
                  )
                ]));
              }
            }),
      ),
    );
  }
}
