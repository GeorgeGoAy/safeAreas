import 'dart:async';

import 'package:safearea/bloc/validator/validaAreas.dart';
import 'package:safearea/models/cleanLog_model.dart';

import 'package:safearea/services/areas_services.dart';
import 'package:safearea/utils/global_user.dart';

class AreasBloc with ValidaSafe{
  static final AreasBloc _blocAreas = new AreasBloc._internal();

  factory AreasBloc(){
    return _blocAreas;
  }

  AreasBloc._internal(){
    getSafeAreas(UserGlobal.user.record);
  }

  final _areasController = StreamController<List<CleanLogModel>>.broadcast();

  Stream<List<CleanLogModel>> get areasStream => _areasController.stream.transform(filterSafeAreas);

  dispose(){
    _areasController?.close();
  }

  getSafeAreas(int id) async{
    List<CleanLogModel> lista = await AreaService.areaService.getSafeAreas(id);
    _areasController.sink.add(lista);
  }
}