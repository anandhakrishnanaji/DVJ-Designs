import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/productProvider.dart';
import '../widgets/productsTile.dart';
import '../providers/auth.dart';
import '../widgets/alertBox.dart';

class TilesListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String session = Provider.of<Auth>(context).session;
    // final List<Products> products =
    //     ;
    double _crossAxisSpacing = 6, _mainAxisSpacing = 12, _aspectRatio = 1;
    int _crossAxisCount = 2;
    double screenWidth = MediaQuery.of(context).size.width;
    var width = (screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var height = width / _aspectRatio;
    final screenheight = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: Provider.of<ProductProvider>(context, listen: false)
            .obtaintiles(session),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          // else if (snapshot.hasError) {
          //   showDialog(
          //     context: ctx,
          //     builder: (context) => Alertbox(snapshot.error.toString()),
          //   );
          //   return SizedBox();
          // } 
          else
            return Container(
              padding: EdgeInsets.only(top: 0.0273 * screenheight,bottom: 15),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 0.03 * screenheight),
                    child: Text(
                      'Tiles',
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
                          ProductsTile(snapshot.data[index]),
                    ),
                  ),
                ],
              ),
            );
        });
  }
}
