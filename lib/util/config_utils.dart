import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@Deprecated('Refactor this class.')
class ConfigUtils {
  final BuildContext context;
  final Map<String, dynamic> configJson = <String, dynamic>{};

  ConfigUtils(this.context);

  Future<void> loadFromAsset(
    String assetPath, {
    bool removeEnvSubst = true,
  }) async {
    configJson.clear();

    try {
      String configString = await DefaultAssetBundle.of(
        context,
      ).loadString(assetPath);

      Map<String, dynamic> localConfig = json.decode(configString);

      if (removeEnvSubst) {
        localConfig.removeWhere(
          (String key, dynamic value) => value.toString().startsWith(r'${'),
        );
      }

      configJson.addAll(localConfig);
    } on Exception catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
    }
  }

  String stringOrDefault(String key, String defaultValue) =>
      configJson[key] ?? defaultValue;

  bool boolOrDefault(String key, {required bool defaultValue}) =>
      configJson.containsKey(key)
      ? configJson[key].toString().toLowerCase() == 'true'
      : defaultValue;

  int intOrDefault(String key, int defaultValue) => configJson.containsKey(key)
      ? int.tryParse(configJson[key]) ?? defaultValue
      : defaultValue;

  double doubleOrDefault(String key, double defaultValue) =>
      configJson.containsKey(key)
      ? double.tryParse(configJson[key].toString()) ?? defaultValue
      : defaultValue;
}
