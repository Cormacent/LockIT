import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lockit/screens/duration_screen.dart';
import 'package:lockit/screens/timer_screen.dart';
import 'auth.dart';

class PlaceScreen extends StatefulWidget {
  const PlaceScreen({Key key, this.user}) : super(key: key);
  final String user;

  @override
  _PlaceScreenState createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  bool placePressed = true;
  bool historyPressed = false;
  bool availabel1 = false;
  bool availabel = true;

  @override
  void initState() {
    placePressed = true;
    historyPressed = false;
    // availabel1 = false;
    // availabel = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blue[200],
                    border: Border.all(color: Colors.blue[200])),
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0, right: 15.0, left: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Spacer(),
                      IconButton(
                        icon: Icon(Icons.power_settings_new),
                        color: Colors.white,
                        iconSize: 30.0,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AuthScreen(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 60.0,
              ),
              SizedBox(
                child: Image(
                  image: AssetImage(
                    'assets/icons/titleIcon.png',
                  ),
                ),
                height: 50,
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(70.0, 0, 70.0, 0),
                  child: Text(
                    'Please choose an available locker below or a green light to start your rent :D',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0.5,
                        blurRadius: 10.0,
                        offset: Offset(
                          5.0, //horizontal
                          10.0, //vertical
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: RaisedButton(
                                color: Colors.white,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(10.0),
                                    topRight: const Radius.circular(10.0),
                                  ),
                                ),
                                child: Text(
                                  'PLACE',
                                  style: TextStyle(
                                      color: Colors.blue[400],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                          // Expanded(
                          //   child: RaisedButton(
                          //     color: Colors.grey[300],
                          //     materialTapTargetSize:
                          //         MaterialTapTargetSize.shrinkWrap,
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: new BorderRadius.only(
                          //         topRight: const Radius.circular(10.0),
                          //       ),
                          //     ),
                          //     child: Text(
                          //       'HISTORY',
                          //       style: TextStyle(
                          //           color: Colors.white,
                          //           fontWeight: FontWeight.bold,
                          //           fontSize: 18.0),
                          //     ),
                          //     onPressed: toHistory,
                          //   ),
                          // ),
                        
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Masjid Al-Azhar Raya',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                                'Jl. Dr. Sumarno No.6, RW.8, Pulo Gebang, Kec. Cakung, Kota Jakarta Timur, Daerah Khusus Ibukota Jakarta 13950'),
                            SizedBox(
                              height: 10.0,
                            ),
                            Divider(thickness: 1.5, color: Colors.grey),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: toLocker1,
                                          splashColor: Colors.blue,
                                          icon: Icon(Icons.dns),
                                          color: Colors.blueGrey,
                                          iconSize: 50.0,
                                          tooltip: "Go Rent!",
                                        ),
                                        // RaisedButton.icon(
                                        //     shape: RoundedRectangleBorder(
                                        //       borderRadius:
                                        //           new BorderRadius.circular(5.0),
                                        //     ),
                                        //     color: Colors.white54,
                                        //     label: Text('aaa'),
                                        //     icon: Icon(Icons.dns),
                                        //     onPressed: () {},
                                        //   ),
                                        // Icon(
                                        //   (availabel1)
                                        //       ? Icons.check_circle
                                        //       : Icons.remove_circle,
                                        //   color:
                                        //       (availabel1) ? Colors.green : Colors.red,
                                        // ),
                                        _availabelLocker1(),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text('Locker 1')
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: toLocker2,
                                          splashColor: Colors.blue,
                                          color: Colors.blueGrey,
                                          icon: Icon(Icons.dns),
                                          iconSize: 50.0,
                                          tooltip: "Go Rent!",
                                        ),
                                        _availabelLocker2(),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text('Locker 2')
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> toHistory() async {
    DocumentSnapshot snapshot = await Firestore.instance
        .collection('history')
        .document(widget.user)
        .get();
        // print('${snapshot.data['timer']}');
        // print('${snapshot.data['uuid']}'); 
        // print('${snapshot.data['user']}');
        // print('${snapshot.data['lockerId']}');
    if (snapshot.exists) {
      try {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TimerScreen(
              timer: snapshot.data['timer'],
              uuid: snapshot.data['uuid'],
              user: snapshot.data['user'],
              lockerId: snapshot.data['lockerId'],
            ),
          ),
        );
      } catch (e) {
        print(e.message);
      }
    } else {
      print('disabled');
    }
  }

  Future<void> toLocker1() async {
    DocumentSnapshot snapshot = await Firestore.instance
        .collection('history')
        .document(widget.user)
        .get();
    if (!snapshot.exists) {
      try {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DurationScreen(lockerId: '1', user: widget.user, status: false),
          ),
        );
      } catch (e) {
        print(e.message);
      }
    } else {
      print('disabled');
    }
  }

  Future<void> toLocker2() async {
    DocumentSnapshot snapshot = await Firestore.instance
        .collection('history')
        .document(widget.user)
        .get();
    if (!snapshot.exists) {
      try {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DurationScreen(lockerId: '2', user: widget.user, status: false),
          ),
        );
      } catch (e) {
        print(e.message);
      }
    } else {
      print('disabled');
    }
  }
}

Widget _availabelLocker1() {
  return StreamBuilder(
    stream: Firestore.instance.collection('locker').document('1').snapshots(),
    builder: (context, snapshot) {
      return Icon(
        (snapshot.data['status']) ? Icons.check_circle : Icons.remove_circle,
        color: (snapshot.data['status']) ? Colors.green : Colors.red,
      );
    },
  );
}

Widget _availabelLocker2() {
  return StreamBuilder(
    stream: Firestore.instance.collection('locker').document('2').snapshots(),
    builder: (context, snapshot) {
      return Icon(
        (snapshot.data['status']) ? Icons.check_circle : Icons.remove_circle,
        color: (snapshot.data['status']) ? Colors.green : Colors.red,
      );
    },
  );
}
