import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';
import '../other/config.dart';
import 'homescreen.dart';

class settingsPage extends State<SettingsPage> {
  // This isSwitched value should come from the user's preference in the database
  // Right now it just comes from the theme.dart because it was easy
  //bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(children: [
              Container(
                  child: ElevatedButton(
                      child: Text('Local App Settings',
                          style: TextStyle(
                              fontSize: 20
                          )
                      ),
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.black,
                        primary: currentTheme.textColor,
                      ),
                      onPressed: () {
                        AppSettings.openAppSettings();
                      })
              ),
              Row(
                children: [
                  const Text('Toggle Light Mode:',
                      style: TextStyle(
                          fontSize: 20
                      )
                  ),
                  Switch(
                    value: currentTheme.isSwitched,
                    onChanged: (value) {
                      setState(() {
                        currentTheme.isSwitched = value;
                        print(currentTheme.isSwitched);
                        currentTheme.switchTheme();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => homeScreen()),
                              (Route<dynamic> route) => false,
                        );
                      });
                    },
                      activeTrackColor: currentTheme.textColor,
                      activeColor: Colors.grey,
                      inactiveTrackColor: currentTheme.textColor,
                      inactiveThumbColor: Colors.grey,
                  ),
                ],
              ),
            ])
        )
    );
  }
}