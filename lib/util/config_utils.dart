import 'dart:convert';

import 'package:flutter/widgets.dart';

///
///
///
class ConfigUtils {
  final BuildContext context;
  final Map<String, dynamic> configJson = <String, dynamic>{};

  ///
  ///
  ///
  ConfigUtils(this.context);

  ///
  ///
  ///
  Future<void> loadFromAsset(
    String assetPath, [
    bool removeEnvSubst = true,
  ]) async {
    configJson.clear();

    try {
      String configString =
          await DefaultAssetBundle.of(context).loadString(assetPath);

      Map<String, dynamic> localConfig = json.decode(configString);

      if (removeEnvSubst) {
        localConfig.removeWhere(
          (String key, dynamic value) => value.toString().startsWith(r'${'),
        );
      }

      configJson.addAll(localConfig);
    } catch (ex) {
      // do nothing;
    }
  }

  ///
  ///
  ///
  String stringOrDefault(String key, String defaultValue) =>
      configJson[key] ?? defaultValue;

  ///
  ///
  ///
  bool boolOrDefault(String key, bool defaultValue) =>
      configJson.containsKey(key)
          ? configJson[key].toString().toLowerCase() == 'true'
          : defaultValue;

  ///
  ///
  ///
  int intOrDefault(String key, int defaultValue) => configJson.containsKey(key)
      ? int.tryParse(configJson[key]) ?? defaultValue
      : defaultValue;

  ///
  ///
  ///
  double doubleOrDefault(String key, double defaultValue) =>
      configJson.containsKey(key)
          ? double.tryParse(configJson['logoMin'].toString()) ?? defaultValue
          : defaultValue;
}
