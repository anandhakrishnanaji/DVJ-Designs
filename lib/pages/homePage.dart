import 'package:flutter/material.dart';

import './aboutUsPage.dart';
import '../widgets/gridTile.dart';

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
      'ontap': (BuildContext ctx) => Navigator.of(ctx).pushNamed('/')
    },
    {
      'text': 'Brochure',
      'icon': Icons.book,
      'ontap': (BuildContext ctx) => Navigator.of(ctx).pushNamed('/')
    },
    {
      'text': 'Contact',
      'icon': Icons.contact_mail,
      'ontap': (BuildContext ctx) => Navigator.of(ctx).pushNamed('/')
    },
    {
      'text': 'Notification',
      'icon': Icons.notifications,
      'ontap': (BuildContext ctx) => Navigator.of(ctx).pushNamed('/')
    },
    {
      'text': 'Register as Dealer',
      'icon': Icons.person_add,
      'ontap': (BuildContext ctx) => Navigator.of(ctx).pushNamed('/')
    }
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
      'ontap': (BuildContext ctx) => Navigator.of(ctx).pushNamed('/')
    },
    {
      'text': 'Order Status',
      'icon': Icons.account_circle,
      'ontap': (BuildContext ctx) =>
          Navigator.of(ctx).pushNamed('/')
    },
    {
      'text': 'Contact',
      'icon': Icons.phone,
      'ontap': (BuildContext ctx) =>
          Navigator.of(ctx).pushNamed('/')
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('assets/images/logo.png'),
        titleSpacing: 70,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
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
          6,
          (val) => Gridtile(_gridElements[val]['text'],
              _gridElements[val]['icon'], _gridElements[val]['ontap']),
        ),
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.black),
        child: Drawer(
          child: Column(
            children:[],
          ),
        ),
      ),
    );
  }
}
