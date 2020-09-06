import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/homepage';

  final List<Map> _gridElements = [
    {
      'text': 'About Us',
      'icon': Icons.info,
      'ontap': (BuildContext ctx) => Navigator.of(ctx).pushNamed('/')
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
            (val) => InkWell(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          _gridElements[val]['icon'],
                          size: 35,
                        ),
                        Text(
                          _gridElements[val]['text'],
                          style: TextStyle(fontSize: 24),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  onTap: () => _gridElements[val]['ontap'](context),
                )),
      ),
    );
  }
}
