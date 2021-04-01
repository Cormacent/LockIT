import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lockit/screens/auth.dart';
import 'package:lockit/screens/timer_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'auth.dart';

class BarcodeScreen extends StatefulWidget {
  final String timer, uuid, user, lokcerId;
  BarcodeScreen({this.timer, this.uuid, this.user, this.lokcerId});
  @override
  _BarcodeScreenState createState() => _BarcodeScreenState();
}

class _BarcodeScreenState extends State<BarcodeScreen> {
  bool rentPressed = true;
  bool historyPressed = false;
  GlobalKey globalKey = new GlobalKey();
  Map<String, String> rent = Map();
  var barcodeDone = 'Scaning Barcode';

  @override
  void initState() {
    rentPressed = true;
    historyPressed = false;
    print(widget.uuid);
    print(widget.timer);
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        child: Center(
                          child: RepaintBoundary(
                            key: globalKey,
                            child: QrImage(
                              data: widget.uuid,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(thickness: 1.5, color: Colors.grey),
                      SizedBox(
                        height: 10.0,
                      ),

                      Text(
                        "Please press the button below then point the barcode to the camera :) ",
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(
                        height: 10.0,
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          color: Colors.blue[200],
                          child: Text(
                            'START RENT',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: activeCamera,
                        ),
                      ),

                      SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: Text(
                          '$barcodeDone',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                      // for set time later
                      //Text('${(selected.difference(DateTime.now()))}'),
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

  Future<void> activeCamera() async {
    Firestore.instance
        .collection('activeCamera')
        .document('1')
        .updateData({'status': true});
    barcodeDone = 'Scan Successfully !!';
    DocumentSnapshot snapshot =
        await Firestore.instance.collection('rent').document(widget.uuid).get();
    bool status = snapshot['status'];
    if (status == true) {
      try {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TimerScreen(
              timer: '${widget.timer}',
              uuid: '${widget.uuid}',
              user: '${widget.user}',
              lockerId: '${widget.lokcerId}',
            ),
          ),
        );
      } catch (e) {
        print(e.message);
      }
    }
  }
}
