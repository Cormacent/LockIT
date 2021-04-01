import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lockit/screens/auth.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/screens/AuthScreen': (BuildContext context) => new AuthScreen()
    },
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/screens/AuthScreen');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new FittedBox(
      child: Image(
        image: AssetImage(
          'assets/icons/Splash.png',
        ),
      ),
      fit: BoxFit.fill,
    );
    // Image(
    //     image: AssetImage(
    //       'assets/icons/Splash.png',
    //     ),
    //   ),
  }
}
