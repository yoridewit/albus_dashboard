import 'package:albus_dashboard/root_page.dart';
import 'package:albus_dashboard/services/auth.dart';
import 'package:albus_dashboard/services/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as Firebase;
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'auth_service.dart';

Future<void> main() async {
  if (Firebase.apps.isEmpty) {
    print('Firebase: ${Firebase.apps}');
    Firebase.initializeApp(
      apiKey: "AIzaSyCLx837XZfo64a2snV7S3hbrzh4A4hvKe0",
      authDomain: "albushealthcare-fd3da.firebaseapp.com",
      databaseURL: "https://albushealthcare-fd3da.firebaseio.com",
      projectId: "albushealthcare-fd3da",
      storageBucket: "albushealthcare-fd3da.appspot.com",
      messagingSenderId: "35679996071",
      appId: "1:35679996071:web:da1c19b63cb47de105b382",
    );
  }
  runApp(MyApp());
}

Future<void> getTest() async {
  final fs.Firestore firestore = fb.firestore();
  var testString = await firestore
      .collection('userbase')
      .doc('hagaziekenhuis_OK_volwassenen')
      .get();
  print(testString);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getTest();
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RootPage(),
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          buttonColor: Colors.deepOrange,
          fontFamily: 'Roboto',
          primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
          accentColor: Colors.deepOrange,
          primaryColorLight: Color.fromRGBO(64, 75, 96, .9),
        ),
      ),
    );
    // );
  }
}
