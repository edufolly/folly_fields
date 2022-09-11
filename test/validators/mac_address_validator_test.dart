import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/mac_address_validator.dart';

///
///
///
void main() {
  MacAddressValidator validator = MacAddressValidator();

  Map<String, bool> isValidTests = <String, bool>{
    '': false,
    '1': false,
    'aa:bb:cc:dd:ee:ff': false,
    'AABBCCDDEEFF': false,
    'AA:BB:CC:DD:EE:FF': true,
    'aa:BB:CC:DD:EE:FF': false,
    'AA:BB:CC:DD:EE:FZ': false,
    'ZA:BB:CC:DD:EE:FF': false,
    'GH:IJ:KL:MN:OP:QR': false,
    '01:23:45:67:89:AB': true,
    '00:00:00:00:00:00': true,
    'G0:00:00:00:00:00': false,
    '!0:00:00:00:00:00': false,
    '.0:00:00:00:00:00': false,
    '_0:00:00:00:00:00': false,
  };

  for (int i = 0; i < 100; i++) {
    isValidTests[MacAddressValidator.generate()] = true;
  }

  group(
    'MacAddressValidator isValid',
    () {
      for (MapEntry<String, bool> input in isValidTests.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(validator.isValid(input.key), input.value),
        );
      }
    },
  );

  Map<String, String> formatTests = <String, String>{
    '': '',
    ' ': '',
    '  ': '',
    '!': '',
    '@': '',
    '_': '',
    '?': '',
    'a': '',
    '1': '1',
    '12': '12',
    '12:3': '123',
    '12:34': '1234',
    '12:34:5': '12345',
    '12:34:56': '123456',
    '12:34:56:7': '1234567',
    'aa:bb:cc:dd:ee:ff': '',
    'AABBCCDDEEFF': 'AA:BB:CC:DD:EE:FF',
    'AA:BB:CC:DD:EE:FF': 'AA:BB:CC:DD:EE:FF',
    'AA:BB:CC:DD:EE:FZ': 'AABBCCDDEEF',
    'ZA:BB:CC:DD:EE:FF': 'ABBCCDDEEFF',
    'GH:IJ:KL:MN:OP:QR': '',
    '0123456789AB': '01:23:45:67:89:AB',
    '01:23:45:67:89:AB': '01:23:45:67:89:AB',
  };

  group(
    'MacAddressValidator format',
    () {
      for (MapEntry<String, String> input in formatTests.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(validator.format(input.key), input.value),
        );
      }
    },
  );
}
