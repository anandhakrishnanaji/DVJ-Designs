import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function ontap;
  DrawerTile(this.text, this.icon, this.ontap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => ontap(context),
      child: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.white),
          )
        ],
      )),
    );
  }
}
