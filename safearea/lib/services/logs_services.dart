import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:safearea/models/logs_model.dart';
class LogService {
  static final LogService logService = LogService._();
  LogService._();

  static final String uriLogs = "https://tsc-safe-areas.herokuapp.com/log";

  
   Future<List<LogsModel>> getLogs(int id, String fecha) async{
    final response   = await http.get("$uriLogs/$id/$fecha",
                             headers: { HttpHeaders.contentTypeHeader: 'application/json'});
    final decodeData = json.decode(response.body);
    print(decodeData);
    final logs    = new ListLogsModel.fromJsonList(decodeData['response']);
    return logs.listLogs;
  }


  Future<int> postLogs(int idUser, int idSafeArea) async{
    final response   = await http.post(uriLogs,
                             headers: { HttpHeaders.contentTypeHeader: 'application/json'},
                              body: jsonEncode(<String, String>{
                              'idUser': idUser.toString(),
                              'idSafeArea': idSafeArea.toString()
                            }));

    final decodeData = json.decode(response.body);
    return decodeData['status'];
  }


}