import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/ipv4_address.dart';

import '../cartesian_product_helper.dart';

void main() {
  Matcher invalidIpAddress = throwsA(
    predicate(
      (dynamic e) => e is ArgumentError && e.message == 'invalidIpAddress',
    ),
  );

  Map<dynamic, bool> base = <dynamic, bool>{
    null: false,
    '': false,
    ' ': false,
    '.': false,
    'a': false,
    // 'A': false,
    -1: false,
    0: true,
    // 1: true,
    // 254: true,
    255: true,
    256: false,
    '10': true,
    // '100': true,
    // '192': true,
    // '232': true,
    '1000': false,
  };

  List<Map<dynamic, bool>> domain = <Map<dynamic, bool>>[base];

  group('IPv4 Creating from String Level 1', () {
    cartesianProductGenerate(domain, (
      List<dynamic> data, {
      required bool result,
    }) {
      test(
        'Testing "${data.first}" for "false"',
        () => expect(
          () => Ipv4Address.fromString('${data.first}'),
          invalidIpAddress,
        ),
      );
    });
  });

  domain = <Map<dynamic, bool>>[...domain, base];

  group('IPv4 Creating from String Level 2', () {
    cartesianProductGenerate(domain, (
      List<dynamic> data, {
      required bool result,
    }) {
      String key = data.join('.');
      test(
        'Testing "$key" for "false"',
        () => expect(() => Ipv4Address.fromString(key), invalidIpAddress),
      );
    });
  });

  group('IPv4 Creating from List Level 2', () {
    cartesianProductGenerate(domain, (
      List<dynamic> data, {
      required bool result,
    }) {
      test(
        'Testing "$data" for "false"',
        () => expect(() => Ipv4Address.fromList(data), invalidIpAddress),
      );
    });
  });

  domain = <Map<dynamic, bool>>[...domain, base];

  group('IPv4 Creating from String Level 3', () {
    cartesianProductGenerate(domain, (
      List<dynamic> data, {
      required bool result,
    }) {
      if (data.length == data.toSet().length) {
        String key = data.join('.');

        test(
          'Testing "$key" for "false"',
          () => expect(() => Ipv4Address.fromString(key), invalidIpAddress),
        );
      }
    });
  });

  group('IPv4 Creating from List Level 3', () {
    cartesianProductGenerate(domain, (
      List<dynamic> data, {
      required bool result,
    }) {
      if (data.length == data.toSet().length) {
        test(
          'Testing "$data" for "false"',
          () => expect(() => Ipv4Address.fromList(data), invalidIpAddress),
        );
      }
    });
  });

  domain = <Map<dynamic, bool>>[...domain, base];

  group('IPv4 Creating from String Level 4', () {
    cartesianProductGenerate(domain, (
      List<dynamic> data, {
      required bool result,
    }) {
      if (result || data.length == data.toSet().length) {
        String key = data.join('.');

        test(
          'Testing "$key" for $result',
          () => result
              ? expect(
                  Ipv4Address.fromString(key),
                  isA<Ipv4Address>().having(
                    (Ipv4Address ip) => ip.toString(),
                    'Test',
                    key,
                  ),
                )
              : expect(() => Ipv4Address.fromString(key), invalidIpAddress),
        );
      }
    });
  });

  group('IPv4 Creating from List Level 4', () {
    const String separator = '-';

    cartesianProductGenerate(domain, (
      List<dynamic> data, {
      required bool result,
    }) {
      if (result || data.length == data.toSet().length) {
        test(
          'Testing "$data" for $result',
          () => result
              ? expect(
                  Ipv4Address.fromList(data, separator: separator),
                  isA<Ipv4Address>().having(
                    (Ipv4Address ip) => ip.toString(separator: separator),
                    'Test',
                    data.join(separator),
                  ),
                )
              : expect(
                  () => Ipv4Address.fromList(data, separator: separator),
                  invalidIpAddress,
                ),
        );
      }
    });
  });

  group('IPv4 hashCode', () {
    cartesianProductGenerate(domain, (
      List<dynamic> data, {
      required bool result,
    }) {
      if (result) {
        String key = data.join('.');
        Ipv4Address ipv4 = Ipv4Address.fromString(key);
        test(
          'Testing hashCode for $key',
          () => expect(ipv4.hashCode, ipv4.integer),
        );
      }
    });
  });

  group('IPv4 Operations', () {
    test(
      '0.0.0.0 + 1',
      () => expect(
        Ipv4Address.fromString('0.0.0.0') + 1,
        Ipv4Address.fromString('0.0.0.1'),
      ),
    );

    test(
      '0.0.0.255 + 1',
      () => expect(
        Ipv4Address.fromString('0.0.0.255') + 1,
        Ipv4Address.fromString('0.0.1.0'),
      ),
    );

    test(
      '255.255.255.255 + 1',
      () => expect(
        () => Ipv4Address.fromString('255.255.255.255') + 1,
        invalidIpAddress,
      ),
    );

    test(
      '0.0.0.0 - 1',
      () =>
          expect(() => Ipv4Address.fromString('0.0.0.0') - 1, invalidIpAddress),
    );

    test(
      '0.0.1.0 - 1',
      () => expect(
        Ipv4Address.fromString('0.0.1.0') - 1,
        Ipv4Address.fromString('0.0.0.255'),
      ),
    );

    test(
      '255.255.255.255 - 1',
      () => expect(
        Ipv4Address.fromString('255.255.255.255') - 1,
        Ipv4Address.fromString('255.255.255.254'),
      ),
    );

    test(
      '255.255.255.255 > 255.255.255.254',
      () => expect(
        Ipv4Address.fromString('255.255.255.255') >
            Ipv4Address.fromString('255.255.255.254'),
        true,
      ),
    );

    test(
      '255.255.255.254 > 255.255.255.255',
      () => expect(
        Ipv4Address.fromString('255.255.255.254') >
            Ipv4Address.fromString('255.255.255.255'),
        false,
      ),
    );

    test(
      '255.255.255.255 >= 255.255.255.254',
      () => expect(
        Ipv4Address.fromString('255.255.255.255') >=
            Ipv4Address.fromString('255.255.255.254'),
        true,
      ),
    );

    test(
      '255.255.255.255 >= 255.255.255.255',
      () => expect(
        Ipv4Address.fromString('255.255.255.255') >=
            Ipv4Address.fromString('255.255.255.255'),
        true,
      ),
    );

    test(
      '255.255.255.254 >= 255.255.255.255',
      () => expect(
        Ipv4Address.fromString('255.255.255.254') >=
            Ipv4Address.fromString('255.255.255.255'),
        false,
      ),
    );

    test(
      '255.255.255.255 < 255.255.255.254',
      () => expect(
        Ipv4Address.fromString('255.255.255.255') <
            Ipv4Address.fromString('255.255.255.254'),
        false,
      ),
    );

    test(
      '255.255.255.254 < 255.255.255.255',
      () => expect(
        Ipv4Address.fromString('255.255.255.254') <
            Ipv4Address.fromString('255.255.255.255'),
        true,
      ),
    );

    test(
      '255.255.255.255 <= 255.255.255.254',
      () => expect(
        Ipv4Address.fromString('255.255.255.255') <=
            Ipv4Address.fromString('255.255.255.254'),
        false,
      ),
    );

    test(
      '255.255.255.255 <= 255.255.255.255',
      () => expect(
        Ipv4Address.fromString('255.255.255.255') <=
            Ipv4Address.fromString('255.255.255.255'),
        true,
      ),
    );

    test(
      '255.255.255.254 <= 255.255.255.255',
      () => expect(
        Ipv4Address.fromString('255.255.255.254') <=
            Ipv4Address.fromString('255.255.255.255'),
        true,
      ),
    );
  });
}
