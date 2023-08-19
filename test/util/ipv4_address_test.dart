import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/ipv4_address.dart';

///
///
///
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

  group('IPv4 Creating from String Level 1', () {
    for (MapEntry<dynamic, bool> oc1 in base.entries) {
      test(
        'Testing "${oc1.key}" for "false"',
        () => expect(
          () => Ipv4Address.fromString('${oc1.key}'),
          invalidIpAddress,
        ),
      );
    }
  });

  group('IPv4 Creating from String Level 2', () {
    for (MapEntry<dynamic, bool> oc1 in base.entries) {
      for (MapEntry<dynamic, bool> oc2 in base.entries) {
        String key = '${oc1.key}.${oc2.key}';

        test(
          'Testing "$key" for "false"',
          () => expect(
            () => Ipv4Address.fromString(key),
            invalidIpAddress,
          ),
        );
      }
    }
  });

  group('IPv4 Creating from List Level 2', () {
    for (MapEntry<dynamic, bool> oc1 in base.entries) {
      for (MapEntry<dynamic, bool> oc2 in base.entries) {
        List<dynamic> list = <dynamic>[oc1.key, oc2.key];

        test(
          'Testing "$list" for "false"',
          () => expect(
            () => Ipv4Address.fromList(list),
            invalidIpAddress,
          ),
        );
      }
    }
  });

  group('IPv4 Creating from String Level 3', () {
    for (MapEntry<dynamic, bool> oc1 in base.entries) {
      for (MapEntry<dynamic, bool> oc2 in base.entries) {
        for (MapEntry<dynamic, bool> oc3 in base.entries) {
          if (oc1.key == oc2.key || oc1.key == oc3.key || oc2.key == oc3.key) {
            continue;
          }

          String key = '${oc1.key}.${oc2.key}.${oc3.key}';

          test(
            'Testing "$key" for "false"',
            () => expect(
              () => Ipv4Address.fromString(key),
              invalidIpAddress,
            ),
          );
        }
      }
    }
  });

  group(
    'IPv4 Creating from String Level 4',
    () {
      for (MapEntry<dynamic, bool> oc1 in base.entries) {
        for (MapEntry<dynamic, bool> oc2 in base.entries) {
          for (MapEntry<dynamic, bool> oc3 in base.entries) {
            for (MapEntry<dynamic, bool> oc4 in base.entries) {
              bool value = oc1.value && oc2.value && oc3.value && oc4.value;

              if (!value &&
                  (oc1.key == oc2.key ||
                      oc1.key == oc3.key ||
                      oc1.key == oc4.key ||
                      oc2.key == oc3.key ||
                      oc2.key == oc4.key ||
                      oc3.key == oc4.key)) {
                continue;
              }

              String key = '${oc1.key}.${oc2.key}.${oc3.key}.${oc4.key}';

              test(
                'Testing "$key" for $value',
                () => value
                    ? expect(
                        Ipv4Address.fromString(key),
                        isA<Ipv4Address>().having(
                          (Ipv4Address ip) => ip.toString(),
                          'Test',
                          key,
                        ),
                      )
                    : expect(
                        () => Ipv4Address.fromString(key),
                        invalidIpAddress,
                      ),
              );
            }
          }
        }
      }
    },
  );

  group(
    'IPv4 Creating from List Level 4',
    () {
      const String separator = '-';
      for (MapEntry<dynamic, bool> oc1 in base.entries) {
        for (MapEntry<dynamic, bool> oc2 in base.entries) {
          for (MapEntry<dynamic, bool> oc3 in base.entries) {
            for (MapEntry<dynamic, bool> oc4 in base.entries) {
              bool value = oc1.value && oc2.value && oc3.value && oc4.value;

              if (!value &&
                  (oc1.key == oc2.key ||
                      oc1.key == oc3.key ||
                      oc1.key == oc4.key ||
                      oc2.key == oc3.key ||
                      oc2.key == oc4.key ||
                      oc3.key == oc4.key)) {
                continue;
              }

              List<dynamic> list = <dynamic>[
                oc1.key,
                oc2.key,
                oc3.key,
                oc4.key,
              ];

              test(
                'Testing "$list" for $value',
                () => value
                    ? expect(
                        Ipv4Address.fromList(list, separator: separator),
                        isA<Ipv4Address>().having(
                          (Ipv4Address ip) => ip.toString(separator: separator),
                          'Test',
                          list.join(separator),
                        ),
                      )
                    : expect(
                        () => Ipv4Address.fromList(list, separator: separator),
                        invalidIpAddress,
                      ),
              );
            }
          }
        }
      }
    },
  );

  group(
    'IPv4 hashCode',
    () {
      for (MapEntry<dynamic, bool> oc1 in base.entries) {
        for (MapEntry<dynamic, bool> oc2 in base.entries) {
          for (MapEntry<dynamic, bool> oc3 in base.entries) {
            for (MapEntry<dynamic, bool> oc4 in base.entries) {
              if (oc1.value && oc2.value && oc3.value && oc4.value) {
                String key = '${oc1.key}.${oc2.key}.${oc3.key}.${oc4.key}';

                Ipv4Address ipv4 = Ipv4Address.fromString(key);

                test(
                  'Testing hashCode for $key',
                  () => expect(ipv4.hashCode, ipv4.integer),
                );
              }
            }
          }
        }
      }
    },
  );

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
      () => expect(
        () => Ipv4Address.fromString('0.0.0.0') - 1,
        invalidIpAddress,
      ),
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
