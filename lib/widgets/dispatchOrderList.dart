import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../widgets/alertBox.dart';
import '../widgets/orderListTile.dart';

class DispatchOrderListPage extends StatelessWidget {
  Future<List> _fetchOrders(String _session) async {
    final response = await http.get(
        'https://dvj-design.com/api_dvj/Serv_v1/dispatch_orders?session=$_session');
    final jresponse = json.decode(response.body);
    if (jresponse['status'] == 'failed') throw jresponse['message'];
    return jresponse['data']['Order_list'];
  }

  @override
  Widget build(BuildContext context) {
    final _session = Provider.of<Auth>(context).session;
    final height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(15),
      child: FutureBuilder(
          future: _fetchOrders(_session),
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
            } else {
              if (snapshot.data.isEmpty)
                return Center(
                  child: Text('You have no completed orders currently'),
                );
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'Completed Orders',
                      style: TextStyle(fontSize: 0.041 * height),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: double.infinity,
                    ),
                    child: Container(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) => OrderListTile(
                            id: snapshot.data[index]['enquiry_id'],
                            date: snapshot.data[index]['created_date'],
                            total: snapshot.data[index]['order_value'],
                            pending: false),
                      ),
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}
