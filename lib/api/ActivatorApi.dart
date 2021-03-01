import 'package:activator/models/Plugin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:activator/models/Server.dart';

class ActivatorApi {

  static Future<List<Plugin>> getPluginList(Server server) async{
    var client = http.Client();
    var url = server.url;
    var token = server.token;

    try {
      var resp = await client.get('$url/wp-json/deactivator/v1/list?token=$token');
      if (resp.statusCode < 400) {
        var jsonResponse = convert.jsonDecode(resp.body);
        print(jsonResponse);
        if (jsonResponse['success']) {
          final List<Plugin> plugins = [];
          for (int i =0; i<jsonResponse['data'].length; i++) {
            final item = jsonResponse['data'][i];
            plugins.add(Plugin(
              plugin: item['plugin'],
              title: item['title'],
              status: item['status']
            ));
          }
          return plugins;
        }
        return null;
      }
    } catch (error) {
      print(error);
    }
    return null;
  }

  updatePluginStatus(String token, int id, bool status) {
    try {
      // client.post(url)
    } catch (error) {
      print(error);
    }
  }
}
