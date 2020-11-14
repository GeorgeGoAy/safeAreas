
import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:safearea/bloc/areas_bloc.dart';
import 'package:safearea/bloc/notifications_bloc.dart';
import 'package:safearea/database/database.dart';
import 'package:safearea/models/cleanLog_model.dart';
import 'package:safearea/models/user_model.dart';
import 'package:safearea/services/objects_service.dart';
import 'package:safearea/utils/global_user.dart';
import 'package:safearea/widget/card_widget.dart';
import 'package:safearea/utils/text_avatar.dart' as textAvatar;
import 'package:safearea/widget/popmenu_widget.dart';
import 'package:safearea/widget/skeleton_widget.dart' as skeleton;
import 'package:safearea/widget/alert_widget.dart' as alert;
import 'package:safearea/widget/toast_widget.dart' as toast;
import 'package:safearea/utils/navigator.dart' as navigator;
import 'package:safearea/utils/delete_cache.dart' as cache;

class CleanPage extends StatefulWidget {
  final UserModel user;
  CleanPage({Key key,this.user}) : super(key: key);

  @override
  _CleanPageState createState() => _CleanPageState();
}

class _CleanPageState extends State<CleanPage> {
  final  areasBloc = new AreasBloc();
  final notificationBloc = NotiticationBloc();
  var _controller = TextEditingController();
  UserModel user;
  String textInitial = "";
  int countNotifications;
  @override
  void initState() {
    user = widget.user;
    textInitial = textAvatar.initialName(user.firstName, user.lastName).toUpperCase();
    notificationBloc.getCountNotifications();
    notificationBloc.notifyCountStream.listen((count) {
      setState(() {
        countNotifications = count;  
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    areasBloc.getSafeAreas(user.record);
    return WillPopScope(
          onWillPop: () => alert.backPressed(context),
          child: Stack(
          children: <Widget>[
            Container(
              child: Scaffold(
                body: Container(
                  padding: EdgeInsets.only(
                    top: 50,
                    left: 23,
                    right: 23
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text("Cleanning",style: TextStyle(color:Colors.white, fontSize: 20),)),
                          Badge(
                            position: BadgePosition.topEnd(top: 1, end: 6),
                            badgeContent: Text( countNotifications != null ? countNotifications > 0 ? countNotifications.toString() : "" : "",style: TextStyle(color:Colors.white),),
                            child: IconButton(
                                      icon: Icon(Icons.notifications,color: Colors.white,size: 28,),
                                      onPressed: (){
                                        navigator.directNotificactionsPage(context);
                                      }),
                          ),
                          SizedBox(width: 10),
                          iconPopUpMenu()
                        ],
                      ),
                      Text("${user.firstName} ${user.lastName}",textAlign: TextAlign.start,style: TextStyle(color:Colors.white)),
                      SizedBox(height: 15),
                      fieldSearch()
                    ],
                  ),
                ),
                backgroundColor: Color(0xff3DA6AB),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(75)),
                color: Colors.white,
              ),
              child:  Padding(
              padding: EdgeInsets.only(top: 23,right: 23,left: 15),
              child: Scaffold(
              backgroundColor: Colors.white,
                  body: Column(
                    children: [
                      Container(
                        height:  25,
                        child:  Center(
                            child: Text("Safe Areas",
                            style: TextStyle(
                              fontFamily: 'SFUIDisplay',
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                        ),
                      ),
                      Expanded(
                        child: listAreas(),
                      ),
                    ],
                  ),
                  floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
              floatingActionButton: buttonScan(),    
            ),
                ),
            )
          ],
        ),
    );
  }

 Widget fieldSearch(){
   return TextField(
            // style: TextStyle(color: Colors.white),
            // cursorColor: Colors.white,
            onChanged: _filterSearch,
                      controller: _controller,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                  icon: Icon(Icons.cancel, color: Colors.grey),
                  onPressed: _cleanTextSearch
              ),
              filled: true,
              fillColor: Color.fromRGBO(255, 255, 255, 1),
              //icon: Icon(Icons.search,color: Colors.white,),
              hintText: "Search areas",
              contentPadding: const EdgeInsets.only(
                  left: 15.0, bottom: 10.0, top: 10.0, right: 10.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(25.7),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(25.7),
              ),
            ),
    );
 }


 Widget listAreas() {
    return Container(
            child: StreamBuilder<List<CleanLogModel>>(
                stream: areasBloc.areasStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return skeleton.skeletonLoading();

                  final areas = snapshot.data;
                  if (areas.length == 0) {
                     return ListView(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .2,
                          ),
                          Icon(Icons.assignment_late,size: 100,color: Colors.grey),
                          Center(child:Text("No assigned areas!",style: TextStyle(fontSize: 17,color: Colors.grey)))      
                        ],
                      );
                  }

                   return ListView.builder(
                      itemCount: areas.length,
                        itemBuilder: (context,i) => CardClean(areasModel: areas[i])
                    );
                }));
  }

  Widget iconPopUpMenu() {
    return PopupMenuButton<Choice>(
            onSelected: _selectPopMenu,
            child: CircleAvatar(child: Text(textInitial,style: TextStyle(fontSize: 25,color: Colors.black)),radius:25,backgroundColor: Colors.white),
            itemBuilder: (BuildContext context) {
              return choices.map((Choice choice) {
                return PopupMenuItem<Choice>(
                    value: choice,
                    child: Row(
                      children: <Widget>[
                        choice.icon,
                        SizedBox(
                          width: 10,
                        ),
                        Text(choice.title)
                      ],
                    )
                    //child: Text(choice.title),
                    );
              }).toList();
            },
    );
  }

  Widget buttonScan(){
   return FloatingActionButton(
          backgroundColor: Colors.black,
          child:Icon(Icons.filter_center_focus),
          onPressed: _scanQR
  );
 }

  _selectPopMenu(Choice choice) {
    switch (choice.title) {
      case 'Cerrar sesión':
      //areasBloc.dispose();
        cache.deleteCache();
        DBProvider.db.signOut(context);
        break;
    }
  }

  _filterSearch(String text) {
    setState(() {
      UserGlobal.safeAreas = text;
    });
  }

  _cleanTextSearch(){
    setState(() {
      UserGlobal.safeAreas = "";
      _controller.text = "";  
    });
    
  }

  _scanQR() async {
    var result = await BarcodeScanner.scan();
    switch (result.type.toString()) {
      case 'Cancelled':
        toast.show("Escanneo cancelado");
        break;
      case 'Barcode':
      if(result.rawContent.contains("id") && result.rawContent.contains("type") && result.rawContent.contains("area")){
        alert.loading(context);
        var scan = json.decode(result.rawContent.replaceAll("'", "\""));
        int statusCode = await ObjectsService.objectsService.postObjects(scan["id"], scan["area"]);
        if(statusCode == 200){
            Navigator.pop(context,false);
            toast.show("Objeto registrado");
            areasBloc.getSafeAreas(user.record);
        }else{
            Navigator.pop(context,false);
            toast.show("Error al registrar ingreso");
        }
      }else{
        toast.show("without results");
      }
        //preparePost(result.rawContent);
      break;
      case 'Failed':
      toast.show("Escanneo fallido");
      break;
    }
  }
/*
   @override
  void dispose() {
    if (areasBloc != null) areasBloc.dispose();
    super.dispose();
  }*/

}