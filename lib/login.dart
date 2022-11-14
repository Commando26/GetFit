import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

/*
  login.dart allows users to login, they are then sent to the home screen
 */

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => Home();
}

class Home extends State<loginPage> {
  late String emailString;
  late String passwordString;
  bool showSpinner = false;
  final _fbApp = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: const Text(
                        'GetFit',
                        style: TextStyle(
                            fontFamily: 'Times New Roman',
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 40
                        ),
                      )),
                  Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(20),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 30
                        ),
                      )),
                  Container(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        onChanged: (value) {
                          emailString = value;
                          //Do something with the user input.
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Enter a username"
                        ),
                      )
                  ),
                  Container(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        onChanged: (value) {
                          passwordString = value;
                          //Do something with the user input.
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Enter a password"
                        ),
                      )
                  ),
                  Container(
                      height: 90,
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                          child: const Text("Login"),
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              final user = await _fbApp.signInWithEmailAndPassword(
                                  email: emailString, password: passwordString);
                              if (user != null) {
                                Navigator.pushNamed(context, 'homescreen');
                              }
                            } catch (e) {
                              print(e);
                            }
                            setState(() {
                              showSpinner = false;
                            });
                          }),
                      ),
                  Container(
                      height: 90,
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                          child: const Text("No Account?"),
                          onPressed: () {
                            Navigator.pushNamed(context, 'register');
                          }
                      )
                  )
                ]
            )
          )
    );
  }
}