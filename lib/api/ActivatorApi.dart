import 'package:http/http.dart' as http;

class ActivatorApi {
  var client = http.Client();

  getPluginList(String url, String token) {
    //..."${server.url}/wp-json/deactivator/v1/list?token=${server.token}"
    // try {
    //   client.get('$url/wp-json/deactivator/v1/list?token=$token');
    // } finally {
    // client.close();
    // }

    //#1
    // client.get('$url/wp-json/deactivator/v1/list?token=$token').then((response) {
    //   print("Response body: ${response.body}");
    // }).catchError((error) {
    //   print("Error: $error");
    // });

    // #2
    // client.get('https://json.flutter.su/echo').then((response) {
    //   // print("Response status: ${response.statusCode}");
    //   // print("Response body: ${response.body}");
    // }).catchError((error){
    //   print("Error: $error");
    // });

    //#3
    try {
      client.get('$url/wp-json/deactivator/v1/list?token=$token');
    } catch (error) {
      print(error);
    }

    updatePluginStatus(String token, int id, bool status) {
      try {
        // client.post(url)
      } catch (error) {
        print(error);
      }
    }
  }
}