class UserModel {
  int id;
  int record;
  String firstName;
  String lastName;
  String type;
  String userToken;
  String setClistBitacora;
  String setBitacoraDb;
  String getClistCleaning;
  String getSlistCleaning;


  UserModel({this.id, this.record,this.firstName, this.lastName,this.type,this.userToken,
              this.setClistBitacora,this.setBitacoraDb,this.getClistCleaning,
              this.getSlistCleaning});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        record: json['record'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        type: json['type'],
        userToken: json['userToken'],
        setClistBitacora: json['setClistBitacora'],
        setBitacoraDb: json['setBitacoraDb'],
        getClistCleaning: json['getClistCleaning'],
        getSlistCleaning: json['getSlistCleaning']
  );

  factory UserModel.fromJsonData(Map<String, dynamic> json) => UserModel(
        record: json['Record_ID_'],
        firstName: json['Firts_Name'],
        lastName: json['Last_Name'],
        type: json['Type'],
        userToken: json['userToken'],
        setClistBitacora: json['setClistBitacora'],
        setBitacoraDb: json['setBitacoraDb'],
        getClistCleaning: json['getClistCleaning'],
        getSlistCleaning: json['getSlistCleaning']
  );

  Map<String, dynamic> toJson() =>
      {"id": id,"record": record, "firstName": firstName, "lastName": lastName, "type": type,
      "userToken": userToken,"setClistBitacora": setClistBitacora,"setBitacoraDb": setBitacoraDb,"getClistCleaning": getClistCleaning,"getSlistCleaning": getSlistCleaning};
}