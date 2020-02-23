//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireabse_flutter_app/registration.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dashboard.dart';

class Login extends StatefulWidget {
  static String routeName = 'Login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String email, password;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Builder(
          builder: (BuildContext context) => SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30),
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Enter your email?',
                      labelText: 'Email *',
                    ),
                    onChanged: (String value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Enter your password?',
                      labelText: 'Password *',
                    ),
                    onChanged: (String value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  RaisedButton(
                    onPressed: () async {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        print('valid');
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Processing Data ....'),
                            duration: Duration(seconds: 120),
                          ),
                        );

                        try {
                          final signedInUser =
                              await _auth.signInWithEmailAndPassword(
                                  email: email, password: password);
                          if (signedInUser != null) {
                            print(signedInUser);
                            Scaffold.of(context).hideCurrentSnackBar();
                            Navigator.pushNamed(context, Dashboard.routeName);
                          }
                        } catch (e) {
                          print('Firebase Errros : $e');
                        }
                      }
                    },
                    child: Text('Login'),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Registration.routeName);
                    },
                    child: Text('Sign up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
