import 'dart:async';
import 'package:activator/models/ServerModel.dart';
import 'package:activator/database/Repository.dart';

class DBHelper {
  final _repository = Repository();

  // ignore: close_sinks
  final StreamController<List<ServerModel>> _controller =
      StreamController<List<ServerModel>>.broadcast();

  get servers => _controller.stream;

  saveServer(String table, ServerModel model) async {
    _controller.sink.add(await _repository.insertServer(table, model));
  }

  updateServer(String table, ServerModel model) async {
    _controller.sink.add(await _repository.updateServer(table, model));
  }

  deleteServer(String table, ServerModel model) async {
    _controller.sink.add(await _repository.deleteServer(table, model));
  }
}
