import 'package:flutter/material.dart';

import '../pages/orderStatuspage.dart';

class OrderListTile extends StatelessWidget {
  final String id;
  final String date;
  final String total;
  OrderListTile(this.id, this.date, this.total);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        padding: EdgeInsets.all(15),
        // width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Date', style: TextStyle(color: Colors.grey[600])),
                Row(
                  children: <Widget>[Icon(Icons.date_range), Text(date)],
                )
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Order', style: TextStyle(color: Colors.grey[600])),
                Text(id)
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Total', style: TextStyle(color: Colors.grey[600])),
                Text(total)
              ],
            )
          ],
        ),
      ),
      onTap: () => Navigator.of(context)
          .pushNamed(OrderStatusPage.routeName, arguments: id),
    );
  }
}
