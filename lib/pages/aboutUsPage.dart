import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AboutUsPage extends StatelessWidget {
  static const routeName = '/aboutus';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('assets/images/logo.png'),
        titleSpacing: 0.194 * width,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.041 * height),
            child: CarouselSlider(
              items: List.generate(
                  3,
                  (val) => Container(
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/slide$val.jpg'),
                                fit: BoxFit.cover)),
                      )),
              options: CarouselOptions(
                enlargeCenterPage: true,
                height: 0.274 * height,
                initialPage: 0,
                autoPlay: true,
              ),
            ),
          ),
          Text(
            'About Us',
            style: TextStyle(fontSize: 0.041 * height),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 0.041 * height, horizontal: 0.048 * width),
            child: Text(
                'Dvj is a brand that represents great Ceramic Products from across the Globe. Dvj as a brand is conceived to be integral and versatile thanks to the technological innovations in the industry. The prime objective is to provide ceramic products that are technically advanced for superior lifestyle.',
                style: TextStyle(fontSize: 0.0273 * height),
                textAlign: TextAlign.center),
          )
        ],
      ),
    );
  }
}
