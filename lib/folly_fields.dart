library folly_fields;

import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';

///
///
///
enum RunningPlatform {
  UNKNOWN,
  WEB,
  ANDROID,
  IOS,
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
}

///
///
///
class FollyFields implements _InternalConfig {
  static final FollyFields _singleton = FollyFields._internal();

  ///
  ///
  ///
  static void start(AbstractConfig holder, {bool debug = false}) =>
      FollyFields()._holder = holder.._start(debug: debug);

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
}

///
///
///
abstract class AbstractConfig implements _InternalConfig {
  bool _started = false;
  bool _debug = false;
  bool _online = false;
  RunningPlatform _platform = RunningPlatform.UNKNOWN;

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
  bool get isWeb => _platform == RunningPlatform.WEB;

  ///
  ///
  ///
  @override
  bool get isMobile =>
      _platform == RunningPlatform.ANDROID || _platform == RunningPlatform.IOS;

  ///
  ///
  ///
  @override
  String get platform => _platform.name;

  ///
  ///
  ///
  void _start({bool debug = false}) async {
    if (_started) {
      // ignore: avoid_print
      if (debug) print('Folly Fields already started, ignoring...');
    } else {
      _started = true;
      // ignore: avoid_print
      if (debug) print('Folly Fields Started.');
      _debug = debug;

      if (kIsWeb) {
        _platform = RunningPlatform.WEB;
      } else if (Platform.isAndroid) {
        _platform = RunningPlatform.ANDROID;
      } else if (Platform.isIOS) {
        _platform = RunningPlatform.IOS;
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
