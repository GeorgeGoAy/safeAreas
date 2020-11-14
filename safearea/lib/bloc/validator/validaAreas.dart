import 'dart:async';

import 'package:safearea/models/cleanLog_model.dart';
import 'package:safearea/utils/global_user.dart';

class ValidaSafe {

  final filterSafeAreas = StreamTransformer<List<CleanLogModel>,List<CleanLogModel>>.fromHandlers(
    handleData: (objAreas, sink) {
      final areas = objAreas.where((element) => element.description.toLowerCase().contains(UserGlobal.safeAreas)).toList();
      sink.add(areas);
    }
  );

}