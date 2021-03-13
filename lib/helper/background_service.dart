import 'dart:isolate';
import 'dart:math';import 'dart:ui';


import 'package:flutter/cupertino.dart';

import '../data/remote/api/api_service.dart';
import '../data/remote/api/dio_client.dart';
import 'notification_helper.dart';
import 'package:flutter_restaurant/main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService _service;
  static String _isolateName = 'isolate';
  static SendPort _uiSendPort;

  BackgroundService._createObject();
  
  
  
  factory BackgroundService() {
    if (_service == null) {
      _service = BackgroundService._createObject();
    }
    return _service;
  }

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final NotificationHelper _notificationHelper = NotificationHelper();
    var apiService = ApiServiceImpl(
        dio: DioClient(apiBaseUrl: "https://restaurant-api.dicoding.dev/").dio);
    var result = await apiService.fetchRestaurans();

    debugPrint('run alarm in background');
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result.restaurants[Random().nextInt(result.restaurants.length)]);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    print('Execute some process');
  }
}