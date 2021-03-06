import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BrochureTile extends StatelessWidget {
  final String url;
  final String name;
  final String launchUrl;
  BrochureTile(this.url, this.name, this.launchUrl);

  Future<void> _launch() async {
    if (await canLaunch(launchUrl)) launch(launchUrl);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: _launch,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.network(
              url,
              width: 0.86 * width,
              height: 0.6 * height,
              fit: BoxFit.fill,
            ),
            Container(
              padding: EdgeInsets.all(15),
              width: 0.86 * width,
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              decoration: BoxDecoration(color: Colors.black87),
            )
          ],
        ),
      ),
    );
  }
}
