import 'package:dvjdesign/widgets/dispatchOrderList.dart';
import 'package:dvjdesign/widgets/pendingOrderList.dart';
import 'package:flutter/material.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              // constraints: BoxConstraints(maxHeight: 180.0),
              child: Material(
                color: Color.fromRGBO(82, 80, 76, 1),
                child: TabBar(
                  indicatorWeight: 2,
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  tabs: [
                    Tab(icon: Icon(Icons.pending_actions)),
                    Tab(icon: Icon(Icons.done)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                  // color: Colors.lightBlueAccent,
                  padding: EdgeInsets.all(15),
                  child: TabBarView(children: [
                    PendingOrderListPage(),
                    DispatchOrderListPage()
                  ])),
            ),
          ],
        ));
  }
}
