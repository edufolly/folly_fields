import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:folly_fields/extensions/scope_extension.dart';

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
      debugPrintStack(label: e.toString(), stackTrace: s);
    }
  }

  String stringOrDefault(String key, String defaultValue) =>
      configJson[key] ?? defaultValue;

  bool boolOrDefault(String key, {required bool defaultValue}) =>
      configJson[key]?.toString().let((String it) => it == 'true') ??
      defaultValue;

  int intOrDefault(String key, int defaultValue) =>
      configJson[key]?.toString().let(int.tryParse) ?? defaultValue;

  double doubleOrDefault(String key, double defaultValue) =>
      configJson[key]?.toString().let(double.tryParse) ?? defaultValue;
}
