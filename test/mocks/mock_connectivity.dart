// ignore_for_file: avoid-top-level-members-in-tests

import 'package:connectivity_plus/connectivity_plus.dart';

///
///
///
class MockConnectivity implements Connectivity {
  ConnectivityResult defaultResult;

  ///
  ///
  ///
  MockConnectivity({this.defaultResult = ConnectivityResult.ethernet});

  ///
  ///
  ///
  @override
  Future<ConnectivityResult> checkConnectivity() async => defaultResult;

  ///
  ///
  ///
  @override
  Stream<ConnectivityResult> get onConnectivityChanged =>
      Stream<ConnectivityResult>.fromIterable(
        <ConnectivityResult>{defaultResult},
      );
}
