import 'package:activator/models/Server.dart';

class EditScreenArguments {
  final Server server;
  final Function saveHandler;

  EditScreenArguments({this.server, this.saveHandler});
}

