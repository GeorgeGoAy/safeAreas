class AreasModel {
  int id;
  int record;
  String description;
  String idArea;
  String status;
  String comments;
  int objetos;

  AreasModel({this.id,this.record, this.description, this.idArea,this.status,this.comments,this.objetos});

  factory AreasModel.fromJson(Map<String, dynamic> json) => AreasModel(
        id: json['id'],
        record:json['record'],
        description: json['description'],
        idArea: json['idArea'],
        status: json['status'],
        comments: json['comments'],
        objetos: json['objetos']
  );

  factory AreasModel.fromJsonRest(Map<String, dynamic> json) => AreasModel(
        record:json['Record_ID_'],
        description: json['Description'],
        idArea: json['Id_Area'],
        status: json['Status'],
        comments: json['Comments'],
        objetos: json['acum'],
  );

  Map<String, dynamic> toJson() =>
      {"id": id,"record":record, "description": description, "idArea": idArea, "status": status,"comments":comments,"objetos":objetos};
}

class ListaAreasModel {
  List<AreasModel> listaAreas = new List();
  ListaAreasModel();

  ListaAreasModel.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;

    for( var item in jsonList ){
      final areasModel = new AreasModel.fromJsonRest(item);
      listaAreas.add(areasModel);
    }
  }
}