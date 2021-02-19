import 'package:activator/models/ServerModel.dart';

class ServerItem extends ServerModel {

  static String table = 'server_items';

  int id;
  String title;
  String url;
  String token;

  ServerItem({ this.id, this.title, this.url, this.token });

  Map<String, dynamic> toMap() {

    Map<String, dynamic> map = {
      'id' : id,
      'title': title,
      'url': url,
      'token': token,
    };

    if (id != null) { map['id'] = id; }
    return map;
  }

  static ServerItem fromMap(Map<String, dynamic> map) {

    return ServerItem(
        id: map['id'],
        title: map['title'],
        url: map['url'],
        token: map['token'],
    );
  }
}