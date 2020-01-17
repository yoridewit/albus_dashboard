import 'package:albus_dashboard/dashboard.dart';
import 'package:albus_dashboard/login_screen.dart';
import 'package:albus_dashboard/services/auth.dart';
import 'package:albus_dashboard/services/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BaseAuth auth = AuthProvider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool isLoggedIn = snapshot.hasData;
          return isLoggedIn ? Dashboard() : LoginPage();
        }
        //simple loading screen
        return Scaffold(
          body: Container(
            alignment: Alignment.center,
            child: SpinKitRing(
              color: Theme.of(context).accentColor,
            ),
          ),
        );
      },
    );
  }
}
