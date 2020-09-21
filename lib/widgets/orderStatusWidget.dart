import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderStatusWidget extends StatelessWidget {
  final orderStatus;
  OrderStatusWidget(this.orderStatus);
  List<TimelineModel> _generateStatus() {
    final od = orderStatus['order_status'];
    List<TimelineModel> _items = [];
    od.keys.forEach((element) {
      _items.add(TimelineModel(
          Container(
              padding: EdgeInsets.all(20),
              child: Text(
                od[element],
                style: TextStyle(fontSize: 20),
              )),
          position: TimelineItemPosition.right,
          iconBackground: Colors.white,
          icon: Icon(
            Icons.check_box,
          )));
    });
    return _items;
  }

  Future<void> _launch(final String url) async {
    final launchUrl = Uri.decodeFull(url);
    if (await canLaunch(launchUrl)) launch(launchUrl);
  }

  @override
  Widget build(BuildContext context) {
    bool _islr = orderStatus['lr_attach'] != "";
    bool _isinv = orderStatus['invoice_attach'] != "";
    final height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(0.041 * height),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(
            thickness: 5,
          ),
          Timeline(
            children: _generateStatus(),
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
                decoration:
                    BoxDecoration(color: _isinv ? Colors.black : Colors.grey),
                child: MaterialButton(
                  onPressed: _isinv
                      ? () => _launch(orderStatus['invoice_attach'])
                      : null,
                  child: Text(
                    'Invoice',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(3),
                decoration:
                    BoxDecoration(color: _islr ? Colors.black : Colors.grey),
                child: MaterialButton(
                  onPressed:
                      _islr ? () => _launch(orderStatus['lr_attach']) : null,
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
    );
  }
}
