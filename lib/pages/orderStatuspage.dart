import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

import './searchPage.dart';

class OrderStatusPage extends StatelessWidget {
  static const routeName = '/orderstatus';

  final List<TimelineModel> items = [
    TimelineModel(
        Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Order Received',
              style: TextStyle(fontSize: 24),
            )),
        position: TimelineItemPosition.right,
        iconBackground: Colors.white,
        icon: Icon(
          Icons.check_box,
        )),
    TimelineModel(
        Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Goods Dispatched',
              style: TextStyle(fontSize: 24),
            )),
        position: TimelineItemPosition.right,
        iconBackground: Colors.white,
        icon: Icon(
          Icons.check_box_outline_blank,
        )),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Image.asset('assets/images/logo.png'),
          titleSpacing: 0.194 * width,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 0.024 * width),
              child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed:() =>
                    Navigator.of(context).pushNamed(SearchPage.routeName)),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(0.041 * height),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Order Status',
                style: TextStyle(fontSize: 0.041 * height),
              ),
              Divider(
                thickness: 5,
              ),
              Timeline(
                children: items,
                position: TimelinePosition.Left,
                shrinkWrap: true,
                lineColor: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(color: Colors.black),
                    child: RaisedButton(
                      onPressed: null,
                      child: Text(
                        'Invoice',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(color: Colors.black),
                    child: RaisedButton(
                      onPressed: null,
                      child: Text(
                        'LR',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
