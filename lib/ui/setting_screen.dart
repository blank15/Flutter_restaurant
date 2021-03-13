import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_restaurant/bloc/notification/notification_bloc.dart';
import 'package:flutter_restaurant/bloc/notification/notification_event.dart';
import 'package:flutter_restaurant/bloc/notification/notification_state.dart';
import 'package:flutter_restaurant/data/local/local_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  static final routeName = '/setting';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _settingAlarm = false;

  final _scaffoldGlobalKey = GlobalKey<ScaffoldState>();
  LocalPreferences _preferences;

  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    asyncTask();


  }

  void asyncTask() async{
    sharedPreferences =  await SharedPreferences.getInstance();
    _preferences = LocalPreferences(preferences:sharedPreferences);
    _preferences.getAlarmSetting().then((value) {
      setState(() {
        _settingAlarm = value;
      });
    } );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc,NotificationState>(
        listener: (context,state){
          if(state is SuccessSetNotification){
            _scaffoldGlobalKey.currentState.showSnackBar(SnackBar(
              duration: Duration(seconds: 2),
              content: Text("alarm berhasil diset"),
              backgroundColor: Colors.green,
            ));
          }
        },
    child: Scaffold(
      key: _scaffoldGlobalKey,
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
                        onChanged: (value) async {
                          await _preferences.saveAlarmSetting(value);
                          setState(() {
                            _settingAlarm = value; context.read<NotificationBloc>()
                              ..add(SetNotificationEvent());
                          });

                        }),
                  ],
                )
              ],
            )))
    );
  }
}
