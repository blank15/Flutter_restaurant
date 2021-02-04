import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalPreferences{
  static const _isAlarmActive = 'isAlarmActive';
  final SharedPreferences preferences;

  LocalPreferences({@required this.preferences});

  Future<bool> getAlarmSetting() async {
    return  preferences.getBool(_isAlarmActive)  ?? false;
  }
  
  Future saveAlarmSetting(bool isActive) async{
    await preferences.setBool(_isAlarmActive, isActive);
  }
}
