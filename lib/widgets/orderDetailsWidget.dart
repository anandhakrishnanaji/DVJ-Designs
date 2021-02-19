import 'package:flutter/material.dart';

class OrderDetailsWidget extends StatelessWidget {
  final orderDetails;
  OrderDetailsWidget(this.orderDetails);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Enquiry ID: ${orderDetails['enquiry_id']}'),Text('Enquiry Name: ${}')
        ],
      ),
    );
  }
}
