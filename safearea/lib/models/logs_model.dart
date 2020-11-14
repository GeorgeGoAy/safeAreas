class LogsModel {
  int record;
  String date;
  String firtsName;
  String lastName;
  String description;

  LogsModel({this.record,this.date,this.firtsName,this.lastName,this.description});

  factory LogsModel.fromJson(Map<String, dynamic> json) => LogsModel(
      record: json['Record_ID_'],
      date:json['Date_Created'],
      firtsName: json['Firts_Name'],
      lastName: json['Last_Name'],
      description: json['Description']
  );

  Map<String, dynamic> toJson() => {
    "record":record,"date":date,"firtsName":firtsName,"lastName":lastName,"description":description
  };
  
}

class ListLogsModel {
  List<LogsModel> listLogs = new List();
  ListLogsModel();

  ListLogsModel.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;

    for( var item in jsonList ){
      final logsModel = new LogsModel.fromJson(item);
      listLogs.add(logsModel);
    }
  }
}