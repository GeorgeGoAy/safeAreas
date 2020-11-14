import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:safearea/models/cleanLog_model.dart';

class AreaService {
  static final AreaService areaService = AreaService._();
  AreaService._();

  static final _uriAreas = "https://tsc-safe-areas.herokuapp.com/clean/";


  Future<List<CleanLogModel>> getSafeAreas(int id) async{
    DateTime now = DateTime.now();
    final response   = await http.get(_uriAreas+id.toString()+"/${now.year}-${now.month}-${now.day}");
    final decodeData = json.decode(response.body);
    final areas    = new ListaCleanLogModel.fromJsonList(decodeData['response']);
    return areas.listaCleanLog;
  }

}