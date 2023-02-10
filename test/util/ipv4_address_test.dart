import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/ipv4_address.dart';

///
///
///
void main() {
  Map<String, bool> tests = <String, bool>{
    '': false,
    ' ': false,
    'a': false,
    'a.': false,
    'a.a': false,
    'a.a.': false,
    'a.a.a': false,
    'a.a.a.': false,
    '.a': false,
    '.a.': false,
    '.a.a': false,
    '.a.a.': false,
    '.a.a.a': false,
    '.a.a.a.': false,
    'a.a.a.a': false,
    'A': false,
    '-1': false,
    '-1.': false,
    '-1.-1': false,
    '-1.-1.': false,
    '-1.-1.-1': false,
    '-1.-1.-1.': false,
    '.-1': false,
    '.-1.': false,
    '.-1.-1': false,
    '.-1.-1.': false,
    '.-1.-1.-1': false,
    '.-1.-1.-1.': false,
    '-1.-1.-1.-1': false,
    '256': false,
    '256.': false,
    '256.256': false,
    '256.256.': false,
    '256.256.256': false,
    '256.256.256.': false,
    '.256': false,
    '.256.': false,
    '.256.256': false,
    '.256.256.': false,
    '.256.256.256': false,
    '.256.256.256.': false,
    '256.256.256.256': false,
    '0': false,
    '0.': false,
    '0.0': false,
    '0.0.': false,
    '0.0.0': false,
    '0.0.0.': false,
    '.0': false,
    '.0.': false,
    '.0.0': false,
    '.0.0.': false,
    '.0.0.0': false,
    '.0.0.0.': false,
    '0.0.0.0': true,
    '255': false,
    '255.': false,
    '255.255': false,
    '255.255.': false,
    '255.255.255': false,
    '255.255.255.': false,
    '.255': false,
    '.255.': false,
    '.255.255': false,
    '.255.255.': false,
    '.255.255.255': false,
    '.255.255.255.': false,
    '255.255.255.255': true,
    '255.0.0.0': true,
    '255.255.0.0': true,
    '255.255.255.0': true,
    '0.255.255.255': true,
    '0.0.255.255': true,
    '0.0.0.255': true,
    '10.0.0.0': true,
    '10.255.255.255': true,
    '100.64.0.0': true,
    '100.127.255.255': true,
    '127.0.0.0': true,
    '127.255.255.255': true,
    '169.254.0.0': true,
    '169.254.255.255': true,
    '172.16.0.0': true,
    '172.31.255.255': true,
    '192.0.0.0': true,
    '192.0.0.255': true,
    '192.0.2.0': true,
    '192.0.2.255': true,
    '192.88.99.0': true,
    '192.88.99.255': true,
    '192.168.0.0': true,
    '192.168.255.255': true,
    '198.18.0.0': true,
    '198.19.255.255': true,
    '198.51.100.0': true,
    '198.51.100.255': true,
    '203.0.113.0': true,
    '203.0.113.255': true,
    '224.0.0.0': true,
    '239.255.255.255': true,
    '233.252.0.0': true,
    '233.252.0.255': true,
    '240.0.0.0': true,
    '255.255.255.254': true,
  };

  Matcher invalidIpAddress = throwsA(
    predicate(
      (dynamic e) => e is ArgumentError && e.message == 'invalidIpAddress',
    ),
  );

  group(
    'IPv4 creating test',
    () {
      for (final MapEntry<String, bool> entry in tests.entries) {
        test(
          'Testing "${entry.key}" for ${entry.value}',
          () => entry.value
              ? expect(
                  Ipv4Address.fromString(entry.key),
                  isA<Ipv4Address>().having(
                    (Ipv4Address ip) => ip.toString(),
                    'Test',
                    entry.key,
                  ),
                )
              : expect(
                  () => Ipv4Address.fromString(entry.key),
                  invalidIpAddress,
                ),
        );
      }
    },
  );

  group('IPv4 operations test', () {
    test(
      'Testing',
      () => expect(
        Ipv4Address.fromString('0.0.0.0') + 1,
        Ipv4Address.fromString('0.0.0.1'),
      ),
    );

    test(
      'Testing',
      () => expect(
        Ipv4Address.fromString('0.0.0.255') + 1,
        Ipv4Address.fromString('0.0.1.0'),
      ),
    );

    test(
      'Testing',
      () => expect(
        () => Ipv4Address.fromString('255.255.255.255') + 1,
        invalidIpAddress,
      ),
    );

    test(
      'Testing',
      () => expect(
        () => Ipv4Address.fromString('0.0.0.0') - 1,
        invalidIpAddress,
      ),
    );

    test(
      'Testing',
      () => expect(
        Ipv4Address.fromString('0.0.1.0') - 1,
        Ipv4Address.fromString('0.0.0.255'),
      ),
    );

    test(
      'Testing',
      () => expect(
        Ipv4Address.fromString('255.255.255.255') - 1,
        Ipv4Address.fromString('255.255.255.254'),
      ),
    );
  });
}
