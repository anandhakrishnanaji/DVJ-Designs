import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './aboutUsPage.dart';
import '../widgets/gridTile.dart';
import '../providers/productProvider.dart';
import './productslistPage.dart';
import './ContactUsPage.dart';
import './notificationPage.dart';
import '../widgets/drawerTile.dart';
import './brochurePage.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/homepage';

  final List<Map> _gridElements = [
    {
      'text': 'About Us',
      'icon': Icons.star,
      'ontap': (BuildContext ctx) =>
          Navigator.of(ctx).pushNamed(AboutUsPage.routeName)
    },
    {
      'text': 'Products',
      'icon': Icons.shopping_basket,
      'ontap': (BuildContext ctx) =>
          Navigator.of(ctx).pushNamed(ProductsListPage.routeName)
    },
    {
      'text': 'Brochure',
      'icon': Icons.book,
      'ontap': (BuildContext ctx) => Navigator.of(ctx).pushNamed(BrochurePage.routeName)
    },
    {
      'text': 'Contact',
      'icon': Icons.contact_mail,
      'ontap': (BuildContext ctx) =>
          Navigator.of(ctx).pushNamed(ContactUsPage.routeName)
    },
    // {
    //   'text': 'Notification',
    //   'icon': Icons.notifications,
    //   'ontap': (BuildContext ctx) =>
    //       Navigator.of(ctx).pushNamed(NotificationsPage.routeName)
    // },
    // {
    //   'text': 'Register as Dealer',
    //   'icon': Icons.person_add,
    //   'ontap': (BuildContext ctx) => Navigator.of(ctx).pushNamed('/')
    // }
  ];

  final List<Map> _drawerList = [
    {
      'text': 'Home',
      'icon': Icons.home,
      'ontap': (BuildContext ctx) =>
          Navigator.of(ctx).pushReplacementNamed(HomePage.routeName)
    },
    {
      'text': 'About Us',
      'icon': Icons.star,
      'ontap': (BuildContext ctx) =>
          Navigator.of(ctx).pushNamed(AboutUsPage.routeName)
    },
    {
      'text': 'Tiles',
      'icon': Icons.gradient,
      'ontap': (BuildContext ctx) => Navigator.of(ctx).pushNamed('/')
    },
    {
      'text': 'Mosaic',
      'icon': Icons.grid_on,
      'ontap': (BuildContext ctx) => Navigator.of(ctx).pushNamed('/')
    },
    {
      'text': 'Brochure',
      'icon': Icons.book,
      'ontap': (BuildContext ctx) => Navigator.of(ctx).pushNamed(BrochurePage.routeName)
    },
    {
      'text': 'Order Status',
      'icon': Icons.account_circle,
      'ontap': (BuildContext ctx) => Navigator.of(ctx).pushNamed('/')
    },
    {
      'text': 'Contact',
      'icon': Icons.phone,
      'ontap': (BuildContext ctx) =>
          Navigator.of(ctx).pushNamed(ContactUsPage.routeName)
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
                onPressed: null),
          )
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          4,
          (val) => Gridtile(_gridElements[val]['text'],
              _gridElements[val]['icon'], _gridElements[val]['ontap']),
        ),
      ),
      drawer: Theme(
        data: Theme.of(context)
            .copyWith(canvasColor: Color.fromRGBO(46, 46, 46, 1)),
        child: Drawer(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 30,left: 20,right: 20,bottom: 10),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/images/user.png',
                      ),
                      radius: 25,
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 30),
                      child: Text(
                        'Username',
                        style: TextStyle(color: Colors.white,fontSize: 24),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              ..._drawerList
                  .map((e) => DrawerTile(e['text'], e['icon'], e['ontap']))
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}
