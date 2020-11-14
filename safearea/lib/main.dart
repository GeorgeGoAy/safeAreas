import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safearea/pages/home/clean_page.dart';
import 'package:safearea/pages/home/employee_page.dart';
import 'package:safearea/pages/home/notification/notification_page.dart';
import 'package:safearea/pages/login_page.dart';
import 'package:safearea/pages/preview_page.dart';
import 'package:safearea/pages/splash_page.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light
  ));
  SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safe Areas',
      initialRoute: 'splash',
      routes: {
        'splash': (BuildContext context) => SplashScreen(),
        'preview': (BuildContext context) => PreviewPage(),
        'login': (BuildContext context) => LoginPage(),
        'clean': (BuildContext context) => CleanPage(),
        'employee': (BuildContext context) => EmployeePage(),
        'notifications': (BuildContext context) => NotificationsPage()
      },
      theme: ThemeData(
        //primaryColor: Color.fromRGBO(0, 20, 99, 1),
        primaryColor:Color.fromRGBO(0, 0, 0, 1)
      ),
    );
  }
}