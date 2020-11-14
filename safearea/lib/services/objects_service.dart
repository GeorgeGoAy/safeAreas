import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ObjectsService {
  static final ObjectsService objectsService = ObjectsService._();

  ObjectsService._();

  static final uriObject = "https://tsc-safe-areas.herokuapp.com/cleanObject";

  
  Future<int> postObjects(int idObject, int idSafeArea) async{
    DateTime now = DateTime.now();
    final response   = await http.post(uriObject,
                             headers: { HttpHeaders.contentTypeHeader: 'application/json'},
                              body: jsonEncode(<String, dynamic>{
                              'boolClean': true,
                              'object': idObject,
                              'cleanLog':"${now.year}${now.month}${now.day}${idSafeArea.toString()}"
                            }));

    final decodeData = json.decode(response.body);
    return decodeData['status'];
  }
}