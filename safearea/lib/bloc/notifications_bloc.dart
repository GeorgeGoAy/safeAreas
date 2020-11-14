import 'dart:async';

import 'package:safearea/database/database.dart';
import 'package:safearea/models/notificaction_model.dart';


class NotiticationBloc{
  static final NotiticationBloc _blocAreas = new NotiticationBloc._internal();

  factory NotiticationBloc(){
    return _blocAreas;
  }

  NotiticationBloc._internal(){
     getAllNotifications();
  }

  final _notifyController = StreamController<List<NotificationModel>>.broadcast();
  final _notificationsCount  = StreamController<int>.broadcast();


  Stream<List<NotificationModel>> get notifyStream => _notifyController.stream;
  Stream<int> get notifyCountStream => _notificationsCount.stream;

  dispose(){
    _notifyController?.close();
  }

  disposeCount(){
    _notificationsCount?.close();
  }

  getAllNotifications() async{
    List<NotificationModel> lista = await DBProvider.db.getAllNotifications();
    _notifyController.sink.add(lista);
  }

  addNotifications(NotificationModel notify) async{
    await DBProvider.db.addNotifications(notify);
    getAllNotifications();
    getCountNotifications();
  }

  getCountNotifications() async{
    int count = await DBProvider.db.getCountNotificationsNotView();
    _notificationsCount.sink.add(count);
  }

  updateViewNotifications() async{
    await DBProvider.db.updateViewNotifications();
    getCountNotifications();
  }



}