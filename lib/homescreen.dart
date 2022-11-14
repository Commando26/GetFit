import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_database/firebase_database.dart';
/*
  homescreen.dart will act as a home page with all of a users info as well as
  buttons for other sections of the app
 */

late User loggedinUser;

class homeScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final _fbApp = FirebaseAuth.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;
  int _selectedIndex = 0;


  void initState() {
    super.initState();
    getCurrentUser();
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



  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: Colors.black12, //                   <--- border color
        width: 3.0,
      ),
    );
  }

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    Icon(
      Icons.whatshot,
      size: 150,
    ),
    Icon(
      Icons.emoji_events,
      size: 150,
    ),
    DataPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
        body: IndexedStack (
          index: _selectedIndex,
            children: _pages,
        ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black12,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
            label: 'Workouts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.poll),
            label: 'Data',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class HomePage extends StatelessWidget {
  const HomePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              child: const Text(
                'Welcome!',
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 20
                )
              )
            )
          ]
        )
      )
    );
  }
}

class DataPage extends StatefulWidget {
  const DataPage();
  @override
  DatePickerState createState() => DatePickerState();
}

class DatePickerState extends State<DataPage> {
  DateTime selectedDate = DateTime.now();
  bool _decideWhichDayToEnable(DateTime day) {
    if (day.isBefore(DateTime.now().add(Duration(days: 0)))) {
      return true;
    }
    return false;
  }

  _selectDate(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildMaterialDatePicker(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                  "${selectedDate.toLocal()}".split(' ')[0],
                  style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20
                  )
              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(
                  'Select date',
                  style:
                  TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black12,
                ),

              ),
              new TextField(
                style: TextStyle(color: Colors.yellow),
                decoration: new InputDecoration(
                  filled: true,
                  fillColor: Colors.black12,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow)
                  ),
                  hintText: "Enter your step count",
                  hintStyle: TextStyle(color: Colors.yellow),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onSubmitted: (value) { print('test: ${[value, selectedDate]}'); },
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.day,
      selectableDayPredicate: _decideWhichDayToEnable,
      helpText: 'Select date',
      cancelText: 'Not now',
      confirmText: 'Enter',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      fieldLabelText: 'Date',
      fieldHintText: 'MM/DD/YYYY',
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}