import 'package:flutter/material.dart';
//import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../providers/auth.dart';
import '../widgets/alertBox.dart';

class AboutUsPage extends StatelessWidget {
  static const routeName = '/aboutus';
  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Auth>(context, listen: false).session;

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('assets/images/logo.png'),
        titleSpacing: 0.194 * width,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 0.041 * height),
            //   child: FutureBuilder(
            //     future: auth.obtainSliderItems(),
            //     builder: (ctx, value) =>
            //         value.connectionState == ConnectionState.waiting
            //             ? CircularProgressIndicator()
            //             : CarouselSlider(
            //                 items: value.data.map((val) => Container(
            //                       width: width,
            //                       decoration: BoxDecoration(
            //                           borderRadius:
            //                               BorderRadius.all(Radius.circular(20)),
            //                           image: DecorationImage(
            //                               image: NetworkImage(val),
            //                               fit: BoxFit.cover)),
            //                     )),
            //                 options: CarouselOptions(
            //                   enlargeCenterPage: true,
            //                   height: 0.274 * height,
            //                   initialPage: 0,
            //                   autoPlay: true,
            //                 ),
            //               ),
            //   ),
            // ),
            Text(
              'About Us',
              style: TextStyle(fontSize: 0.041 * height),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 0.041 * height, horizontal: 0.048 * width),
              child: FutureBuilder(
                  future: http.get(
                      'http://dvj-design.com/api_dvj/Serv_v1/about_us?session=$session'),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    else if (snapshot.hasError) {
                      showDialog(
                        context: ctx,
                        builder: (context) => Alertbox(snapshot.error.toString()),
                      );
                      return SizedBox();
                    }
                    final jresponse = json.decode(snapshot.data.body);
                    if (jresponse['status'] == 'failed') {
                      showDialog(
                        context: ctx,
                        builder: (context) => Alertbox(jresponse['message']),
                      );
                      return SizedBox();
                    } else
                      return Text(jresponse['data'].replaceAll('<br>','') ,
                          style: TextStyle(fontSize: 0.0273 * height),
                          textAlign: TextAlign.center);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
