 import 'package:firebase_messaging/firebase_messaging.dart';

deleteCache()async{
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  await _firebaseMessaging.deleteInstanceID();
}