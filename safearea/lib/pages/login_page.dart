
import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:safearea/database/database.dart';
import 'package:safearea/models/user_model.dart';
import 'package:safearea/services/auth_service.dart';
import 'package:safearea/services/notification_service.dart';
import 'package:safearea/utils/global_user.dart';
import 'package:safearea/utils/navigator.dart' as navigator;
import 'package:safearea/widget/alert_widget.dart' as alert;
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final focus = FocusNode();

  TextEditingController  ctrlUser = new TextEditingController();
  TextEditingController  ctrlPassword = new TextEditingController();

  bool passwordVisible = true;
  bool onSubmitedAuth = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
          onWillPop: () async =>alert.backPressed(context),
          child: FlipInX(
            child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/wallpaper.jpg'),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter
                )
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .27),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child:  Padding(
              padding: EdgeInsets.all(23),
              child: Material(
                color: Colors.white,
                    child: ListView(
                  children: <Widget>[
                    Center(
                        child: Text('Safe Areas',
                        style: TextStyle(
                          fontFamily: 'SFUIDisplay',
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Container(
                        color: Color(0xfff5f5f5),
                        child: TextFormField(
                          cursorColor: Colors.black,
                          controller: ctrlUser,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SFUIDisplay'
                          ),
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username',
                            prefixIcon: Icon(Icons.person_outline),
                            labelStyle: TextStyle(
                              fontSize: 15
                            )
                          ),
                          onFieldSubmitted: (v){
                                FocusScope.of(context).requestFocus(focus);
                            },
                        ),
                      ),
                    ),
                    Container(
                      color: Color(0xfff5f5f5),
                      child: TextFormField(
                        obscureText: passwordVisible,
                        cursorColor: Colors.black,
                        controller: ctrlPassword,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'SFUIDisplay'
                        ),
                        focusNode: focus,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon:  IconButton(onPressed: _toggle, icon:Icon(passwordVisible ? Icons.visibility : Icons.visibility_off, color: passwordVisible ? Colors.black12 : Colors.black)),
                          labelStyle: TextStyle(
                              fontSize: 15
                            )
                        ),
                        onFieldSubmitted: (v){
                          _submitAuth();
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: onSubmited(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Forgot your password?",
                                style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              ),
                              TextSpan(
                                text: " Click Here",
                                style: TextStyle(
                                  fontFamily: 'SFUIDisplay',
                                  color: Color(0xffff2d55),
                                  fontSize: 15,
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () => print('Tap Here onTap')
                              )
                            ]
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
                ),
            )
          ],
        ),
      ),
    );
  }

  Widget onSubmited(){
    return onSubmitedAuth ? Container(
        color: Colors.transparent,
        child: Center(
          child: Loading(indicator: BallPulseIndicator(), size: 100.0,color: Color(0xFFA64884)),
        ),
      ):MaterialButton(
        onPressed: _submitAuth,//since this is only a UI app
        child: Text('SIGN IN',
        style: TextStyle(
          fontSize: 15,
          fontFamily: 'SFUIDisplay',
          fontWeight: FontWeight.bold,
        ),
        ),
        color:Color(0xFFA64884),
        elevation: 0,
        minWidth: 400,
        height: 50,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
      );
  }

  _submitAuth(){
    if( ctrlUser.text != "" && ctrlPassword.text != ""){
      setState(() {onSubmitedAuth = true;});
      AuthService.authService.auth(ctrlUser.text, ctrlPassword.text).then( (auth)async  {
        if(auth != null){
          UserGlobal.user = auth;
          subscribeNotification(auth);
          if(auth.type == "Cleanning"){
            await DBProvider.db.addUser(auth);
            navigator.directHomeClean(context,auth);
          }else if(auth.type == "Employee"){
            await DBProvider.db.addUser(auth);
            navigator.directHomeEmployee(context,auth);
          }
        }else{
          alert.openAlertBox(context, "Unauthorized", "Please verify your credentials and try again");
        }
        setState(() {onSubmitedAuth = false;});
      });
    }else{
      alert.information(context, "Catch Error", "¡Missing required fields!");
    }
  }

  _toggle(){
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }


  subscribeNotification(UserModel user){
    final notificactionService = new NotificationService();
    notificactionService.initNotifications(user);
  }

  //eOBm93E-TXSv_GM2HU9h6f:APA91bGzakghTjEkJHgxOldTHySfa6qM-toAzATD9KpdZvh8UUsxaW5-TCf9eN7I18bB1U8Niqzwz2GDPVSBAzZfnCoaTBHCy0bjwAhj-Hlof8QeiMknLWPuwIWwNWTd20W4Zald-7KG


}