import 'package:activator/models/Plugin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:activator/models/Server.dart';

class ActivatorApi {
  static Future<List<Plugin>> getPluginList(Server server) async {
    try {
      var resp = await http.Client().get(
        Uri.parse(
          '${server.url}/wp-json/deactivator/v1/list?token=${server.token}',
        ),
      );
      if (resp.statusCode < 400) {
        var jsonResponse = convert.jsonDecode(resp.body);
        if (jsonResponse['success']) {
          final List<Plugin> plugins = [];
          for (int i = 0; i < jsonResponse['data'].length; i++) {
            final item = jsonResponse['data'][i];
            plugins.add(
              Plugin(
                plugin: item['plugin'],
                title: item['title'],
                status: item['status'],
              ),
            );
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

  static Future updatePluginStatus(
    Server server,
    Plugin plugin,
    bool state,
  ) async {
    var status = 'deactivate';

    if (state) {
      status = 'activate';
    }

    var params = {
      'token': server.token,
      'id': plugin.plugin,
      'status': status,
    };

    try {
      await http.Client().post(
        Uri.parse("${server.url}/wp-json/deactivator/v1/update"),
        body: params,
      );
    } catch (error) {
      print(error);
    }
  }
}
