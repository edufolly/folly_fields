// ignore_for_file: avoid-top-level-members-in-tests

import 'package:connectivity_plus/connectivity_plus.dart';

///
///
///
class MockConnectivity implements Connectivity {
  List<ConnectivityResult> defaultResult;

  ///
  ///
  ///
  MockConnectivity({
    this.defaultResult = const <ConnectivityResult>[
      ConnectivityResult.mobile,
      ConnectivityResult.wifi,
    ],
  });

  ///
  ///
  ///
  @override
  Future<List<ConnectivityResult>> checkConnectivity() async => defaultResult;

  ///
  ///
  ///
  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      Stream<List<ConnectivityResult>>.fromIterable(
        <List<ConnectivityResult>>{defaultResult},
      );
}
