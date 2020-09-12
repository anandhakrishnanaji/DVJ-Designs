import 'package:dvjdesign/pages/OTPVerificationPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './pages/homePage.dart';
import 'pages/loginPage.dart';
import './pages/registrationPage.dart';
import './pages/aboutUsPage.dart';
//import './pages/productslistPage.dart';
// import './pages/ContactUsPage.dart';
import './pages/notificationPage.dart';
import './pages/productListPage.dart';
import './providers/productProvider.dart';
// import './pages/brochurePage.dart';
import './pages/orderStatuspage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ProductProvider(),
        child: MaterialApp(
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
          home: LoginPage(),
          routes: {
            OTPVerification.routeName: (ctx) => OTPVerification(),
            RegistrationPage.routeName: (ctx) => RegistrationPage(),
            HomePage.routeName: (ctx) => HomePage(),
            AboutUsPage.routeName: (ctx) => AboutUsPage(),
            NotificationsPage.routeName: (ctx) => NotificationsPage(),
            ProductListPage.routeName: (ctx) => ProductListPage(),
            OrderStatusPage.routeName: (ctx) => OrderStatusPage()
          },
        ));
  }
}
