import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/ipv4_validator.dart';

///
///
///
void main() {
  group(
    'IPv4Validator isValid',
    () {
      Map<String, bool> isValidTests = <String, bool>{
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

      Ipv4Validator validator = Ipv4Validator();

      for (MapEntry<String, bool> input in isValidTests.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(validator.isValid(input.key), input.value),
        );
      }
    },
  );

  group('IPv4Validator Coverage', () {
    Ipv4Validator validator = Ipv4Validator();

    test('format', () => expect(validator.format('127.0.0.1'), '127.0.0.1'));

    test('strip', () => expect(validator.strip('127.0.0.1'), '127.0.0.1'));

    test('keyboard', () => expect(validator.keyboard, isNotNull));
  });
}
