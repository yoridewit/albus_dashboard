import 'package:albus_dashboard/constants/style.dart';
import 'package:albus_dashboard/services/auth.dart';
import 'package:albus_dashboard/services/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:albus_dashboard/animation/FadeInAnimation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  String email, password;
  String error = '';

  final formKey = GlobalKey<FormState>();

  bool loading = false;

  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  Future<String> signIn() async {
    String userId;
    try {
      print('signing in...');
      final BaseAuth auth = AuthProvider.of(context).auth;
      final String userId =
          await auth.signInWithEmailAndPassword(email, password);
      print('Signed in: $userId');
    } catch (e) {
      print('Error: ${e.toString()}');
    }
    return userId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Image.asset(
              'assets/logo_white.png',
              width: 200,
            ),
            SizedBox(height: 20),
            Container(
              width: 500,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: loading
                  ? SpinKitRing(
                      color: Theme.of(context).accentColor,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                error,
                                style: Body1TextStyle.copyWith(
                                    color: Colors.redAccent),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0,
                                      right: 25.0,
                                      top: 15.0,
                                      bottom: 5.0),
                                  child: Container(
                                    child: TextFormField(
                                      decoration: buildInputDecorationFormat(
                                          context, 'Email'),
                                      validator: (value) => value.isEmpty
                                          ? 'Email is required'
                                          : validateEmail(value.trim()),
                                      onChanged: (value) {
                                        this.email = value;
                                      },
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0,
                                    right: 25.0,
                                    top: 20.0,
                                    bottom: 5.0),
                                child: Container(
                                  height: 50.0,
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration: buildInputDecorationFormat(
                                        context, 'Password'),
                                    validator: (value) => value.isEmpty
                                        ? 'Password is required'
                                        : null,
                                    onChanged: (value) {
                                      this.password = value;
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 100),
                                child: FlatButton(
                                  color: Colors.deepOrange,
                                  onPressed: () async {
                                    if (checkFields()) {
                                      setState(() => loading = true);
                                      dynamic result = await signIn();
                                      if (result == null) {
                                        if (mounted) {
                                          setState(() {
                                            loading = false;
                                            error =
                                                'Login failed, check credentials';
                                          });
                                        }
                                      }
                                    }
                                  },
                                  child: Center(
                                    child: Text(
                                      'Sign in',
                                      style: Body1TextStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration buildInputDecorationFormat(
      BuildContext context, String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle:
          Body1TextStyle.copyWith(color: Theme.of(context).primaryColor),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey[300],
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey[300],
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).accentColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.redAccent,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
