// ignore_for_file: avoid-top-level-members-in-tests

import 'package:package_info_plus/package_info_plus.dart';

///
///
///
// ignore: avoid_implementing_value_types
class MockPackageInfo implements PackageInfo {
  @override
  final String appName;
  @override
  final String buildNumber;
  @override
  final String buildSignature;
  @override
  final String? installerStore;
  @override
  final String packageName;
  @override
  final String version;

  ///
  ///
  ///
  MockPackageInfo({
    this.appName = 'folly_fields',
    this.buildNumber = '0',
    this.buildSignature = '',
    this.installerStore,
    this.packageName = 'folly_fields',
    this.version = '0.0.0',
  });

  ///
  ///
  ///
  @override
  Map<String, dynamic> get data => <String, dynamic>{
        'appName': appName,
        'buildNumber': buildNumber,
        'buildSignature': buildSignature,
        'installerStore': installerStore,
        'packageName': packageName,
        'version': version,
      };
}
