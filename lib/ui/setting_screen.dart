import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/local/local_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  static final routeName = '/setting';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _settingAlarm = false;

  LocalPreferences _preferences;

  @override
  void initState() {
    super.initState();
    SharedPreferences sharedPreferences;
    _preferences = LocalPreferences(preferences: sharedPreferences);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        title: new Text(
          'Setting',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
          child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 8.0),
                child: Text(
                  'Scheduling Alarm',
                  style: TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ),
              Switch.adaptive(
                  value: _settingAlarm,
                  onChanged: (value) {
                    _settingAlarm = value;
                    _preferences.saveAlarmSetting(_settingAlarm);
                  }),
            ],
          )
        ],
      )),
    );
  }
}
