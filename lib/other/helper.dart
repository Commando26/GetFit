import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'dart:convert';

late User loggedinUser;
//   https://groupone-getfit-default-rtdb.firebaseio.com/        this is the url for the database


class helper{
  FirebaseDatabase database = FirebaseDatabase.instance;
  final _fbApp = FirebaseAuth.instance;


//use the commented code below to get data from the data base
  //this will update the data when it is changed

    //replace path with the path to the database entry you want      ex) let path = 'steps/date'
  /*
  database.reference().child('users/' + loggedinUser.uid + '/' + path).onValue.listen((event) {
      final data = event.snapshot.value;
      //put code here that does: variable = data
      // ex) steps_date = data
    });
    */

  //this function returns the data at the indicated path
dynamic readUserData(final path) async{
  final snapshot = await database.reference().child('users/' + loggedinUser.uid + path).get();
if (snapshot.exists){return snapshot;}
else return "";
}

  void WriteUserData_OnCreateNewAccount(String userEmail){
    getCurrentUser();
    //database.reference().child('users/' + loggedinUser.uid + '/email').set(userEmail);
    //database.reference().child('users/' + loggedinUser.uid + '/steps').set(0);
    //database.reference().child('users/' + loggedinUser.uid + '/weight').set(0);
    database.reference().child('users/' + loggedinUser.uid).set({
      "email": userEmail,
      "steps":
            {"steps": 0, "date": "not set"},
      "weight":
            {"weight": 0, "date" : "not set"},
      "workoutPlan":
          { "Monday": "not set",
          "Tuesday": "not set",
          "Wednesday": "not set",
          "Thursday": "not set",
          "Friday": "not set",
          "Saturday": "not set",
          "Sunday": "not set"}
    });

  }




  void writeUserData_steps(final value, String date) {
    getCurrentUser();
    database.reference().child('users/' + loggedinUser.uid + '/steps/steps' ).set( {date : value});
  }

  /* void writeUserData_steps_date(final value) {
    getCurrentUser();
    database.reference().child('users/' + loggedinUser.uid + '/steps/date' ).set(value);
  }

  void writeUserData_weight(int value) {
    getCurrentUser();
    database.reference().child('users/' + loggedinUser.uid + 'weight/weight').set(value);
  }*/

  void writeUserData_weight(final value, String date) {
    getCurrentUser();
    database.reference().child('users/' + loggedinUser.uid + '/weight/date').set({String : date});
  }


  //path can be anything, if the path does not yet exist a new entry will be made in the database

  void writeUserData(String path, String value) {
    getCurrentUser();
    database.reference().child('users/' + loggedinUser.uid + path).set(value);
  }



  void writeUserData_workoutPlanMonday(String value) {
    getCurrentUser();
    database.reference().child('users/' + loggedinUser.uid + '/workoutPlan/Monday').set(value);
  }

  void writeUserData_workoutPlanTuesday(String value) {
    getCurrentUser();
    database.reference().child('users/' + loggedinUser.uid + '/workoutPlan/Tuesday').set(value);
  }

  void writeUserData_workoutPlanWednesday(String value) {
    getCurrentUser();
    database.reference().child('users/' + loggedinUser.uid + '/workoutPlan/Wednesday').set(value);
  }
  void writeUserData_workoutPlanThursday(String value) {
    getCurrentUser();
    database.reference().child('users/' + loggedinUser.uid + '/workoutPlan/Thursday').set(value);
  }
  void writeUserData_workoutPlanFriday(String value) {
    getCurrentUser();
    database.reference().child('users/' + loggedinUser.uid + '/workoutPlan/Friday').set(value);
  }
  void writeUserData_workoutPlanSaturday(String value) {
    getCurrentUser();
    database.reference().child('users/' + loggedinUser.uid + '/workoutPlan/Saturday').set(value);
  }
  void writeUserData_workoutPlanSunday(String value) {
    getCurrentUser();
    database.reference().child('users/' + loggedinUser.uid + '/workoutPlan/Sunday').set(value);
  }




  void getCurrentUser() async {
    try {
      final user = await _fbApp.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
    } catch (e) {
      print(e);
    }
  }
}