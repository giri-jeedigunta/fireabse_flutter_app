//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart';

class Registration extends StatefulWidget {
  static String routeName = 'Registration';

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String email, name, password;

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
                    'Registration',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'What do people call you?',
                      labelText: 'Full Name *',
                    ),
                    onChanged: (String value) {
                      name = value;
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
                      hintText: 'Setup a password?',
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
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'What is your email?',
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
                  RaisedButton(
                    onPressed: () async {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        print('valid');
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Creating new user ....'),
                            duration: Duration(seconds: 120),
                          ),
                        );

                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (newUser != null) {
                            print(newUser);
                            Scaffold.of(context).hideCurrentSnackBar();
                            Navigator.pushNamed(context, Login.routeName);
                          }
                        } catch (e) {
                          print('Firebabse Errros : $e');
                        }
                      }
                    },
                    child: Text('Add'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
