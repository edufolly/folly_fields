import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@Deprecated('Refactor this class.')
class ConfigUtils {
  final BuildContext context;
  final Map<String, dynamic> configJson = <String, dynamic>{};

  ConfigUtils(this.context);

  Future<void> loadFromAsset(
    final String assetPath, {
    final bool removeEnvSubst = true,
  }) async {
    configJson.clear();

    try {
      String configString = await DefaultAssetBundle.of(
        context,
      ).loadString(assetPath);

      Map<String, dynamic> localConfig = json.decode(configString);

      if (removeEnvSubst) {
        localConfig.removeWhere(
          (final String key, final dynamic value) =>
              value.toString().startsWith(r'${'),
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

  String stringOrDefault(final String key, final String defaultValue) =>
      configJson[key] ?? defaultValue;

  bool boolOrDefault(final String key, {required final bool defaultValue}) =>
      configJson.containsKey(key)
      ? configJson[key].toString().toLowerCase() == 'true'
      : defaultValue;

  int intOrDefault(final String key, final int defaultValue) =>
      configJson.containsKey(key)
      ? int.tryParse(configJson[key]) ?? defaultValue
      : defaultValue;

  double doubleOrDefault(final String key, final double defaultValue) =>
      configJson.containsKey(key)
      ? double.tryParse(configJson[key].toString()) ?? defaultValue
      : defaultValue;
}
