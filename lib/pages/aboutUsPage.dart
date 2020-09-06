import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AboutUsPage extends StatelessWidget {
  static const routeName = '/aboutus';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('assets/images/logo.png'),
        titleSpacing: 70,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
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
                height: 200,
                initialPage: 0,
                autoPlay: true,
              ),
            ),
          ),
          Text(
            'About Us',
            style: TextStyle(fontSize: 30),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Text(
                'Dvj is a brand that represents great Ceramic Products from across the Globe. Dvj as a brand is conceived to be integral and versatile thanks to the technological innovations in the industry. The prime objective is to provide ceramic products that are technically advanced for superior lifestyle.',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center),
          )
        ],
      ),
    );
  }
}
