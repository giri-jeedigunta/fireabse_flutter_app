import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireabse_flutter_app/login.dart';

class Dashboard extends StatefulWidget {
  static String routeName = 'Dashboard';

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  @override
  void initState() {
    super.initState();
    getLoggedInUser();
  }

  void getLoggedInUser() async {
    try {
      final user = await _auth.currentUser();
      loggedInUser = user;
      print('loggedin .... ${loggedInUser.email}');
    } catch (e) {
      print('errors $e');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Text('Logged In: ${loggedInUser.email}'),
              ),
              RaisedButton(
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.pushNamed(context, Login.routeName);
                },
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      );
}
