import 'package:package_info/package_info.dart';
import 'package:activator/localization.dart';

class AppInfoService {
  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return 'ver %s'.i18n.fill([packageInfo.version]);
  }
}