import 'package:package_info/package_info.dart';

class AppInfoHelper {
  Future<String> getVersionNumber() async {
    String ver = 'ver ';
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return ver + packageInfo.version;
  }
}