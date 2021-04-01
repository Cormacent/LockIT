import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lockit/screens/auth.dart';
import 'package:lockit/screens/place.dart';
import 'package:timer_builder/timer_builder.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'auth.dart';

class TimerScreen extends StatefulWidget {
  final String timer, uuid, user, lockerId;
  TimerScreen({this.timer, this.uuid, this.user, this.lockerId});

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  bool rentPressed = true;
  bool historyPressed = false;
  bool isSwitched = true;
  DateTime selected;
  DateTime now;
  DateTime alert;
  String formattedTime;
  var rentTime;
  var start;
  var end;
  bool switchControl = false;
  var textHolder = 'Unlock';
  // var _onPressed;

  GlobalKey globalKey = new GlobalKey();

  @override
  void initState() {
    rentPressed = true;
    historyPressed = false;
    rentTime = int.parse('${widget.timer}');
    alert = DateTime.now().add(Duration(seconds: rentTime));
    now = DateTime.now();
    end = alert.toString();
    // _onPressed = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if(isSwitched){
    //   Firestore.instance
    //     .collection('rent')
    //     .document(widget.uuid)
    //     .updateData({'status': true});
    // }else{
    //   Firestore.instance
    //     .collection('rent')
    //     .document(widget.uuid)
    //     .updateData({'status': false});
    // }
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
                height: 50.0,
              ),

              //Mulai bagian Kotak
              Container(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
                  width: 300,

                  //MULAI BAGIAN ISI
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    child: TimerBuilder.scheduled([alert], builder: (context) {
                      // This function will be called once the alert time is reached
                      var now = DateTime.now();
                      var reached = now.compareTo(alert) >= 0;
                      final textStyle = Theme.of(context).textTheme.title;
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              reached ? Icons.alarm_on : Icons.alarm,
                              color: reached ? Colors.red : Colors.green,
                              size: 80,
                            ),
                            !reached
                                ? TimerBuilder.periodic(Duration(seconds: 1),
                                    alignment: Duration.zero,
                                    builder: (context) {
                                    // This function will be called every second until the alert time
                                    var now = DateTime.now();
                                    var remaining = alert.difference(now);
                                    return Text(
                                      formatDuration(remaining),
                                      style: textStyle,
                                    );
                                  })
                                : Text("Your Timer is Over !",
                                    style: textStyle),
                            SizedBox(
                              height: 10.0,
                            ),
                            Divider(thickness: 1.5, color: Colors.grey),
                            SizedBox(
                              height: 10.0,
                            ),
                            // Center(
                            //   child: Container(
                            //     child: Column(
                            //       children: <Widget>[
                            //         // Row(
                            //         //   children: <Widget>[
                            //         //     Text("Start :"),
                            //         //     // Text(formatDuration(now)),
                            //         //   ],
                            //         // ),
                            //         Row(
                            //           children: <Widget>[
                            //             Text("End   :"),
                            //             Text(formatDuration()),
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: RaisedButton(
                                color: Colors.red[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5.0),
                                ),
                                child: Text(
                                  'Stop Rent !',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Firestore.instance
                                      .collection('rent')
                                      .document('${widget.uuid}')
                                      .delete();
                                  Firestore.instance
                                      .collection('history')
                                      .document('${widget.user}')
                                      .delete();
                                  Firestore.instance
                                      .collection('locker')
                                      .document(widget.lockerId)
                                      .updateData({'status': true});
                                  Firestore.instance
                                      .collection('reset')
                                      .document('1')
                                      .updateData({'resetservo': '1'});
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlaceScreen(
                                        user: widget.user,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  )),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
                width: 300,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child: Column(
                    children: <Widget>[
                      // Transform.scale(
                      // scale: 3.0,
                      // child:
                      Transform.scale(
                        scale: 1.5,
                        child: Switch(
                          onChanged: toggleSwitch,
                          value: switchControl,
                          activeColor: Colors.blue,
                          activeTrackColor: Colors.green,
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey,
                        ),
                      ),
                      Text(
                        '$textHolder',
                        style: TextStyle(fontSize: 24),
                      )
                    ],
                  ),
                ),
              ),
              // Transform.scale(
              //   scale: 3.0,
              //   child: new Switch(
              //     value: isSwitched,
              //     onChanged: (value) {
              //       setState(() {
              //         isSwitched = value;
              //       });
              //     },
              //     activeTrackColor: Colors.lightGreenAccent,
              //     activeColor: Colors.green,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void toggleSwitch(bool value) {
    if (switchControl == false) {
      setState(() {
        switchControl = true;
        textHolder = 'Locked';
        Firestore.instance
            .collection('rent')
            .document(widget.uuid)
            .updateData({'status': false});
      });
      print('Switch is ON');
      // Put your code here which you want to execute on Switch ON event.

    } else {
      setState(() {
        switchControl = false;
        textHolder = 'unlocked';
        Firestore.instance
            .collection('rent')
            .document(widget.uuid)
            .updateData({'status': true});
      });
      print('Switch is OFF');
      // Put your code here which you want to execute on Switch OFF event.
    }
  }
}

//buat format durasi
String formatDuration(Duration d) {
  String f(int n) {
    return n.toString().padLeft(2, '0');
  }

  d += Duration(microseconds: 999999);
  return "${f(d.inHours)}:${f(d.inMinutes)}:${f(d.inSeconds % 60)}";
}
