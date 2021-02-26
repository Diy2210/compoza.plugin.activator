import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:activator/models/Server.dart';

class ActivatorApi {
  var client = http.Client();

  Future<Map<String, dynamic>> getPluginList(Server server) async{
    var url = server.url;
    var token = server.token;

    try {
      var resp = await client.get('$url/wp-json/deactivator/v1/list?token=$token');
      if (resp.statusCode < 400) {
        var jsonResponse = convert.jsonDecode(resp.body);
        if (jsonResponse['success']) {
          return jsonResponse['data'];
        }
        return null;
      }
    } catch (error) {
      print(error);
    }
  }

  updatePluginStatus(String token, int id, bool status) {
    try {
      // client.post(url)
    } catch (error) {
      print(error);
    }
  }
}
