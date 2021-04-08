import 'package:i18n_extension/i18n_extension.dart';
import 'main.dart';

extension Localization on String {

  static TranslationsByLocale _t = translations;

  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(int value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);
}