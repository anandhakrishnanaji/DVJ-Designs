import 'package:flutter/material.dart';

import './pages/homePage.dart';
import 'pages/loginPage.dart';
import './pages/registrationPage.dart';
import './pages/aboutUsPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.grey[600],
          visualDensity: VisualDensity.adaptivePlatformDensity,
          inputDecorationTheme: InputDecorationTheme(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 5)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 3)))),
      home: RegistrationPage(),
      routes: {
        HomePage.routeName: (ctx) => HomePage(),
        AboutUsPage.routeName: (ctx) => AboutUsPage()
      },
    );
  }
}
