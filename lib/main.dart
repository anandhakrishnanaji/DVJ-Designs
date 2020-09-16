import 'package:dvjdesign/pages/OTPVerificationPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import './pages/homePage.dart';
import 'pages/loginPage.dart';
import './pages/registrationPage.dart';
import './pages/aboutUsPage.dart';
import './pages/productListPage.dart';
import './providers/productProvider.dart';
import './pages/orderStatuspage.dart';
import './providers/auth.dart';
import './pages/productPreviePage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ProductProvider>(
              create: (_) => ProductProvider()),
          ChangeNotifierProvider<Auth>(create: (_) => Auth())
        ],
        child: Consumer<Auth>(
          builder: (context, value, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: Colors.black,
              accentColor: Colors.grey[600],
              visualDensity: VisualDensity.adaptivePlatformDensity,
              inputDecorationTheme: InputDecorationTheme(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 5)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 3))),
            ),
            routes: {
              "/": (ctx) => FutureBuilder(
                  future: value.isloggedin(),
                  builder: (_, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? Scaffold()
                          : (snapshot.data != null && snapshot.data)
                              ? HomePage()
                              : RegistrationPage()),
              OTPVerification.routeName: (ctx) => OTPVerification(),
              LoginPage.routeName: (ctx) => LoginPage(),
              HomePage.routeName: (ctx) => HomePage(),
              AboutUsPage.routeName: (ctx) => AboutUsPage(),
              ProductListPage.routeName: (ctx) => ProductListPage(),
              OrderStatusPage.routeName: (ctx) => OrderStatusPage(),
              ProductPreview.routeName:(ctx)=>ProductPreview(),
            },
          ),
        ));
  }
}
