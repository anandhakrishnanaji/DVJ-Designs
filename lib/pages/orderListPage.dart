import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../widgets/alertBox.dart';
import '../widgets/orderListTile.dart';

class OrderListPage extends StatelessWidget {
  Future<List> _fetchOrders(final String session) async {
    final String url =
        'http://dvj-design.com/api_dvj/Serv_v1/orders?session=$session';
    final response = await http.get(url);
    final jresponse = json.decode(response.body);
    if (jresponse['status'] == 'failed') throw jresponse['message'];
    return jresponse['data']['Order_list'];
  }

  @override
  Widget build(BuildContext context) {
    final _session = Provider.of<Auth>(context).session;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: InkWell(
                child: Image.asset('assets/images/logo.png'),
                onTap: () => Navigator.of(context).pop()),
            titleSpacing: 0.194 * width,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 0.14 * width),
                child: SizedBox(),
              )
            ]),
        body: FutureBuilder(
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
              } else
                return ListView(
                  children: [
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
                          itemBuilder: (context, index) => OrderListTile(snapshot.data[index]['enquiry_id'], snapshot.data[index]['created_date'], snapshot.data[index]['order_value']),
                        ),
                      ),
                    )
                  ],
                );
            }));
  }
}
