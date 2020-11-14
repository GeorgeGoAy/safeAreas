import 'dart:async';

import 'package:safearea/models/logs_model.dart';
import 'package:safearea/services/logs_services.dart';
import 'package:safearea/utils/global_user.dart';

class LogsBloc{
  static final LogsBloc _blocAreas = new LogsBloc._internal();

  factory LogsBloc(){
    return _blocAreas;
  }

  LogsBloc._internal(){
    var now = new DateTime.now();
    getLogs(UserGlobal.user.record,"${now.day}-${now.month}-${now.year}");
  }

  final _logsController = StreamController<List<LogsModel>>.broadcast();

  Stream<List<LogsModel>> get logsStream => _logsController.stream;

  dispose(){
    _logsController?.close();
  }

  getLogs(int id,String fecha) async{
    List<LogsModel> lista = await LogService.logService.getLogs(id, fecha);
     UserGlobal.enableSkeleton = false;
    _logsController.sink.add(lista);
  }
}