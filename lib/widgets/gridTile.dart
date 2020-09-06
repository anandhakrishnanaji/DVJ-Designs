import 'package:flutter/material.dart';

class Gridtile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function ontap;
  Gridtile(this.text, this.icon, this.ontap);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(10),
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
              size: 35,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      onTap: () => ontap(context),
    );
  }
}
