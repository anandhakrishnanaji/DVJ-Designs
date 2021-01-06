import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/productTile.dart';
import '../providers/productProvider.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/searchPage';
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController pno = new TextEditingController();
  bool ispnoerror = false;
  bool _isloading = false;
  List<Product> _productlist = [];
  List<String> _productnames = [];

  @override
  void dispose() {
    pno.dispose();
    super.dispose();
  }

  Future<void> _fetchResults() async {
    _productlist = [];
    final url =
        'https://dvj-design.com/api_dvj/Serv_v1/search_product?text=${pno.text}';
    final response = await http.get(url);
    final jresponse = json.decode(response.body);
    final List lis = jresponse['data']['products'];
    print(lis.length);
    lis.forEach((element) {
      _productlist.add(Product(
          int.parse(element['product_id']),
          element['product_name'].replaceAll('+', ' '),
          Uri.decodeFull(element['product_image']),
          Uri.decodeFull(element['bigproduct_image']),
          int.parse(element['category_id']),
          element['product_price'],
          element['datec'],
          int.parse(element['is_new_arrival']),
          int.parse(element['status'])));
      _productnames.add(element['category_name']);
    });
    print(_productlist.length);
  }

  @override
  Widget build(BuildContext context) {
    print(_productlist.length);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Image.asset('assets/images/logo.png'),
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.all(20),
            child: ListView(children: <Widget>[
              Column(children: <Widget>[
                TextField(
                  controller: pno,
                  autofocus: false,
                  decoration: InputDecoration(
                    errorText: ispnoerror ? 'Required field' : null,
                    hintText: 'Search',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    border: OutlineInputBorder(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.black),
                  child: RaisedButton(
                    color: Colors.black,
                    child: Text(
                      'Search',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      setState(() => ispnoerror = pno.text.isEmpty);
                      if (!ispnoerror) {
                        setState(() => _isloading = true);
                        _fetchResults().then(
                            (value) => setState(() => _isloading = false));
                      }
                    },
                  ),
                ),
                ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: double.infinity,
                    ),
                    child: _isloading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : _productlist.length == 0
                            ? SizedBox()
                            : Container(
                                child: GridView.builder(
                                    scrollDirection: Axis.vertical,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: _productlist.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      crossAxisSpacing: 6,
                                      mainAxisSpacing: 12,
                                      childAspectRatio: 1,
                                    ),
                                    itemBuilder: (context, index) =>
                                        ProductTile(_productlist[index],
                                            _productnames[index]))))
              ])
            ])));
  }
}
