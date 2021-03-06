import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/productProvider.dart';
import '../providers/auth.dart';
import '../widgets/productTile.dart';
import '../widgets/alertBox.dart';

final globalScaffoldKey = GlobalKey<ScaffoldState>();

class ProductListPage extends StatelessWidget {
  static const routeName = '/productlistpage';
  @override
  Widget build(BuildContext context) {
    // print('kona\n\n\n\n\nkona\n');
    final Map arguments = ModalRoute.of(context).settings.arguments;
    final int categoryId = arguments['category_id'];
    final session = Provider.of<Auth>(context, listen: false).session;
    final title = arguments['title'];
    final screenheight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final Widget future = FutureBuilder(
        future: Provider.of<ProductProvider>(context, listen: false)
            .obtainproductitem(categoryId, session),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else if (snapshot.hasError) {
            Future.delayed(
                Duration.zero,
                () => showDialog(
                    context: ctx, child: Alertbox(snapshot.error.toString())));
            return SizedBox();
          } else {
            return Container(
                padding: EdgeInsets.only(bottom: 20),
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
                          crossAxisCount: 1,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) =>
                            ProductTile(snapshot.data[index], title),
                      ),
                    ),
                  ],
                ));
          }
        });
    return Scaffold(
      key: globalScaffoldKey,
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
      body: future,
    );
  }
}
