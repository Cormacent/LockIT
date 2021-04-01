// import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:lockit/screens/home.dart';
// import 'package:lockit/screens/location.dart';
// import 'package:lockit/screens/account.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:lockit/screens/place.dart';


// class BottomNavBar extends StatefulWidget {
//   // const BottomNavBar({Key key, this.now}) : super(key: key);
//   const BottomNavBar({Key key, this.user}) : super(key: key);
//   // final DateTime now;

//   final FirebaseUser user;
//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   int pageIndex = 0;

//   //membuat semua page
//   // final Home _home = Home();
//   // final LocationScreen _locationScreen = new LocationScreen();
//   // final AccountScreen _accountScreen = new AccountScreen();


//   Widget _showPage = new PlaceScreen();

//   Widget _pageChooser(int page) {
//     switch (page) {
//       case 0:
//         // return Home(user: widget.user);
//         // return Home(now: widget.now,);
//         return PlaceScreen();
//         break;
//       case 1:
//         return Home();
//         break;  
//       default:
//         // return new Container(
//         //   child: new Center(
//         //     child: new Text(
//         //       widget.user.displayName,
//         //       style: TextStyle(fontSize: 30),
//         //     ),
//         //   ),
//         // );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         bottomNavigationBar: CurvedNavigationBar(
//           index: pageIndex,
//           height: 50.0,
//           items: <Widget>[
//             Icon(Icons.border_all, size: 25),
//             Icon(Icons.verified_user, size: 25),
//           ],
//           color: Colors.white,
//           buttonBackgroundColor: Colors.white,
//           backgroundColor: Colors.blue[200],
//           animationCurve: Curves.easeInOut,
//           animationDuration: Duration(milliseconds: 600),
//           onTap: (int tappedIndex) {
//             setState(() {
//               _showPage = _pageChooser(tappedIndex);
//             });
//           },
//         ),
//         body: Container(
//           color: Colors.blue[200],
//           child: Center(
//             child: _showPage,
//           ),
//         ));
//   }
// }
