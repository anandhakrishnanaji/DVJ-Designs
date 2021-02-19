import 'package:dvjdesign/widgets/orderDetailsWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/orderStatusWidget.dart';
import '../providers/auth.dart';
import '../widgets/alertBox.dart';

class OrderStatusPage extends StatelessWidget {
  static const routeName = '/orderDetail';
  Future _orderlist(final String session, final String id) async {
    final response = await http.get(
        'http://dvj-design.com/api_dvj/Serv_v1/order_details?session=$session&enquiry_id=$id');
    final jresponse = json.decode(response.body);
    print(jresponse);
    if (jresponse['status'] == 'failed') throw jresponse['message'];
    return jresponse['data']['Order_list'][0];
  }

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments;
    final session = Provider.of<Auth>(context, listen: false).session;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: InkWell(
              child: Image.asset('assets/images/logo.png'),
              onTap: () => Navigator.of(context).pop()),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 0.14 * width),
              child: SizedBox(),
            )
          ]),
      body: Container(
        padding: EdgeInsets.all(15),
        child: FutureBuilder(
            future: _orderlist(session, id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else if (snapshot.hasError) {
                Future.delayed(
                    Duration.zero,
                    () => showDialog(
                        context: context,
                        child: Alertbox(snapshot.error.toString())));
                return SizedBox();
              } else
                return SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(children: [
                          Text(
                            'Order Details',
                            style: TextStyle(fontSize: 0.041 * height),
                          ),
                          OrderDetailsWidget(snapshot.data),
                          Text(
                            'Order Status',
                            style: TextStyle(fontSize: 0.041 * height),
                          ),
                          OrderStatusWidget(snapshot.data)
                        ])));
            }),
      ),
    );
  }
}
