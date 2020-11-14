import 'package:flutter/material.dart';
import 'package:safearea/bloc/notifications_bloc.dart';
import 'package:safearea/models/notificaction_model.dart';
import 'package:safearea/widget/cardNotification_widget.dart';
import 'package:safearea/widget/skeleton_widget.dart' as skeleton;

class NotificationsPage extends StatefulWidget {
  NotificationsPage({Key key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final notificationBloc = NotiticationBloc();
  @override
  void initState() {
    notificationBloc.updateViewNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    notificationBloc.getAllNotifications();
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        backgroundColor:  Color(0xff3DA6AB),
      ),
      body: listLogs(),
    );
  }

  Widget listLogs() {
    return Container(
            padding: EdgeInsets.all(10),
            child: StreamBuilder<List<NotificationModel>>(
                stream: notificationBloc.notifyStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return skeleton.skeletonLoading();

                  final notificacion = snapshot.data;
                  if (notificacion.length == 0) {
                     return ListView(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .3,
                          ),
                          Icon(Icons.notification_important,size: 100,color: Colors.grey),
                          Center(child:Text("No notifications!",style: TextStyle(fontSize: 17,color: Colors.grey)))      
                        ],
                      );
                  }

                   return ListView.builder(
                      itemCount: notificacion.length,
                        itemBuilder: (context,i) => CardNotification(notificactionModel: notificacion[i])
                    );
                }));
  }
}