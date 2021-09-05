library folly_fields;

import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';

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
  bool get isDebug;

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
    bool debug = false,
    String modelIdKey = 'id',
    String modelUpdatedAtKey = 'updatedAt',
    String modelDeletedAtKey = 'deletedAt',
    bool modelParseDates = false,
  }) =>
      FollyFields()._holder = holder
        .._start(
          debug: debug,
          modelIdKey: modelIdKey,
          modelUpdatedAtKey: modelUpdatedAtKey,
          modelDeletedAtKey: modelDeletedAtKey,
          modelParseDates: modelParseDates,
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
  bool get isDebug => _holder!.isDebug;

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
}

///
///
///
abstract class AbstractConfig implements _InternalConfig {
  bool _started = false;
  bool _debug = false;
  bool _online = false;
  RunningPlatform _platform = RunningPlatform.unknown;
  String _modelIdKey = 'id';
  String _modelUpdatedAtKey = 'updatedAt';
  String _modelDeletedAtKey = 'deletedAt';
  bool _modelParseDates = false;

  ///
  ///
  ///
  @override
  bool get isDebug => _debug;

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
  void _start({
    required bool debug,
    required String modelIdKey,
    required String modelUpdatedAtKey,
    required String modelDeletedAtKey,
    required bool modelParseDates,
  }) async {
    if (_started) {
      // ignore: avoid_print
      if (debug) print('Folly Fields already started, ignoring...');
    } else {
      _started = true;
      // ignore: avoid_print
      if (debug) print('Folly Fields Started.');
      _debug = debug;

      _modelIdKey = modelIdKey;
      _modelUpdatedAtKey = modelUpdatedAtKey;
      _modelDeletedAtKey = modelDeletedAtKey;
      _modelParseDates = modelParseDates;

      if (kIsWeb) {
        _platform = RunningPlatform.web;
      } else if (Platform.isAndroid) {
        _platform = RunningPlatform.android;
      } else if (Platform.isIOS) {
        _platform = RunningPlatform.ios;
      }

      ConnectivityResult result = await Connectivity().checkConnectivity();

      _online = result != ConnectivityResult.none;

      Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
        _online = result != ConnectivityResult.none;
        // ignore: avoid_print
        if (debug) print('Connectivity Changed: $_online');
      });
    }
  }
}
