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
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                icon,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          )),
    );
  }
}
