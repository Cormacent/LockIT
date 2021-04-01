import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:lockit/screens/auth.dart';
import 'package:lockit/screens/barcode_screen.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'auth.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DurationScreen extends StatefulWidget {
  final String lockerId, user;
  final bool status;
  DurationScreen({this.lockerId, this.user, this.status});

  @override
  _DurationScreenState createState() => _DurationScreenState();
}

class _DurationScreenState extends State<DurationScreen> {
  final databaseReference = Firestore.instance;
  bool placePressed = false;
  bool availabel = false;
  String _time = "Not set";
  DateTime selected;
  DateTime now;
  DateTime alert;
  String countDown;
  String formattedTime;
  var uuid = new Uuid();
  String rentId;

  @override
  void initState() {
    placePressed = false;
    availabel = true;
    now = DateTime.now();
    uuid.v4();
    rentId = uuid.v4().toString();
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
                height: 50.0,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Start :'),
                      SizedBox(
                        height: 10.0,
                      ),

                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        elevation: 4.0,
                        onPressed: () {
                          DatePicker.showTimePicker(context,
                              theme: DatePickerTheme(
                                containerHeight: 210.0,
                              ),
                              showTitleActions: true, onConfirm: (time) {
                            print('confirm $time');
                            _time = '${time.hour} : ${time.minute}';
                            selected = time;
                            countDown =
                                '${selected.difference(DateTime.now()).inSeconds}';
                            setState(() {});
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(10, 10.0, 10, 10.0),
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.access_time,
                                          size: 18.0,
                                          color: Colors.blue[200],
                                        ),
                                        Text(
                                          " $_time",
                                          style: TextStyle(
                                              color: Colors.blue[200],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              VerticalDivider(
                                thickness: 1.5,
                                color: Colors.grey,
                                width: 20.0,
                              ),
                              Center(
                                child: Text(
                                  "Set",
                                  style: TextStyle(
                                      color: Colors.blue[200],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(thickness: 1.5, color: Colors.grey),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          color: Colors.blue[200],
                          child: Text(
                            'CREATE',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Firestore.instance
                                .collection('rent')
                                .document(rentId) 
                                .setData({
                              'lockerId': widget.lockerId,
                              'user': widget.user,
                              'status': widget.status,
                            });
                            Firestore.instance
                                .collection('history')
                                .document(widget.user) 
                                .setData({
                              'lockerId': widget.lockerId,
                              'user': widget.user,
                              'status': widget.status,
                              'uuid' : uuid,
                              'timer': countDown,
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BarcodeScreen(
                                    timer: countDown,
                                    user:widget.user,
                                    uuid: rentId,
                                    lokcerId: widget.lockerId,),
                              ),
                            );
                          },
                        ),
                      ),
                      // for set time later
                      // Text('$_time'),
                      // Text('$selected'),
                      // Text('$now'),

                      // TimerBuilder.periodic(Duration(seconds: 1), alignment: Duration.zero,
                      //     builder: (context) {
                      //   // This function will be called every second until the alert time
                      //   // var now = DateTime.now();
                      //   var remaining = selected.difference(now);
                      //   return Text(
                      //     formatDuration(remaining),
                      //   );
                      // })
                      // Text('${selected.difference(now).inSeconds}'),

                      //Text('${(selected.difference(now))}')
                      // Divider(thickness: 1.5, color: Colors.grey[300]),
                      // SizedBox(
                      //   height: 10.0,
                      // ),
                      // Container(
                      //   child: Center(
                      //     child: Column(
                      //       children: <Widget>[
                      //         Text('Remaining Time !'),
                      //       ],
                      //     ),
                      //   ),
                      // )
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
}
