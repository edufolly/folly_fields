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
  linux,
  windows,
  macos,
  fuchsia,
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
typedef FollyDateParse = int? Function(dynamic value);

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
  bool get isNotWeb;

  ///
  ///
  ///
  bool get isMobile;

  ///
  ///
  ///
  bool get isNotMobile;

  ///
  ///
  ///
  bool get isDesktop;

  ///
  ///
  ///
  bool get isNotDesktop;

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
  FollyDateParse? get dateParseUpdate;

  ///
  ///
  ///
  FollyDateParse? get dateParseDelete;

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
    List<double> responsiveSizes = const <double>[540, 720, 960, 1140],
    FollyDateParse? dateParseUpdate,
    FollyDateParse? dateParseDelete,
    Connectivity? connectivity,
  }) =>
      FollyFields()._holder = holder
        .._start(
          modelIdKey: modelIdKey,
          modelUpdatedAtKey: modelUpdatedAtKey,
          modelDeletedAtKey: modelDeletedAtKey,
          dateParseUpdate: dateParseUpdate,
          dateParseDelete: dateParseDelete,
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
  bool get isNotWeb => _holder!.isNotWeb;

  ///
  ///
  ///
  @override
  bool get isMobile => _holder!.isMobile;

  ///
  ///
  ///
  @override
  bool get isNotMobile => _holder!.isNotMobile;

  ///
  ///
  ///
  @override
  bool get isDesktop => _holder!.isDesktop;

  ///
  ///
  ///
  @override
  bool get isNotDesktop => _holder!.isNotDesktop;

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
  FollyDateParse? get dateParseUpdate => _holder!.dateParseUpdate;

  ///
  ///
  ///
  @override
  FollyDateParse? get dateParseDelete => _holder!.dateParseDelete;

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
  FollyDateParse? _dateParseUpdate;
  FollyDateParse? _dateParseDelete;
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
  bool get isNotWeb => !isWeb;

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
  bool get isNotMobile => !isMobile;

  ///
  ///
  ///
  @override
  bool get isDesktop => !isWeb && !isMobile;

  ///
  ///
  ///
  @override
  bool get isNotDesktop => !isDesktop;

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
  FollyDateParse? get dateParseUpdate => _dateParseUpdate;

  ///
  ///
  ///
  @override
  FollyDateParse? get dateParseDelete => _dateParseDelete;

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
    required List<double> responsiveSizes,
    FollyDateParse? dateParseUpdate,
    FollyDateParse? dateParseDelete,
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

      _dateParseUpdate = dateParseUpdate;
      _dateParseDelete = dateParseDelete;

      _responsiveSizes = responsiveSizes;

      if (kIsWeb) {
        _platform = RunningPlatform.web;
      } else if (Platform.isAndroid) {
        _platform = RunningPlatform.android;
      } else if (Platform.isIOS) {
        _platform = RunningPlatform.ios;
      } else if (Platform.isLinux) {
        _platform = RunningPlatform.linux;
      } else if (Platform.isWindows) {
        _platform = RunningPlatform.windows;
      } else if (Platform.isMacOS) {
        _platform = RunningPlatform.macos;
      } else if (Platform.isFuchsia) {
        _platform = RunningPlatform.fuchsia;
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
