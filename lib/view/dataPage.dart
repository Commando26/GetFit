import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:firstapp/other/config.dart';
import 'package:firstapp/view/homescreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:firstapp/other/helper.dart';
import 'package:intl/intl.dart';
import 'package:firstapp/view/homescreen.dart';

//late User loggedinUser;
double stepValue = 0;

class DatePickerState extends State<DataPage> {

  FirebaseDatabase database = FirebaseDatabase.instance;
  final _fbApp = FirebaseAuth.instance;
  final  help = helper();


  DateTime selectedDate = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
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
    final DateFormat graphFormat = DateFormat('MMMd');
    return Scaffold(
        appBar: AppBar(
          title: const Text('Data'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 5),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () => _selectDate(context),
                                child: Icon(
                                  Icons.date_range, size: 30, color: currentTheme.textColor,
                                  //style:
                                  // TextStyle(color: currentTheme.textColor, fontWeight: FontWeight.bold),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black12,
                                ),
                              ),
                              SizedBox(
                                width: 30.0,
                              ),
                              Text(
                                  "${selectedDate.toLocal()}".split(' ')[0],
                                  style: TextStyle(
                                      color: currentTheme.textColor,
                                      fontSize: 30
                                  )
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            style: TextStyle(color: currentTheme.textColor),
                            decoration: new InputDecoration(
                              filled: true,
                              fillColor: Colors.black12,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: currentTheme.textColor)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: currentTheme.textColor)
                              ),
                              hintText: "Enter your step count",
                              hintStyle: TextStyle(color: currentTheme.textColor),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onSubmitted: (value) {
                              String inputDate = formatter.format(selectedDate);
                              String path = '/$inputDate/steps';
                              help.writeUserData(path, value);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => homeScreen()),
                                    (Route<dynamic> route) => false,
                              );

                              //help.writeUserData_steps(value, inputDate);
                              stepValue = double.parse(value);
                              },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            style: TextStyle(color: currentTheme.textColor),
                            decoration: new InputDecoration(
                              filled: true,
                              fillColor: Colors.black12,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: currentTheme.textColor)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: currentTheme.textColor)
                              ),
                              hintText: "Enter your weight",
                              hintStyle: TextStyle(color: currentTheme.textColor),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onSubmitted: (value) {
                              String inputDate = formatter.format(selectedDate);
                              String path = '/$inputDate/weight';
                              help.writeUserData(path, value);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => homeScreen()),
                                    (Route<dynamic> route) => false,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 5),
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            palette: <Color>[
                              currentTheme.textColor
                            ],
                            title: ChartTitle(text: 'Steps history'),
                            series: <LineSeries<StepData, String>>[
                              LineSeries<StepData, String>(
                                // Bind data source
                                  dataSource:  <StepData>[ //Here should just be a list generated from the database
                                    // This needs to come from the database values
                                    // StepData(<Date from database>, <Step count for that day>), Loop for all values
                                    StepData(graphFormat.format(DateTime(2022, 4, 8)), 8477),
                                    StepData(graphFormat.format(DateTime(2022, 4, 9)), 11348),
                                    StepData(graphFormat.format(DateTime(2022, 4, 10)), 9283),
                                    StepData(graphFormat.format(DateTime(2022, 4, 11)), 14274),
                                    StepData(graphFormat.format(DateTime(2022, 4, 12)), 5034),
                                    StepData(graphFormat.format(DateTime(2022, 4, 13)), 7794)
                                  ],
                                  xValueMapper: (StepData steps, _) => steps.time,
                                  yValueMapper: (StepData steps, _) => steps.steps,
                                  dataLabelSettings: DataLabelSettings(isVisible: true)
                              )
                            ]
                        )
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 5),
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            palette: <Color>[
                              currentTheme.textColor
                            ],
                            title: ChartTitle(text: 'Weight history (in pounds)'),
                            series: <LineSeries<WeightData, String>>[
                              LineSeries<WeightData, String>(
                                // Bind data source
                                dataSource:  <WeightData>[ // Look at previous example to change to database
                                  WeightData(graphFormat.format(DateTime(2022, 4, 8)), 156),
                                  WeightData(graphFormat.format(DateTime(2022, 4, 9)), 156),
                                  WeightData(graphFormat.format(DateTime(2022, 4, 10)), 155),
                                  WeightData(graphFormat.format(DateTime(2022, 4, 11)), 156),
                                  WeightData(graphFormat.format(DateTime(2022, 4, 12)), 155),
                                  WeightData(graphFormat.format(DateTime(2022, 4, 13)), 154)
                                ],
                                xValueMapper: (WeightData weight, _) => weight.time,
                                yValueMapper: (WeightData weight, _) => weight.weight,
                                dataLabelSettings: DataLabelSettings(isVisible: true),
                              )
                            ]
                        )
                    ),
                  ),
                ]
            )
        )
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

class StepData {
  StepData(this.time, this.steps);
  final String time;
  final double steps;
}

class WeightData {
  WeightData(this.time, this.weight);
  final String time;
  final double weight;
}
