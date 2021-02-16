import 'dart:async';
import 'package:activator/models/ServerModel.dart';
import 'package:activator/database/Repository.dart';

class DBHelper {
  final _repository = Repository();

  final StreamController<List<ServerModel>>_controller = StreamController<List<ServerModel>>.broadcast();

  get servers => _controller.stream;
}