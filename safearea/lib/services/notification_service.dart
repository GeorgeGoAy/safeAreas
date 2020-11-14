import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:safearea/bloc/notifications_bloc.dart';
import 'package:safearea/models/notificaction_model.dart';
import 'package:safearea/models/user_model.dart';
import 'package:safearea/services/auth_service.dart';

class NotificationService {

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
final notificationBloc = NotiticationBloc();

 static Future<dynamic> onBackgroundMessage(Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      final dynamic notification = message['notification'];
    }
  }

  initNotifications([UserModel model]) async{

    await _firebaseMessaging.requestNotificationPermissions();
    final token = await _firebaseMessaging.getToken();
    if(model != null)
      updateToken(model, token);

    print("===== TOKEN =====");
    print(token);

    _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage: onBackgroundMessage,
      onLaunch: onLaunch,
      onResume: onResume
    );
  }

  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    print("onMessage: $message");
    addNotification(message);
  }
  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    print("onLaunch: $message");
    addNotification(message);
  }
  Future<dynamic> onResume(Map<String, dynamic> message) async {
    print("onResume: $message");
    addNotification(message);
  }

  updateToken(UserModel user, String token) async{
    AuthService.authService.postToken(user.record,token);
  }

 
  addNotification(Map<String, dynamic> message){
    notificationBloc.addNotifications(NotificationModel(
      status: 0,
      title: message['notification']['title'],
      body: message['notification']['body'],
      ));
  }
}