import 'package:activator/models/ServerModel.dart';

class ServerItem extends ServerModel {

  static String table = 'server_items';

  int id;
  String title;
  String url;
  String token;
  bool complete;

  ServerItem({ this.id, this.title, this.url, this.token, this.complete });

  Map<String, dynamic> toMap() {

    Map<String, dynamic> map = {
      'id' : id,
      'title': title,
      'url': url,
      'token': token,
      'complete': complete
    };

    if (id != null) { map['id'] = id; }
    // if (title != null) { map['title'] = title; }
    // if (url != null) { map['url'] = url; }
    // if (token != null) { map['token'] = token; }
    return map;
  }

  static ServerItem fromMap(Map<String, dynamic> map) {

    return ServerItem(
        id: map['id'],
        title: map['title'],
        url: map['url'],
        token: map['token'],
        complete: map['complete'] == 1
    );
  }
}