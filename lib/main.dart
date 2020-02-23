import 'package:fireabse_flutter_app/login.dart';
import 'package:fireabse_flutter_app/registration.dart';
import 'package:fireabse_flutter_app/dashboard.dart';
import 'package:flutter/material.dart';

void main() => runApp(FireBaseApp());

class FireBaseApp extends StatefulWidget {
  @override
  _FireBaseAppState createState() => _FireBaseAppState();
}

class _FireBaseAppState extends State<FireBaseApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Login.routeName,
      routes: {
        Login.routeName: (context) => Login(),
        Registration.routeName: (context) => Registration(),
        Dashboard.routeName: (context) => Dashboard(),
      },
    );
  }
}
