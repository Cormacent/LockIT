import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lockit/screens/place.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool loginPressed = true;
  bool signUpPressed = false;
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    loginPressed = true;
    signUpPressed = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: Image(
                image: AssetImage(
                  'assets/icons/titleIcon.png',
                ),
              ),
              height: 50,
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
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
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: RaisedButton(
                            color: (loginPressed)
                                ? Colors.white
                                : Colors.grey[300],
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  color: (loginPressed)
                                      ? Colors.blue[400]
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                            onPressed: () {
                              setState(() {
                                loginPressed = true;
                                signUpPressed = false;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          color:
                              (signUpPressed) ? Colors.white : Colors.grey[300],
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.only(
                              topRight: const Radius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                                color: (signUpPressed)
                                    ? Colors.blueAccent
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          onPressed: () {
                            setState(() {
                              signUpPressed = true;
                              loginPressed = false;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  (loginPressed) ? _loginForm() : _signUpForm()
                ],
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }

  Widget _signUpForm() {
    var container = Container(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 40,
              child: TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please Type an Email!';
                  }
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 40,
              child: TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please Type an Password atleast 6 characters';
                  }
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    labelText: 'Password'),
                obscureText: true,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Divider(thickness: 1.5, color: Colors.grey),
            Container(
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                color: Colors.blue[200],
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                ),
                child: Text(
                  'SIGN UP',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: signUp,
              ),
            )
          ],
        ),
      ),
    );
    return container;
  }

  Widget _loginForm() {
    var container = Container(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 40,
              child: TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please Type an Email!';
                  }
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 40,
              child: TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please Type an Password atleast 6 characters';
                  }
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    labelText: 'Password'),
                obscureText: true,
              ),
            ),
            SizedBox(
              height: 20.0,
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
                  'LOGIN',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: signIn,
              ),
            )
          ],
        ),
      ),
    );
    return container;
  }

  Future<void> signIn() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: _email, password: _password))
            .user;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PlaceScreen(
              user: user.email,
            ),
          ),
        );
      } catch (e) {
        print(e.message);
      }
    }
  }

  Future<void> signUp() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: _email, password: _password))
            .user;
        user.sendEmailVerification();
        Navigator.of(context).pop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PlaceScreen(
              user: user.email,
            ),
          ),
        );
      } catch (e) {
        print(e.message);
      }
    }
  }
}
