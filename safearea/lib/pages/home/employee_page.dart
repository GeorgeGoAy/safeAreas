
import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:safearea/bloc/logs_bloc.dart';
import 'package:safearea/bloc/notifications_bloc.dart';
import 'package:safearea/database/database.dart';
import 'package:safearea/models/logs_model.dart';
import 'package:safearea/models/user_model.dart';
import 'package:safearea/services/logs_services.dart';
import 'package:safearea/utils/global_user.dart';
import 'package:safearea/widget/cardLog_widget.dart';
import 'package:safearea/widget/popmenu_widget.dart';
import 'package:safearea/widget/skeleton_widget.dart' as skeleton;
import 'package:safearea/utils/text_avatar.dart' as textAvatar;
import 'package:safearea/widget/toast_widget.dart' as toast;
import 'package:safearea/widget/alert_widget.dart' as alert;
import 'package:safearea/utils/navigator.dart' as navigator;
import 'package:safearea/utils/delete_cache.dart' as cache;

class EmployeePage extends StatefulWidget {
  final UserModel user;
  EmployeePage({Key key,this.user}) : super(key: key);

  @override
  _EmployeePageState createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
UserModel user;
final  logsBloc = new LogsBloc();
final notificationBloc = NotiticationBloc();
DateTime selectedDate = DateTime.now();
String textInitial = "";
String dateFilter = "";
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
    //getCountNotifications();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    logsBloc.getLogs(user.record, "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}");
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
                          Expanded(child: Text("Employee",style: TextStyle(color:Colors.white, fontSize: 20),)),
                          Badge(
                            position: BadgePosition.topEnd(top: 1, end: 6),
                            badgeContent: Text(countNotifications != null ? countNotifications > 0 ? countNotifications.toString() : "" : "",style: TextStyle(color:Colors.white),),
                            child: IconButton(
                              icon: Icon(Icons.notifications,color: Colors.white,size: 28,),
                              onPressed: (){
                                navigator.directNotificactionsPage(context);
                              }),
                          ),
                          SizedBox(width: 10,),
                          iconPopUpMenu()
                        ],
                      ),
                      Text("${user.firstName} ${user.lastName}",textAlign: TextAlign.start,style: TextStyle(color:Colors.white)),
                      SizedBox(height: 20),
                      InkWell(
                          onTap: (){
                            _selectDate(context);
                          },
                          child: Row(children: [
                          Expanded(child: SizedBox()),
                          dateFilter != "" ? Text("Selected date: "+dateFilter,style: TextStyle(fontSize: 20,color: Colors.amber),): Text("Click To Filter",style: TextStyle(fontSize: 20,color: Colors.white)),
                          SizedBox(width: 10),
                          Icon(Icons.date_range,size: 28, color: dateFilter != "" ? Colors.amber: Colors.white)
                        ],),
                      )
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
                              child: Text("Today's Income",
                              style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                              ),
                          ),
                        ),
                        Expanded(
                          child: listLogs(),
                        ),
                      ],
                    ),
                    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
                floatingActionButton: incomeAreas(),    
              ),
                ),
            )
          ],
        ),
    );
  }

  Widget listLogs() {
    return Container(
            child: StreamBuilder<List<LogsModel>>(
                stream: logsBloc.logsStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData || UserGlobal.enableSkeleton)
                    return skeleton.skeletonLoading();

                  final logs = snapshot.data;
                  if (logs.length == 0) {
                     return ListView(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .2,
                          ),
                          Icon(Icons.assignment_late,size: 100,color: Colors.grey),
                          Center(child:Text("No logs!",style: TextStyle(fontSize: 17,color: Colors.grey)))      
                        ],
                      );
                  }

                   return ListView.builder(
                      itemCount: logs.length,
                        itemBuilder: (context,i) => CardLog(logsModel: logs[i])
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

  _selectDate(BuildContext context) async {
  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: selectedDate, // Refer step 1
    firstDate: DateTime(2000),
     builder: (BuildContext context, Widget child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                    primary:Color(0xFFA64884),
                    onPrimary: Colors.white,
                    surface: Colors.amber,
                    onSurface: Colors.black,
                    ),
                dialogBackgroundColor:Colors.white,
              ),
              child: child,
            );
          },
    lastDate: DateTime(2025),
    cancelText: "Cancel",
    confirmText: "Ok",
  );
  if (picked != null && picked != selectedDate){
     setState(() {
      UserGlobal.enableSkeleton = true;
      dateFilter = "${picked.day}-${picked.month}-${picked.year}";
      selectedDate = picked;
      logsBloc.getLogs(user.record, "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}");
    });
  } 
   
}

  _selectPopMenu(Choice choice) {
    switch (choice.title) {
      case 'Log out':
      //areasBloc.dispose();
        cache.deleteCache();
        DBProvider.db.signOut(context);
        break;
    }
  }

 Widget incomeAreas(){
   return FloatingActionButton(
          backgroundColor: Colors.black,
          child:Icon(Icons.filter_center_focus),
          onPressed: _scanQR
  );
 }

 _scanQR() async {
    var result = await BarcodeScanner.scan();
    switch (result.type.toString()) {
      case 'Cancelled':
        toast.show("Scan canceled");
        break;
      case 'Barcode':
        if(result.rawContent.contains("id") && result.rawContent.contains("type")){
          var scan = json.decode(result.rawContent.replaceAll("'", "\""));
          if(scan["type"] == "Area"){
            alert.loading(context);
            int statusCode = await LogService.logService.postLogs(user.record, scan["id"]);
            if(statusCode == 200){
                await logsBloc.getLogs(user.record, "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}");
                Navigator.pop(context,false);
                toast.show("Registered login");
            }else{
                Navigator.pop(context,false);
                toast.show("Error when registering login");
            }
          }else{
            toast.show(scan.toString());
          }
        }else{
          toast.show("Without results");
        }
      
        //preparePost(result.rawContent);
        
        break;
      case 'Failed':
        toast.show("Scan failed");
        break;
    }
  }

}