import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safearea/models/user_model.dart';
import 'package:safearea/pages/home/clean_page.dart';
import 'package:safearea/pages/home/employee_page.dart';

directHome(BuildContext context){
  //Navigator.pushNamed(context, "home");
  Navigator.pushReplacementNamed(context, "home");
}

directPreview(BuildContext context){
  //Navigator.pushNamed(context, "home");
  Navigator.pushReplacementNamed(context, "preview");
}

directLogin(BuildContext context){
  //Navigator.pushNamed(context, "home");
  Navigator.pushReplacementNamed(context, "login");
}
/*
directHomeClean(BuildContext context){
  //Navigator.pushNamed(context, "home");
  Navigator.pushReplacementNamed(context, "clean");
}

directHomeEmployee(BuildContext context){
  //Navigator.pushNamed(context, "home");
  Navigator.pushReplacementNamed(context, "employee");
}*/

directHomeClean(BuildContext context, UserModel user) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => CleanPage(user: user)));
}

directHomeEmployee(BuildContext context, UserModel user) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => EmployeePage(user: user)));
}

directNotificactionsPage(BuildContext context){
  Navigator.pushNamed(context, "notifications");
}