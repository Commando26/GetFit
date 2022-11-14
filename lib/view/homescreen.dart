import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/view/workoutsTab/selectedcategorypage.dart';
import 'package:firstapp/view/settingspage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:firstapp/other/config.dart';
import 'package:firstapp/view/dataPage.dart';
import 'package:firstapp/other/helper.dart';
import 'package:pedometer/pedometer.dart';

/*
  homescreen.dart will act as a home page with all of a users info as well as
  buttons for other sections of the app
 */

String formateDate(DateTime d) {
  return d.toString().substring(0,19);
}

late User loggedinUser;
FirebaseDatabase database = FirebaseDatabase.instance;


class homeScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  late Future<FirebaseApp> _initialization;
  final _fbApp = FirebaseAuth.instance;
  int _selectedIndex = 0;

  @override
  void initState() {
    _initialization = Firebase.initializeApp();
    getCurrentUser();
    super.initState();
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

  static  List<Widget> _pages = <Widget>[ //////////pages
    HomePage(),
    CategoryList(),
    DataPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Something went wrong in Firebase');
          }

          Widget child =
          Scaffold(
            backgroundColor: Colors.white10,
            body: IndexedStack (
              index: _selectedIndex,
              children: _pages,
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.black12,
              selectedItemColor: currentTheme.textColor,
              unselectedItemColor: Colors.grey,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.black12,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.whatshot),
                  label: 'Workouts',
                  backgroundColor: Colors.black12,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.emoji_events),
                  label: 'Data',
                  backgroundColor: Colors.black12,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.construction),
                  label: 'Settings',
                  backgroundColor: Colors.black12,
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          );

          if (snapshot.connectionState == ConnectionState.done) {
            return child;
          }

          return CircularProgressIndicator();}
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

// Builds the home page of our app
class MyHomePage extends State<HomePage> {
  double pecentageSteps = 0;
  String loggedWeight = '';
  double value = 0;
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String date = DateFormat('yyyy-MM-dd').format(now);
    readUserDataSteps('$date/steps', loggedinUser, this);
    readUserDataWeight('$date/weight', loggedinUser, this);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome!'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      children: [
                        Text(
                            'Daily Steps Progress',
                            style: TextStyle(fontSize: 18),
                        ),
                      SizedBox(
                        height: 40,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                        SizedBox(
                          width: 207,
                          height: 207,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.grey,
                            color: currentTheme.textColor,
                            strokeWidth: 5,
                            value: (double.parse(_steps)) / 10000,
                          ),
                        ),
                        Text(
                          'Steps Taken\n' + _steps + '/10,000',
                          ),
                        ], // Children
                      ),
                      ] // Children
                    )
                  ),
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: currentTheme.textColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          )
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      child: Text(
                          'Logged Weight: $loggedWeight',
                          style: TextStyle(
                              color: currentTheme.textColor,
                              fontSize: 15
                          )
                      )
                  ),
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: currentTheme.textColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          )
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      child: Text(
                          "Workout Progress: /path here/",
                          style: TextStyle(
                              color: currentTheme.textColor,
                              fontSize: 15
                          )
                      )
                  ),
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: currentTheme.textColor,
                            width: 3.0,
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          )
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(10),
                      child: Text(
                          "Reminders & Goals:",
                          style: TextStyle(
                              color: currentTheme.textColor,
                              fontSize: 15
                          )
                      )
                  ),
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: currentTheme.textColor,
                            width: 3.0,
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          )
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(10),
                      child: Text(
                          "Suggested Events:",
                          style: TextStyle(
                              color: currentTheme.textColor,
                              fontSize: 15
                          )
                      )
                  ),
                ],
    ),
    ),
    );
  }
}

// This section is for constructing the states for our bottom app navigation
class HomePage extends StatefulWidget {
  MyHomePage createState() => MyHomePage();
}

class SettingsPage extends StatefulWidget {
  const SettingsPage();
  @override
  settingsPage createState() => settingsPage();
}

class DataPage extends StatefulWidget {
  const DataPage();
  @override
  DatePickerState createState() => DatePickerState();
}

void readUserDataSteps(final path, User user, MyHomePage page) async {

  DatabaseReference ref =  database.reference();
  final test = await ref.child('users/' + user.uid + '/' + path).get();
  final temp = double.parse(test.value.toString()) / 10000;
  if (temp != page.pecentageSteps) {
    page.pecentageSteps = temp;
    page.setState(() {});
  }
}
//Write function to change weight as well.
void readUserDataWeight(final path, User user, MyHomePage page) async {

  DatabaseReference ref =  database.reference();
  final test = await ref.child('users/' + user.uid + '/' + path).get();
  if (test.value.toString() != page.loggedWeight) {
    page.loggedWeight = test.value.toString();
    page.setState(() {});
  }
}

// DatabaseReference starCountRef =
// FirebaseDatabase.instance.ref('posts/$postId/starCount');
// starCountRef.onValue.listen((DatabaseEvent event) {
// final data = event.snapshot.value;
// updateStarCount(data);
// });

// void readUserData2(final path, User user, MyHomePage page) {
//
//   DatabaseReference ref = FirebaseDatabase.instance.ref('users/' + user.uid + '/');
//   DatabaseReference child = ref.child(path);
//   child.onValue.listen((DatabaseEvent event) {
//     page.loggedWeight = event.snapshot.value.toString();
//   });
// }
