import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  String loginValidate = '';
  bool showSpinner = false;
  final _fbApp = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white10,
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'GetFit',
                        style: GoogleFonts.bowlbyOneSc(fontSize: 70, color: Colors.yellow),
                      )),
                  Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
                      child: Text(
                        'Sign in',
                        style: GoogleFonts.fredokaOne(fontSize: 26, color: Colors.yellow),
                      )),
                  Container(
                      padding: const EdgeInsets.fromLTRB(20, 2, 20, 0),
                      child: TextField(
                        style: TextStyle(color: Colors.yellow),
                        onChanged: (value) {
                          emailString = value;
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.black12,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow)
                          ),
                          hintText: "Enter your Email",
                          hintStyle: TextStyle(color: Colors.yellow),
                          // border: OutlineInputBorder(),
                        ),
                      )
                  ),
                  Container(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        style: TextStyle(color: Colors.yellow),
                        obscureText: true,
                        onChanged: (value) {
                          passwordString = value;
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.black12,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow)
                          ),
                          hintText: "Enter your Password",
                          hintStyle: TextStyle(color: Colors.yellow),
                          //border: OutlineInputBorder(),
                        ),
                      )
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Text(
                        loginValidate,
                        style: GoogleFonts.fredokaOne(color: Colors.red, fontSize: 12),
                      )),
                  Container(
                      height: 90,
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        child: Text("Login!", style: GoogleFonts.bowlbyOneSc(fontSize: 20)),
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            loginValidate = '';
                            final user = await _fbApp.signInWithEmailAndPassword(
                                email: emailString, password: passwordString);
                            if (user != null) {
                              Navigator.pushNamed(context, 'homescreen');
                            }
                          } catch (e) {
                            loginValidate = 'Login invalid, try your password again or create an account';
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            primary: Colors.yellow,
                            onPrimary: Colors.black
                        ),
                      )
                  ),
                  Container(
                      height: 90,
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                          child: Text("No Account?", style: GoogleFonts.bowlbyOneSc(fontSize: 20)),
                          onPressed: () {
                            Navigator.pushNamed(context, 'register');
                          },
                          style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              primary: Colors.yellow,
                              onPrimary: Colors.black
                          )
                      )
                  )]
            )
        )
    );
  }
}
