class NotificationModel{
  int id;
  String title;
  String body;
  int status;

  NotificationModel({this.id,this.title,this.body,this.status});

  factory NotificationModel.fromJsonData(Map<String, dynamic> json) => NotificationModel(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        status: json['status']
  );

  factory NotificationModel.fromJsonRest(Map<String, dynamic> json) => NotificationModel(
        title: json['title'],
        body: json['body']
  );

  Map<String, dynamic> toJson() =>
      {"id": id, "title": title, "body": body, "status": status};
}

class ListNotificationModel {
  List<NotificationModel> listNotificactions = new List();
  ListNotificationModel();

  ListNotificationModel.fromJsonListRest(List<dynamic> jsonList){
    if(jsonList == null) return;

    for( var item in jsonList ){
      final notification = new NotificationModel.fromJsonRest(item);
      listNotificactions.add(notification);
    }
  }

  ListNotificationModel.fromJsonListData(List<dynamic> jsonList){
    if(jsonList == null) return;

    for( var item in jsonList ){
      //print("========= LIST MODEL ========");
      //print(item);
      final notification = new NotificationModel.fromJsonData(item);
      listNotificactions.add(notification);
    }
  }
}