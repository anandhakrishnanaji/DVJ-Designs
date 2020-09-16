import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BrochureTile extends StatelessWidget {
  final String url;
  final String name;
  final String launchUrl;
  BrochureTile(this.url, this.name, this.launchUrl);

  Future<void> _launch(String url) async {
    print('launching!!!!');
    if (await canLaunch(url)) launch(url);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () => _launch(launchUrl),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.network(
              url,
              width: 0.43 * width,
              height: 0.3 * height,
              fit: BoxFit.fill,
            ),
            Container(
              width: 0.43 * width,
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
