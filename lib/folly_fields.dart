library folly_fields;

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:folly_fields/responsive/responsive.dart';

///
///
///
enum RunningPlatform {
  unknown,
  web,
  android,
  ios,
}

///
///
///
extension RunningPlatformExt on RunningPlatform {
  ///
  ///
  ///
  String get name => toString().split('.').last.toLowerCase();
}

///
///
///
abstract class _InternalConfig {
  ///
  ///
  ///
  bool get isOnline;

  ///
  ///
  ///
  bool get isOffline;

  ///
  ///
  ///
  bool get isWeb;

  ///
  ///
  ///
  bool get isMobile;

  ///
  ///
  ///
  String get platform;

  ///
  ///
  ///
  String get modelIdKey;

  ///
  ///
  ///
  String get modelUpdatedAtKey;

  ///
  ///
  ///
  String get modelDeletedAtKey;

  ///
  ///
  ///
  bool get modelParseDates;

  ///
  ///
  ///
  List<double> get responsiveSizes;
}

///
///
///
class FollyFields implements _InternalConfig {
  static final FollyFields _singleton = FollyFields._internal();

  ///
  ///
  ///
  static void start(
    AbstractConfig holder, {
    String modelIdKey = 'id',
    String modelUpdatedAtKey = 'updatedAt',
    String modelDeletedAtKey = 'deletedAt',
    bool modelParseDates = false,
    List<double> responsiveSizes = const <double>[540, 720, 960, 1140],
    Connectivity? connectivity,
  }) =>
      FollyFields()._holder = holder
        .._start(
          modelIdKey: modelIdKey,
          modelUpdatedAtKey: modelUpdatedAtKey,
          modelDeletedAtKey: modelDeletedAtKey,
          modelParseDates: modelParseDates,
          responsiveSizes: responsiveSizes,
          connectivity: connectivity,
        );

  AbstractConfig? _holder;

  ///
  ///
  ///
  factory FollyFields() {
    return _singleton;
  }

  ///
  ///
  ///
  FollyFields._internal();

  ///
  ///
  ///
  @override
  bool get isMobile => _holder!.isMobile;

  ///
  ///
  ///
  @override
  bool get isOffline => _holder!.isOffline;

  ///
  ///
  ///
  @override
  bool get isOnline => _holder!.isOnline;

  ///
  ///
  ///
  @override
  bool get isWeb => _holder!.isWeb;

  ///
  ///
  ///
  @override
  String get platform => _holder!.platform;

  ///
  ///
  ///
  @override
  String get modelIdKey => _holder!.modelIdKey;

  ///
  ///
  ///
  @override
  String get modelUpdatedAtKey => _holder!.modelUpdatedAtKey;

  ///
  ///
  ///
  @override
  String get modelDeletedAtKey => _holder!.modelDeletedAtKey;

  ///
  ///
  ///
  @override
  bool get modelParseDates => _holder!.modelParseDates;

  ///
  ///
  ///
  @override
  List<double> get responsiveSizes => _holder!.responsiveSizes;

  ///
  ///
  ///
  ResponsiveSize checkResponsiveSize(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (width < responsiveSizes[0]) {
      return ResponsiveSize.extraSmall;
    }

    if (width >= responsiveSizes[0] && width < responsiveSizes[1]) {
      return ResponsiveSize.small;
    }

    if (width >= responsiveSizes[1] && width < responsiveSizes[2]) {
      return ResponsiveSize.medium;
    }

    if (width >= responsiveSizes[2] && width < responsiveSizes[3]) {
      return ResponsiveSize.large;
    }

    return ResponsiveSize.extraLarge;
  }
}

///
///
///
abstract class AbstractConfig implements _InternalConfig {
  bool _started = false;
  bool _online = false;
  RunningPlatform _platform = RunningPlatform.unknown;
  String _modelIdKey = 'id';
  String _modelUpdatedAtKey = 'updatedAt';
  String _modelDeletedAtKey = 'deletedAt';
  bool _modelParseDates = false;
  List<double> _responsiveSizes = const <double>[540, 720, 960, 1140];

  ///
  ///
  ///
  @override
  bool get isOnline => _online;

  ///
  ///
  ///
  @override
  bool get isOffline => !_online;

  ///
  ///
  ///
  @override
  bool get isWeb => _platform == RunningPlatform.web;

  ///
  ///
  ///
  @override
  bool get isMobile =>
      _platform == RunningPlatform.android || _platform == RunningPlatform.ios;

  ///
  ///
  ///
  @override
  String get platform => _platform.name;

  ///
  ///
  ///
  @override
  String get modelIdKey => _modelIdKey;

  ///
  ///
  ///
  @override
  String get modelUpdatedAtKey => _modelUpdatedAtKey;

  ///
  ///
  ///
  @override
  String get modelDeletedAtKey => _modelDeletedAtKey;

  ///
  ///
  ///
  @override
  bool get modelParseDates => _modelParseDates;

  ///
  ///
  ///
  @override
  List<double> get responsiveSizes => _responsiveSizes;

  ///
  ///
  ///
  Future<void> _start({
    required String modelIdKey,
    required String modelUpdatedAtKey,
    required String modelDeletedAtKey,
    required bool modelParseDates,
    required List<double> responsiveSizes,
    Connectivity? connectivity,
  }) async {
    if (_started) {
      if (kDebugMode) {
        print('Folly Fields already started, ignoring...');
      }
    } else {
      _started = true;
      if (kDebugMode) {
        print('Folly Fields Started.');
      }

      _modelIdKey = modelIdKey;
      _modelUpdatedAtKey = modelUpdatedAtKey;
      _modelDeletedAtKey = modelDeletedAtKey;
      _modelParseDates = modelParseDates;

      _responsiveSizes = responsiveSizes;

      if (kIsWeb) {
        _platform = RunningPlatform.web;
      } else if (Platform.isAndroid) {
        _platform = RunningPlatform.android;
      } else if (Platform.isIOS) {
        _platform = RunningPlatform.ios;
      }
      connectivity ??= Connectivity();

      ConnectivityResult result = await connectivity.checkConnectivity();

      _online = result != ConnectivityResult.none;

      connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
        _online = result != ConnectivityResult.none;
        if (kDebugMode) {
          print('Connectivity Changed: $_online');
        }
      });
    }
  }
}
