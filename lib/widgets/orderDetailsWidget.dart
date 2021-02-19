import 'package:flutter/material.dart';

class OrderDetailsWidget extends StatelessWidget {
  final orderDetails;
  OrderDetailsWidget(this.orderDetails);
  @override
  Widget build(BuildContext context) {
    final String og_string =
        orderDetails['enquiry_product'].split('<br>').join('\n\n');
    final height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(top: 0.03 * height),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Enquiry ID: ${orderDetails['enquiry_id']}',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Enquiry Name: ${orderDetails['enquiry_name']}',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Enquiry Mobile: ${orderDetails['enquiry_mobile']}',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              'Ordered Products:\n',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3),
            child: Text(
              og_string,
              style: TextStyle(fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
