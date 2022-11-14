import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/helper.dart';
import 'package:flutter/material.dart';
import 'register.dart';
/*
  register.dart allows new users to create an account, accessed from login page
 */

class registerPage extends StatefulWidget {
  const registerPage({Key? key}) : super(key: key);

  @override
  State<registerPage> createState() => Home();

}

class Home extends State<registerPage> {
  late String emailString;
  late String passwordString;
  bool showSpinner = false;
  final _fbApp = FirebaseAuth.instance;
  final  help =helper();
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
                        'Create Account',
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
                        child: const Text("Create"),
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final user = await _fbApp.createUserWithEmailAndPassword(
                                email: emailString, password: passwordString);
                            if (user != null) {
                              //write user data here *call helper function once it is completed*
                              help.WriteUserData_OnCreateNewAccount(emailString);
                              Navigator.pushNamed(context, 'login');
                            }
                          } catch (e) {
                            print(e);
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        }),
                  ),
                ]
            )
        )
    );
  }
}