import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/util/folly_validators.dart';

///
///
///
void main() {
  final List<Decimal> decimalTests = <Decimal>[
    Decimal(precision: 2, doubleValue: -1),
    Decimal(precision: 2, doubleValue: -0.01),
    Decimal(precision: 2, doubleValue: 0),
    Decimal(precision: 2, doubleValue: 0.01),
    Decimal(precision: 2, doubleValue: 1),
  ];

  ///
  ///
  ///

  group(
    'Validators decimalGTEZero',
    () {
      final List<bool> decimalResults = <bool>[false, false, true, true, true];

      final Map<Decimal, bool> decimalDomain =
          Map<Decimal, bool>.fromIterables(decimalTests, decimalResults);

      for (final MapEntry<Decimal, bool> input in decimalDomain.entries) {
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
  group(
    'Validators decimalGTZero',
    () {
      final List<bool> decimalResults = <bool>[false, false, false, true, true];

      final Map<Decimal, bool> decimalDomain =
          Map<Decimal, bool>.fromIterables(decimalTests, decimalResults);

      for (final MapEntry<Decimal, bool> input in decimalDomain.entries) {
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

  group(
    'Validators decimalLTZero',
    () {
      final List<bool> decimalResults = <bool>[true, true, false, false, false];

      final Map<Decimal, bool> decimalDomain =
          Map<Decimal, bool>.fromIterables(decimalTests, decimalResults);

      for (final MapEntry<Decimal, bool> input in decimalDomain.entries) {
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
  group(
    'Validators decimalLTEZero',
    () {
      final List<bool> decimalResults = <bool>[true, true, true, false, false];

      final Map<Decimal, bool> decimalDomain =
          Map<Decimal, bool>.fromIterables(decimalTests, decimalResults);

      for (final MapEntry<Decimal, bool> input in decimalDomain.entries) {
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

  group(
    'Validators stringNotEmpty',
    () {
      final Map<String?, bool> stringDomain = <String?, bool>{
        null: false,
        '': false,
        ' ': true,
        '\t': true,
        '\n': true,
        'a': true,
        'A': true,
      };

      for (final MapEntry<String?, bool> input in stringDomain.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(
            FollyValidators.stringNotEmpty(input.key) == null,
            input.value,
          ),
        );
      }
    },
  );

  ///
  ///
  ///

  group(
    'Validators stringNotBlank',
    () {
      final Map<String?, bool> stringDomain = <String?, bool>{
        null: false,
        '': false,
        ' ': false,
        '\t': false,
        '\n': false,
        '\t\n': false,
        '\n\t': false,
        ' \t \n ': false,
        'a': true,
        ' a': true,
        ' a ': true,
        'a ': true,
        'A': true,
        ' A': true,
        ' A ': true,
        'A ': true,
      };

      for (final MapEntry<String?, bool> input in stringDomain.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(
            FollyValidators.stringNotBlank(input.key) == null,
            input.value,
          ),
        );
      }
    },
  );

  ///
  ///
  ///
  group(
    'Validators stringNullNotEmpty',
    () {
      final Map<String?, bool> stringDomain = <String?, bool>{
        null: true,
        '': false,
        ' ': true,
        '\t': true,
        '\n': true,
        'a': true,
        'A': true,
      };

      for (final MapEntry<String?, bool> input in stringDomain.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(
            FollyValidators.stringNullNotEmpty(input.key) == null,
            input.value,
          ),
        );
      }
    },
  );

  ///
  ///
  ///

  group(
    'Validators stringNullNotBlank',
    () {
      final Map<String?, bool> stringDomain = <String?, bool>{
        null: true,
        '': false,
        ' ': false,
        '\t': false,
        '\n': false,
        '\t\n': false,
        '\n\t': false,
        ' \t \n ': false,
        'a': true,
        ' a': true,
        ' a ': true,
        'a ': true,
        'A': true,
        ' A': true,
        ' A ': true,
        'A ': true,
      };

      for (final MapEntry<String?, bool> input in stringDomain.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(
            FollyValidators.stringNullNotBlank(input.key) == null,
            input.value,
          ),
        );
      }
    },
  );

  ///
  ///
  ///
  group(
    'Validators notNull',
    () {
      final Map<dynamic, bool> domain = <dynamic, bool>{
        null: false,
        '': true,
        ' ': true,
        '\t': true,
        '\n': true,
        '\t\n': true,
        '\n\t': true,
        'a': true,
        'A': true,
        1: true,
        0: true,
        true: true,
        false: true,
        <dynamic>[null]: true,
        <dynamic, int>{null: 1}: true,
        <dynamic>{null}: true,
        <int>[]: true,
        <int, int>{}: true,
        <int>{}: true,
        <int>[1]: true,
        <int, int>{1: 1}: true,
        <int>{1}: true,
        <String>['']: true,
        <String, int>{'': 1}: true,
        <String>{''}: true,
        <String>[' ']: true,
        <String, int>{' ': 1}: true,
        <String>{' '}: true,
        <String>['\t']: true,
        <String, int>{'\t': 1}: true,
        <String>{'\t'}: true,
        <String>['\n']: true,
        <String, int>{'\n': 1}: true,
        <String>{'\n'}: true,
        <String>['\n\t']: true,
        <String, int>{'\n\t': 1}: true,
        <String>{'\n\t'}: true,
        <String>['\t\n']: true,
        <String, int>{'\t\n': 1}: true,
        <String>{'\t\n'}: true,
        <String>['a']: true,
        <String, int>{'a': 1}: true,
        <String>{'a'}: true,
        <bool>[true]: true,
        <bool, int>{true: 1}: true,
        <bool>{true}: true,
        <bool>[false]: true,
        <bool, int>{false: 1}: true,
        <bool>{false}: true,
      };

      for (final MapEntry<dynamic, bool> input in domain.entries) {
        test(
          'Testing: ${(input.key as Object?).runtimeType} ${input.key}',
          () => expect(
            FollyValidators.notNull(input.key) == null,
            input.value,
          ),
        );
      }
    },
  );

  ///
  ///
  ///
  group(
    'Validators notEmpty',
    () {
      final Map<dynamic, bool> domain = <dynamic, bool>{
        null: false,
        '': false,
        ' ': true,
        '\t': true,
        '\n': true,
        '\t\n': true,
        '\n\t': true,
        'a': true,
        'A': true,
        1: true,
        0: true,
        true: true,
        false: true,
        <int>[]: false,
        <int, int>{}: false,
        <int>{}: false,
        <dynamic>[null]: true,
        <dynamic, int>{null: 1}: true,
        <dynamic>{null}: true,
        <int>[1]: true,
        <int, int>{1: 1}: true,
        <int>{1}: true,
        <String>['']: true,
        <String, int>{'': 1}: true,
        <String>{''}: true,
        <String>[' ']: true,
        <String, int>{' ': 1}: true,
        <String>{' '}: true,
        <String>['\t']: true,
        <String, int>{'\t': 1}: true,
        <String>{'\t'}: true,
        <String>['\n']: true,
        <String, int>{'\n': 1}: true,
        <String>{'\n'}: true,
        <String>['\n\t']: true,
        <String, int>{'\n\t': 1}: true,
        <String>{'\n\t'}: true,
        <String>['\t\n']: true,
        <String, int>{'\t\n': 1}: true,
        <String>{'\t\n'}: true,
        <String>['a']: true,
        <String, int>{'a': 1}: true,
        <String>{'a'}: true,
        <bool>[true]: true,
        <bool, int>{true: 1}: true,
        <bool>{true}: true,
        <bool>[false]: true,
        <bool, int>{false: 1}: true,
        <bool>{false}: true,
      };

      for (final MapEntry<dynamic, bool> input in domain.entries) {
        test(
          'Testing: ${(input.key as Object?).runtimeType} ${input.key}',
          () => expect(
            FollyValidators.notEmpty(input.key) == null,
            input.value,
          ),
        );
      }
    },
  );

  ///
  ///
  ///
  group(
    'Validators notBlank',
        () {
      final Map<dynamic, bool> domain = <dynamic, bool>{
        null: false,
        '': false,
        ' ': false,
        '\t': false,
        '\n': false,
        '\t\n': false,
        '\n\t': false,
        'a': true,
        'A': true,
        1: true,
        0: true,
        true: true,
        false: true,
        <int>[]: false,
        <int, int>{}: false,
        <int>{}: false,
        <dynamic>[null]: false,
        <dynamic, int>{null: 1}: false,
        <dynamic>{null}: false,
        <int>[1]: true,
        <int, int>{1: 1}: true,
        <int>{1}: true,
        <String>['']: false,
        <String, int>{'': 1}: false,
        <String>{''}: false,
        <String>[' ']: false,
        <String, int>{' ': 1}: false,
        <String>{' '}: false,
        <String>['\t']: false,
        <String, int>{'\t': 1}: false,
        <String>{'\t'}: false,
        <String>['\n']: false,
        <String, int>{'\n': 1}: false,
        <String>{'\n'}: false,
        <String>['\n\t']: false,
        <String, int>{'\n\t': 1}: false,
        <String>{'\n\t'}: false,
        <String>['\t\n']: false,
        <String, int>{'\t\n': 1}: false,
        <String>{'\t\n'}: false,
        <String>['a']: true,
        <String, int>{'a': 1}: true,
        <String>{'a'}: true,
        <bool>[true]: true,
        <bool, int>{true: 1}: true,
        <bool>{true}: true,
        <bool>[false]: true,
        <bool, int>{false: 1}: true,
        <bool>{false}: true,
      };

      for (final MapEntry<dynamic, bool> input in domain.entries) {
        test(
          'Testing: ${(input.key as Object?).runtimeType} ${input.key}',
              () => expect(
            FollyValidators.notBlank(input.key) == null,
            input.value,
          ),
        );
      }
    },
  );

  ///
  ///
  ///
  group(
    'Validators intGTEZero',
    () {
      final Map<int?, bool> intDomain = <int?, bool>{
        null: false,
        -2: false,
        -1: false,
        0: true,
        1: true,
        2: true,
      };

      for (final MapEntry<int?, bool> input in intDomain.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(
            FollyValidators.intGTEZero(input.key) == null,
            input.value,
          ),
        );
      }
    },
  );

  ///
  ///
  ///
  group(
    'Validators intGTZero',
    () {
      final Map<int?, bool> intDomain = <int?, bool>{
        null: false,
        -2: false,
        -1: false,
        0: false,
        1: true,
        2: true,
      };

      for (final MapEntry<int?, bool> input in intDomain.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(
            FollyValidators.intGTZero(input.key) == null,
            input.value,
          ),
        );
      }
    },
  );

  ///
  ///
  ///
  group(
    'Validators intLTZero',
    () {
      final Map<int?, bool> intDomain = <int?, bool>{
        null: false,
        -2: true,
        -1: true,
        0: false,
        1: false,
        2: false,
      };

      for (final MapEntry<int?, bool> input in intDomain.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(
            FollyValidators.intLTZero(input.key) == null,
            input.value,
          ),
        );
      }
    },
  );

  ///
  ///
  ///
  group(
    'Validators intLTEZero',
    () {
      final Map<int?, bool> intDomain = <int?, bool>{
        null: false,
        -2: true,
        -1: true,
        0: true,
        1: false,
        2: false,
      };

      for (final MapEntry<int?, bool> input in intDomain.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(
            FollyValidators.intLTEZero(input.key) == null,
            input.value,
          ),
        );
      }
    },
  );

  ///
  ///
  ///
  group(
    'Validators intNullGTEZero',
    () {
      final Map<int?, bool> intDomain = <int?, bool>{
        null: true,
        -2: false,
        -1: false,
        0: true,
        1: true,
        2: true,
      };

      for (final MapEntry<int?, bool> input in intDomain.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(
            FollyValidators.intNullGTEZero(input.key) == null,
            input.value,
          ),
        );
      }
    },
  );

  ///
  ///
  ///
  group(
    'Validators intNullGTZero',
    () {
      final Map<int?, bool> intDomain = <int?, bool>{
        null: true,
        -2: false,
        -1: false,
        0: false,
        1: true,
        2: true,
      };

      for (final MapEntry<int?, bool> input in intDomain.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(
            FollyValidators.intNullGTZero(input.key) == null,
            input.value,
          ),
        );
      }
    },
  );

  ///
  ///
  ///
  group(
    'Validators intNullLTZero',
    () {
      final Map<int?, bool> intDomain = <int?, bool>{
        null: true,
        -2: true,
        -1: true,
        0: false,
        1: false,
        2: false,
      };

      for (final MapEntry<int?, bool> input in intDomain.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(
            FollyValidators.intNullLTZero(input.key) == null,
            input.value,
          ),
        );
      }
    },
  );

  ///
  ///
  ///
  group(
    'Validators intNullLTEZero',
    () {
      final Map<int?, bool> intDomain = <int?, bool>{
        null: true,
        -2: true,
        -1: true,
        0: true,
        1: false,
        2: false,
      };

      for (final MapEntry<int?, bool> input in intDomain.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(
            FollyValidators.intNullLTEZero(input.key) == null,
            input.value,
          ),
        );
      }
    },
  );
}
