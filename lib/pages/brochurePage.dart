import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BrochurePage extends StatelessWidget {
  static const routeName = '/brochure';

  Future<void> _launch(String url) async {
    if (await canLaunch(url)) launch(url);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('assets/images/logo.png'),
        titleSpacing: 0.194 * width,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 0.024 * width),
            child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: null),
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () => _launch(
                    'https://www.dvj-design.com/pdf/brochure/Master_Catalogue_2018.pdf'),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/broch2018.jpg',
                      width: 0.43 * width,
                      height: 0.37 * height,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: 0.43 * width,
                      child: Text(
                        'Brochure 2018',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 23),
                      ),
                      decoration: BoxDecoration(color: Colors.black87),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () => _launch(
                    'https://www.dvj-design.com/pdf/brochure/Master_Catalouge_2019_new1.pdf'),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/broch2019.jpg',
                      width: 0.43 * width,
                      height: 0.37 * height,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: 0.43 * width,
                      child: Text(
                        'Brochure 2019',
                        style: TextStyle(color: Colors.white, fontSize: 23),
                        textAlign: TextAlign.center,
                      ),
                      decoration: BoxDecoration(color: Colors.black87),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
