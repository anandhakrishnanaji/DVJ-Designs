import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/productProvider.dart';
import '../providers/auth.dart';
import '../widgets/productTile.dart';
import '../widgets/alertBox.dart';

class ProductListPage extends StatelessWidget {
  static const routeName = '/productlistpage';
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments;
    final int categoryId = arguments['category_id'];
    final session = Provider.of<Auth>(context, listen: false).session;
    final title = arguments['title'];
    double _crossAxisSpacing = 6, _mainAxisSpacing = 12, _aspectRatio = 0.75;
    int _crossAxisCount = 2;
    double screenWidth = MediaQuery.of(context).size.width;
    var width = (screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var height = width / _aspectRatio;

    final screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('assets/images/logo.png'),
      ),
      body: FutureBuilder(
          future: Provider.of<ProductProvider>(context, listen: false)
              .obtainproductitem(categoryId, session),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            // else if (snapshot.hasError) {
            //   showDialog(
            //       context: ctx, child: Alertbox(snapshot.error.toString()));
            //   return SizedBox();
            // }
             else {
              print(snapshot.hasData);
              print(snapshot.hasError);
              print(snapshot.error);
              return Container(
                  //margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(0.0273 * screenheight),
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 0.041 * screenheight),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: snapshot.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _crossAxisCount,
                        crossAxisSpacing: _crossAxisSpacing,
                        mainAxisSpacing: _mainAxisSpacing,
                        childAspectRatio: _aspectRatio,
                      ),
                      itemBuilder: (context, index) =>
                          ProductTile(snapshot.data[index]),
                    ),
                  ),
                ],
              ));
            }
          }),
    );
  }
}
