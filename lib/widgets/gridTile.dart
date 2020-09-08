import 'package:flutter/material.dart';

class Gridtile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function ontap;
  Gridtile(this.text, this.icon, this.ontap);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(0.0138 * height),
        decoration: BoxDecoration(
            color: Colors.grey[350],
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 0.047 * height,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 0.058 * width),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      onTap: () => ontap(context),
    );
  }
}
