import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:safearea/database/database.dart';
import 'package:safearea/services/notification_service.dart';
import 'package:safearea/utils/global_user.dart';
import 'package:safearea/utils/navigator.dart' as navigator;
class SplashScreen extends StatefulWidget {

  @override State<StatefulWidget> createState() => FadeIn();
  
}
  class FadeIn extends State<SplashScreen> {

  FadeIn() {
    deelay(); 
  }
 
  
  Widget image(){
    return ZoomIn(
      duration: Duration(seconds: 2),
          child: Roulette(
        child: Container(
          decoration: BoxDecoration(
                      color: Colors.white
          ),
          child:Image.asset("assets/logo.png", height: 200,)
        )
      ),
    );
  }
 
  initPage()async {
    final login = await DBProvider.db.getUser();
    if(login != null){
      
      setState(() { UserGlobal.user = login; });
      subscribeNotification();
       if(login.type == "Cleanning"){
          navigator.directHomeClean(context,login);
      }else if(login.type == "Employee"){
          navigator.directHomeEmployee(context,login);
      }
    }
    else
      navigator.directPreview(context); 
  }

  deelay() async{
    Timer(const Duration(milliseconds: 4300), (){
        initPage();
    }); 
  }

  @override Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark
     ));
     SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
     ]);
  return Scaffold(
    backgroundColor: Colors.white,
        body: Center(
          child: image()
        ),
      );
   }

    subscribeNotification(){
    final notificactionService = new NotificationService();
    notificactionService.initNotifications();
  }
}
