import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}


class NotificationInit extends NotificationState {}

class  SuccessSetNotificationInit extends NotificationState {}



class SuccessSetNotification extends NotificationState {
}

class FailedSetNotification<String> extends NotificationState {
  final String error;

  FailedSetNotification({@required this.error});

  @override
  List<Object> get props => super.props;
}