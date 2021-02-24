import 'package:flutter/material.dart';

class OrderDetailsWidget extends StatelessWidget {
  final orderDetails;
  OrderDetailsWidget(this.orderDetails);
  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.all(5),
              child: Column(
                children: orderDetails['order_details']
                    .map<Widget>((e) => Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          Uri.decodeFull(e['product_image'])))),
                            ),
                            title: Text(e['producName']),
                          ),
                        ))
                    .toList(),
              ))
        ],
      ),
    );
  }
}
