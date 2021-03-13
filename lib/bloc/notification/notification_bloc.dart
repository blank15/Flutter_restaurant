import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/bloc/notification/notification_event.dart';
import 'package:flutter_restaurant/data/local/local_preference.dart';
import 'package:flutter_restaurant/helper/background_service.dart';
import 'package:flutter_restaurant/helper/date_time_helper.dart';
import '../../data/repository/restaurant_repository.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final RestaurantRepository repository;
  final LocalPreferences preferences;

  NotificationBloc({@required this.repository,@required this.preferences}) : super(NotificationInit());

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is SetNotificationEvent) {
      try {
        bool _isScheduled = await preferences.getAlarmSetting();
        debugPrint('isScheduled $_isScheduled');
        if(_isScheduled){
          await AndroidAlarmManager.periodic(
            Duration(hours: 24),
            1,
            BackgroundService.callback,
            startAt: DateTimeHelper.format(),
            exact: true,
            wakeup: true,
          );
          yield SuccessSetNotification();
        }else{
          await AndroidAlarmManager.cancel(1);
          yield SuccessSetNotification();
        }
      }  catch (e) {
        yield FailedSetNotification(error: e.toString());
      }
    }
  }
}
