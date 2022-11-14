import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firstapp/other/helper.dart';
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
  String newAccValidate = '';
  bool showSpinner = false;
  final _fbApp = FirebaseAuth.instance;
  final  help =helper();
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
                        'Create Account',
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
                          //border: OutlineInputBorder(),
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
                          hintText: "Create a Password",
                          hintStyle: TextStyle(color: Colors.yellow),
                          //border: OutlineInputBorder(),
                        ),
                      )
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Text(
                        newAccValidate,
                        style: GoogleFonts.fredokaOne(color: Colors.red, fontSize: 12),
                      )),
                  Container(
                    height: 90,
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                        child: Text("Start your journey!", style: GoogleFonts.bowlbyOneSc(fontSize: 20)),
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(emailString))
                            newAccValidate = 'Email not valid, please enter a valid email';
                          else
                          if (passwordString.length < 6)
                            newAccValidate = 'Password not valid, make sure your password is 6 characters or longer';
                          else
                            try {
                              final user = await _fbApp.createUserWithEmailAndPassword(
                                  email: emailString, password: passwordString);
                              if (user != null) {
                                //write user data here *call helper function once it is completed*
                                help.WriteUserData_OnCreateNewAccount(emailString);
                                Navigator.pushNamed(context, 'login');
                              }
                            } catch (e) {
                              newAccValidate = 'The email is already in use, please sign in instead';
                            }
                          setState(() {
                            showSpinner = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            primary: Colors.yellow,
                            onPrimary: Colors.black)
                    ),
                  ),
                ]
            )
        )
    );
  }
}
