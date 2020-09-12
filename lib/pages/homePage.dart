import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './aboutUsPage.dart';
import './productslistPage.dart';
import './ContactUsPage.dart';
import '../widgets/drawerTile.dart';
import './brochurePage.dart';
import './orderStatuspage.dart';
import '../providers/auth.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homepage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _children = [
    ProductsListPage(),
    ProductsListPage(),
    BrochurePage(),
    ContactUsPage()
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
    {'text': 'Tiles', 'icon': Icons.gradient, 'ontap': null},
    {'text': 'Mosaic', 'icon': Icons.grid_on, 'ontap': null},
    {'text': 'Brochure', 'icon': Icons.book, 'ontap': null},
    {
      'text': 'Order Status',
      'icon': Icons.account_circle,
      'ontap': (BuildContext ctx) =>
          Navigator.of(ctx).pushNamed(OrderStatusPage.routeName)
    },
    {'text': 'Contact', 'icon': Icons.phone, 'ontap': null},
    {
      'text': 'Logout',
      'icon': Icons.exit_to_app,
      'ontap': (BuildContext ctx) => Provider.of<Auth>(ctx, listen: false)
          .logout()
          .then((value) => Navigator.of(ctx)
              .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false))
    }
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
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                title: Text(
                  'Mosaic',
                  style: TextStyle(
                      color: _currentIndex == 0 ? Colors.blue : Colors.black),
                ),
                icon: Icon(
                  Icons.grid_on,
                  color: _currentIndex == 0 ? Colors.blue : Colors.black,
                )),
            BottomNavigationBarItem(
                title: Text(
                  'Tiles',
                  style: TextStyle(
                      color: _currentIndex == 1 ? Colors.blue : Colors.black),
                ),
                icon: Icon(
                  Icons.gradient,
                  color: _currentIndex == 1 ? Colors.blue : Colors.black,
                )),
            BottomNavigationBarItem(
                title: Text(
                  'Brochure',
                  style: TextStyle(
                      color: _currentIndex == 2 ? Colors.blue : Colors.black),
                ),
                icon: Icon(
                  Icons.book,
                  color: _currentIndex == 2 ? Colors.blue : Colors.black,
                )),
            BottomNavigationBarItem(
                title: Text(
                  'Contact',
                  style: TextStyle(
                      color: _currentIndex == 3 ? Colors.blue : Colors.black),
                ),
                icon: Icon(
                  Icons.phone,
                  color: _currentIndex == 3 ? Colors.blue : Colors.black,
                ))
          ]),
      drawer: Theme(
        data: Theme.of(context)
            .copyWith(canvasColor: Color.fromRGBO(46, 46, 46, 1)),
        child: Drawer(
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 10),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/images/user.png',
                      ),
                      radius: 25,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        Provider.of<Auth>(context, listen: false).username,
                        style: TextStyle(color: Colors.white, fontSize: 24),
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
