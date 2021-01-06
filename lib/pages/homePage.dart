import 'package:dvjdesign/widgets/dispatchOrderList.dart';
import 'package:dvjdesign/widgets/orderList.dart';
import 'package:dvjdesign/widgets/pendingOrderList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import './aboutUsPage.dart';
import './tileslistPage.dart';
import './mosaiclistpage.dart';
import './ContactUsPage.dart';
import '../widgets/drawerTile.dart';
import './brochurePage.dart';
import '../providers/auth.dart';
import '../widgets/homeTab.dart';
import './searchPage.dart';
import '../providers/productProvider.dart';

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

  Future<void> _launch(String url) async {
    if (await canLaunch(url)) launch(url);
  }

  final List<Map> _drawerList = [
    {'text': 'Home', 'icon': Icons.home, 'ontap': (BuildContext ctx) => 0},
    {
      'text': 'About Us',
      'icon': Icons.star,
      'ontap': (BuildContext ctx) =>
          Navigator.of(ctx).pushNamed(AboutUsPage.routeName)
    },
    {'text': 'Tiles', 'icon': Icons.gradient, 'ontap': (BuildContext ctx) => 2},
    {'text': 'Mosaic', 'icon': Icons.grid_on, 'ontap': (BuildContext ctx) => 1},
    {
      'text': 'Orders',
      'icon': Icons.account_circle,
      'ontap': (BuildContext ctx) => 3
    },
    {
      'text': 'Brochures',
      'icon': Icons.book,
      'ontap': (BuildContext ctx) =>
          Navigator.of(ctx).pushNamed(BrochurePage.routeName)
    },
    {'text': 'Enquiry', 'icon': Icons.phone, 'ontap': (BuildContext ctx) => 4},
    {
      'text': 'Logout',
      'icon': Icons.exit_to_app,
      'ontap': (BuildContext ctx) {
        Provider.of<ProductProvider>(ctx, listen: false).clearTable();
        Provider.of<Auth>(ctx, listen: false).logout().then((value) =>
            Navigator.of(ctx)
                .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false));
      }
    }
  ];
  List<Widget> _children;
  bool _iscallbackset = false;

  @override
  void didChangeDependencies() {
    if (!_iscallbackset) {
      Provider.of<ProductProvider>(context, listen: false)
          .setcallback(_onTabTapped);
      _iscallbackset = true;
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _children = [
      HomeTab(),
      MosaicListPage(),
      TilesListPage(),
      OrderList(),
      ContactUsPage()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).opendb();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      // key: globalScaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('assets/images/logo.png'),
        centerTitle: true,
        // bottom: _currentIndex == 3
        //     ?
        //     : null,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 0.024 * width),
            child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () =>
                    Navigator.of(context).pushNamed(SearchPage.routeName)),
          )
        ],
      ),
      body: _children[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          onTap: _onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                title: Text(
                  'Home',
                  style: TextStyle(
                      color: _currentIndex == 0 ? Colors.blue : Colors.black),
                ),
                icon: Icon(
                  Icons.home,
                  color: _currentIndex == 0 ? Colors.blue : Colors.black,
                )),
            BottomNavigationBarItem(
                title: Text(
                  'Mosaic',
                  style: TextStyle(
                      color: _currentIndex == 1 ? Colors.blue : Colors.black),
                ),
                icon: Icon(
                  Icons.grid_on,
                  color: _currentIndex == 1 ? Colors.blue : Colors.black,
                )),
            BottomNavigationBarItem(
                title: Text(
                  'Tiles',
                  style: TextStyle(
                      color: _currentIndex == 2 ? Colors.blue : Colors.black),
                ),
                icon: Icon(
                  Icons.gradient,
                  color: _currentIndex == 2 ? Colors.blue : Colors.black,
                )),
            BottomNavigationBarItem(
                title: Text(
                  'Orders',
                  style: TextStyle(
                    color: _currentIndex == 3 ? Colors.blue : Colors.black,
                  ),
                ),
                icon: Icon(
                  Icons.account_circle,
                  color: _currentIndex == 3 ? Colors.blue : Colors.black,
                )),
            BottomNavigationBarItem(
                title: Text(
                  'Enquiry',
                  style: TextStyle(
                      color: _currentIndex == 4 ? Colors.blue : Colors.black),
                ),
                icon: Icon(
                  Icons.phone,
                  color: _currentIndex == 4 ? Colors.blue : Colors.black,
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
                    EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 10),
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
                        Provider.of<Auth>(context, listen: false).name,
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
                  .map((e) => DrawerTile(e['text'], e['icon'], () {
                        Navigator.pop(context);
                        final a = e['ontap'](context);
                        if (a is int)
                          setState(() {
                            _currentIndex = a;
                          });
                      }))
                  .toList(),
              Divider(
                color: Colors.white,
              ),
              Container(
                padding: EdgeInsets.all(15),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () => _launch(
                          'https://api.whatsapp.com/send?phone=918080150150'),
                      child: Image.asset(
                        'assets/images/whatsapp.png',
                        width: 0.07 * height,
                        height: 0.07 * height,
                      ),
                    ),
                    InkWell(
                      onTap: () =>
                          _launch('https://www.facebook.com/dvjdesign/'),
                      child: Image.asset(
                        'assets/images/fb.png',
                        width: 0.07 * height,
                        height: 0.07 * height,
                      ),
                    ),
                    InkWell(
                      onTap: () =>
                          _launch('https://www.instagram.com/dvjdesign/'),
                      child: Image.asset(
                        'assets/images/instagram.png',
                        width: 0.07 * height,
                        height: 0.07 * height,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
