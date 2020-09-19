import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/orderStatusWidget.dart';
import '../providers/auth.dart';
import '../widgets/alertBox.dart';

class OrderStatusPage extends StatelessWidget {
  static const routeName = '/orderstatus';

  Future<List> _orderlist(final String session) async {
    final response = await http.get(
        'https://dvj-design.com/api_dvj/Serv_v1/order_list?session=$session');
    final jresponse = json.decode(response.body);
    if (jresponse['status'] == 'failed') throw jresponse['message'];
    return jresponse['data']['Order_list'];
  }

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Auth>(context, listen: false).session;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Image.asset('assets/images/logo.png'),
          titleSpacing: 0.194 * width,
        ),
        body: FutureBuilder(
            future: _orderlist(session),
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
                return Container(
                    padding: EdgeInsets.all(20),
                    child: ListView(children: [
                      Text('Order Status'),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: double.infinity),
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, value) =>
                                OrderStatusWidget(snapshot.data[value])),
                      )
                    ]));
            }));
  }
}
