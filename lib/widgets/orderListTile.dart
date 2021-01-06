import 'package:dvjdesign/providers/auth.dart';
import 'package:dvjdesign/widgets/alertBox.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../pages/orderStatuspage.dart';

class OrderListTile extends StatelessWidget {
  final String id;
  final String date;
  final String total;
  final bool pending;
  final Function callback;
  OrderListTile(
      {@required this.id,
      @required this.date,
      @required this.total,
      @required this.pending,
      this.callback});

  @override
  Widget build(BuildContext context) {
    final String _session = Provider.of<Auth>(context).session;
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        padding: EdgeInsets.all(15),
        // width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Date', style: TextStyle(color: Colors.grey[600])),
                Row(
                  children: <Widget>[Icon(Icons.date_range), Text(date)],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Invoice No.', style: TextStyle(color: Colors.grey[600])),
                Text(total != null ? total : 'null')
              ],
            ),
            pending
                ? IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () async => await showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => AlertBoxStatus(id, _session),
                        ).then((value) {
                          if (value) callback();
                        }))
                : SizedBox()
          ],
        ),
      ),
      onTap: () => Navigator.of(context)
          .pushNamed(OrderStatusPage.routeName, arguments: id),
    );
  }
}

class AlertBoxStatus extends StatefulWidget {
  final enqid;
  final session;
  AlertBoxStatus(this.enqid, this.session);
  @override
  _AlertBoxStatusState createState() => _AlertBoxStatusState();
}

class _AlertBoxStatusState extends State<AlertBoxStatus> {
  Future<bool> _deleteEnquiry(String _session, String _enqid) async {
    final response = await http.get(
        'http://dvj-design.com/api_dvj/Serv_v1/delete_enquiry?session=$_session&enquiry_id=$_enqid');
    final jresponse = json.decode(response.body);
    print(jresponse);
    if (jresponse['status'] == 'failed') throw jresponse['message'];
    return true;
  }

  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      title: Text(
        'Confirm to delete',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
      ),
      content: Text('Are you sure to delete your order?'),
      actions: <Widget>[
        _isloading
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                )),
              )
            : FlatButton(
                onPressed: () {
                  setState(() {
                    _isloading = true;
                  });

                  _deleteEnquiry(widget.session, widget.enqid).then((val) {
                    Navigator.pop(context, true);
                    setState(() {
                      _isloading = false;
                    });
                  }).catchError((e) {
                    Navigator.pop(context, false);
                    setState(() {
                      _isloading = false;
                    });
                    showDialog(
                      context: context,
                      builder: (context) => Alertbox(e.toString()),
                    );
                  });
                },
                child: Text('Yes')),
        FlatButton(
            onPressed: () => Navigator.pop(context, false), child: Text('No'))
      ],
    );
  }
}
