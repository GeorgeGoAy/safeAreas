class CleanLogModel {
  
  String key;
  int idArea;
  int idUser;
  int objetos;
  String description;
  String comments;
  int totalObjects;

  CleanLogModel({this.key, this.description, this.idArea,this.idUser,this.comments,this.objetos,this.totalObjects});

  factory CleanLogModel.fromJson(Map<String, dynamic> json) => CleanLogModel(
        
        key:json['Key'],
        description: json['Description'],
        idArea: json['Related_Safe_Area'],
        idUser: json['Related_App_User'],
        comments: json['Comments'],
        objetos: json['Num_Object_cleanings'],
        totalObjects: json['acumObjectsTotal']
  );


  Map<String, dynamic> toJson() =>
      {"key":key, "description": description, "idArea": idArea, "idUser": idUser,"comments":comments,"objetos":objetos};
}

class ListaCleanLogModel {
  List<CleanLogModel> listaCleanLog = new List();
  ListaCleanLogModel();

  ListaCleanLogModel.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;

    for( var item in jsonList ){
      final cleanModel = new CleanLogModel.fromJson(item);
      listaCleanLog.add(cleanModel);
    }
  }
}