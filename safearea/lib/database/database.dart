import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:safearea/models/notificaction_model.dart';
import 'package:safearea/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:safearea/utils/navigator.dart' as navigator;

class DBProvider{
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if( _database != null)
        return _database;

     _database = await initDB();
    return _database;   
  }

  initDB() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

   final path = join( documentsDirectory.path,'activosDB.db' );

      return await openDatabase(
        path,
        version: 1,
        onOpen: (db){},
        onCreate: (Database db, int version) async{
          await db.execute(
            'CREATE TABLE user('
              'id INTEGER PRIMARY KEY,'
              'record INTEGER,'
              'firstName TEXT,'
              'lastName TEXT,'
              'type TEXT,'
              'userToken TEXT,'
              'setClistBitacora TEXT,'
              'setBitacoraDb TEXT,'
              'getClistCleaning TEXT,'
              'getSlistCleaning TEXT'
            ')'  
          );

          await db.execute(
            'CREATE TABLE areas('
              'id INTEGER PRIMARY KEY,'
              'record INTEGER,'
              'description TEXT,'
              'idArea TEXT,'
              'status TEXT,'
              'comments TEXT'
            ')'  
          );

          await db.execute(
            'CREATE TABLE object('
              'id INTEGER PRIMARY KEY,'
              'name TEXT,'
              'description TEXT,'
              'qrId TEXT'
            ')'  
          );

          await db.execute(
            'CREATE TABLE notifications('
              'id INTEGER PRIMARY KEY,'
              'title TEXT,'
              'body TEXT,'
              'status INTEGER'
            ')'  
          );

        }
      );
  }
   Future<UserModel> getUser() async {
    final db = await database;
    final res = await db.query('user');
    final login = res.isNotEmpty ? UserModel.fromJson(res.first) : null;
    return login;
  }

  addUser( UserModel user) async{
    final db  = await database;
    final res = await db.insert("user", user.toJson());
    return res;
  }

  signOut(BuildContext context) async{
    final db  = await database;
    final login = await db.delete("user");
    await db.delete("notifications");
    navigator.directLogin(context);
    return login;
  }

  addNotifications(NotificationModel notification)async {
    final db  = await database;
    final notify = await db.insert("notifications", notification.toJson());
   
    return notify;
  }

  Future<List<NotificationModel>> getAllNotifications()async{
    final db  = await database;
    final res = await db.query( 'notifications' );
   
    List<NotificationModel> lista = res.isNotEmpty ? ListNotificationModel.fromJsonListData(res).listNotificactions: [];
    return lista;
  }

  Future<int> getCountNotificationsNotView()async{
    final db  = await database;
    final res = await db.rawQuery("SELECT * FROM notifications WHERE status=0");
    List<NotificationModel> lista = res.isNotEmpty ? ListNotificationModel.fromJsonListData(res).listNotificactions : [];
    return lista.length;
  }

  updateViewNotifications()async {
    final db  = await database;
    final res = await db.rawUpdate('UPDATE notifications SET status = ? WHERE status = ?', [1, 0]);
    return res;
  }


}