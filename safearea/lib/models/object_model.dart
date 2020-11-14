class ObjectModel {
  int id;
  String name;
  String description;
  String qrId;

  ObjectModel({this.id, this.name, this.description,this.qrId});

  factory ObjectModel.fromJson(Map<String, dynamic> json) => ObjectModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        qrId: json['qrId']
  );

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "description": description, "qrId": qrId};
}