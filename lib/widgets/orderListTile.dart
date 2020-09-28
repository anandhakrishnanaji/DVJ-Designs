import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../pages/orderStatuspage.dart';

class OrderListTile extends StatelessWidget {
  final String id;
  final DateTime date;
  final String total;
  OrderListTile(this.id, this.date, this.total);
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-YYYY').format(date);
    return InkWell(
      child: Container(
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Date'),
                Row(
                  children: <Widget>[
                    Icon(Icons.date_range),
                    Text(formattedDate)
                  ],
                )
              ],
            ),
            Column(
              children: <Widget>[Text('Order'), Text(id)],
            ),
            Column(
              children: <Widget>[Text('Total'), Text('total')],
            )
          ],
        ),
      ),
      onTap: () => Navigator.of(context)
          .pushNamed(OrderStatusPage.routeName, arguments: id),
    );
  }
}
