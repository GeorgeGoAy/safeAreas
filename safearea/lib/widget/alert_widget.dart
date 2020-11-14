 import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

 information(BuildContext context,String title, String description){
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ZoomIn(
                 duration: Duration(milliseconds: 150),
                      child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              title: tittleDialog(context, title),
              content: Container(
                width: 300.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 30.0, right: 30.0),
                      child: TextField(
                        enabled: false,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: description,
                          border: InputBorder.none,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    InkWell(
                      onTap:() => Navigator.pop(context,false),
                      child: Container(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFA64884),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: Text(
                          "Aceptar",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  loading(BuildContext context){
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ZoomIn(
                 duration: Duration(milliseconds: 150),
                      child: AlertDialog(
              backgroundColor: Colors.transparent,
              content: Loading(indicator: BallPulseIndicator(), size: 30.0,color: Color(0xFFA64884))
            ),
          );
        });
  }

  openAlertBox(BuildContext context,String title,String descripcion) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ZoomIn(
                 duration: Duration(milliseconds: 150),
                      child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              title: tittleDialog(context, title),
              content: Container(
                width: 300.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 30.0, right: 30.0),
                      child: TextField(
                        enabled: false,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: descripcion,
                          border: InputBorder.none,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0,bottom: 10.0),
                      child: Icon(Icons.do_not_disturb_alt,color:Colors.black26, size: 70)
                    ),
                    InkWell(
                      onTap:() => Navigator.pop(context,false),
                      child: Container(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFA64884),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: Text(
                          "Aceptar",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget tittleDialog(BuildContext context,String titulo){
    return Column(
        children: <Widget>[
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[ 
          Expanded(child: Text(
            titulo,
            style: TextStyle(fontSize: 24.0),textAlign: TextAlign.center,
          )),
          IconButton(icon: Icon(Icons.cancel, size: 30,), onPressed: () => Navigator.pop(context,false)),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Divider(
            color: Colors.grey,
            height: 4.0,
          ),
        ],
      );
  }

  Future<bool> backPressed(BuildContext context){
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Safe Areas",textAlign: TextAlign.center,),
            elevation: 24.0,
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("¿Estas seguro de salir de la aplicación?")
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context,false), 
                child: Text("No",style: TextStyle(fontSize: 17))
              ),
              FlatButton(
                onPressed: () => exit(0), 
                child: Text("Si",style: TextStyle(fontSize: 17))
              )
            ],
          );
        }
      );
  }