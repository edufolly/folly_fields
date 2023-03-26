import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/util/folly_validators.dart';

///
///
///
void main() {
  List<Decimal> decimalTests = <Decimal>[
    Decimal(precision: 2, doubleValue: -1),
    Decimal(precision: 2, doubleValue: -0.01),
    Decimal(precision: 2, doubleValue: 0),
    Decimal(precision: 2, doubleValue: 0.01),
    Decimal(precision: 2, doubleValue: 1),
  ];

  ///
  ///
  ///
  List<bool> decimalGTEZeroResults = <bool>[
    false,
    false,
    true,
    true,
    true,
  ];

  Map<Decimal, bool> decimalGTEZeroTests =
      Map<Decimal, bool>.fromIterables(decimalTests, decimalGTEZeroResults);

  group(
    'Validators decimalGTEZero',
    () {
      for (final MapEntry<Decimal, bool> input in decimalGTEZeroTests.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(
            FollyValidators.decimalGTEZero(input.key) == null,
            input.value,
          ),
        );
      }
    },
  );

  ///
  ///
  ///
  List<bool> decimalGTZeroResults = <bool>[
    false,
    false,
    false,
    true,
    true,
  ];

  Map<Decimal, bool> decimalGTZeroTests =
      Map<Decimal, bool>.fromIterables(decimalTests, decimalGTZeroResults);

  group(
    'Validators decimalGTZero',
    () {
      for (final MapEntry<Decimal, bool> input in decimalGTZeroTests.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(
            FollyValidators.decimalGTZero(input.key) == null,
            input.value,
          ),
        );
      }
    },
  );

  ///
  ///
  ///
  List<bool> decimalLTZeroResults = <bool>[
    true,
    true,
    false,
    false,
    false,
  ];

  Map<Decimal, bool> decimalLTZeroTests =
      Map<Decimal, bool>.fromIterables(decimalTests, decimalLTZeroResults);

  group(
    'Validators decimalLTZero',
    () {
      for (final MapEntry<Decimal, bool> input in decimalLTZeroTests.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(
            FollyValidators.decimalLTZero(input.key) == null,
            input.value,
          ),
        );
      }
    },
  );

  ///
  ///
  ///
  List<bool> decimalLTEZeroResults = <bool>[
    true,
    true,
    true,
    false,
    false,
  ];

  Map<Decimal, bool> decimalLTEZeroTests =
      Map<Decimal, bool>.fromIterables(decimalTests, decimalLTEZeroResults);

  group(
    'Validators decimalLTEZero',
    () {
      for (final MapEntry<Decimal, bool> input in decimalLTEZeroTests.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(
            FollyValidators.decimalLTEZero(input.key) == null,
            input.value,
          ),
        );
      }
    },
  );

  ///
  ///
  ///
  // TODO(anyone): stringNotEmpty

  ///
  ///
  ///
  // TODO(anyone): stringNullNotEmpty

  ///
  ///
  ///
  // TODO(anyone): notNull

  ///
  ///
  ///
  // TODO(anyone): intGTEZero

  ///
  ///
  ///
  // TODO(anyone): intGTZero

  ///
  ///
  ///
  // TODO(anyone): intLTZero

  ///
  ///
  ///
  // TODO(anyone): intLTEZero

  ///
  ///
  ///
  // TODO(anyone): intNullGTEZero

  ///
  ///
  ///
  // TODO(anyone): intNullGTZero

  ///
  ///
  ///
  // TODO(anyone): intNullLTZero

  ///
  ///
  ///
  // TODO(anyone): intNullLTEZero
}
