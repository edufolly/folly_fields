import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/util/folly_validators.dart';

void main() {
  List<Decimal> decimalTests = <Decimal>[
    Decimal(precision: 2, doubleValue: -1),
    Decimal(precision: 2, doubleValue: -0.01),
    Decimal(precision: 2, doubleValue: 0),
    Decimal(precision: 2, doubleValue: 0.01),
    Decimal(precision: 2, doubleValue: 1),
  ];

  group('Validators decimalGTEZero', () {
    List<bool> decimalResults = <bool>[false, false, true, true, true];

    Map<Decimal, bool> decimalDomain = Map<Decimal, bool>.fromIterables(
      decimalTests,
      decimalResults,
    );

    for (final MapEntry<Decimal, bool> e in decimalDomain.entries) {
      test(
        'Testing: ${e.key} => ${e.value}',
        () => expect(FollyValidators.decimalGTEZero(e.key) == null, e.value),
      );
    }
  });

  group('Validators decimalGTZero', () {
    List<bool> decimalResults = <bool>[false, false, false, true, true];

    Map<Decimal, bool> decimalDomain = Map<Decimal, bool>.fromIterables(
      decimalTests,
      decimalResults,
    );

    for (final MapEntry<Decimal, bool> e in decimalDomain.entries) {
      test(
        'Testing: ${e.key} => ${e.value}',
        () => expect(FollyValidators.decimalGTZero(e.key) == null, e.value),
      );
    }
  });

  group('Validators decimalLTZero', () {
    List<bool> decimalResults = <bool>[true, true, false, false, false];

    Map<Decimal, bool> decimalDomain = Map<Decimal, bool>.fromIterables(
      decimalTests,
      decimalResults,
    );

    for (final MapEntry<Decimal, bool> e in decimalDomain.entries) {
      test(
        'Testing: ${e.key} => ${e.value}',
        () => expect(FollyValidators.decimalLTZero(e.key) == null, e.value),
      );
    }
  });

  group('Validators decimalLTEZero', () {
    List<bool> decimalResults = <bool>[true, true, true, false, false];

    Map<Decimal, bool> decimalDomain = Map<Decimal, bool>.fromIterables(
      decimalTests,
      decimalResults,
    );

    for (final MapEntry<Decimal, bool> e in decimalDomain.entries) {
      test(
        'Testing: ${e.key} => ${e.value}',
        () => expect(FollyValidators.decimalLTEZero(e.key) == null, e.value),
      );
    }
  });

  group('Validators stringNotEmpty', () {
    Map<String?, bool> stringDomain = <String?, bool>{
      null: false,
      '': false,
      ' ': true,
      '\t': true,
      '\n': true,
      'a': true,
      'A': true,
    };

    for (final MapEntry<String?, bool> e in stringDomain.entries) {
      test(
        'Testing: ${e.key} => ${e.value}',
        () => expect(FollyValidators.stringNotEmpty(e.key) == null, e.value),
      );
    }
  });

  group('Validators stringNotBlank', () {
    Map<String?, bool> stringDomain = <String?, bool>{
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

    for (final MapEntry<String?, bool> e in stringDomain.entries) {
      test(
        'Testing: ${e.key} => ${e.value}',
        () => expect(FollyValidators.stringNotBlank(e.key) == null, e.value),
      );
    }
  });

  group('Validators stringNullNotEmpty', () {
    Map<String?, bool> stringDomain = <String?, bool>{
      null: true,
      '': false,
      ' ': true,
      '\t': true,
      '\n': true,
      'a': true,
      'A': true,
    };

    for (final MapEntry<String?, bool> e in stringDomain.entries) {
      test(
        'Testing: ${e.key} => ${e.value}',
        () =>
            expect(FollyValidators.stringNullNotEmpty(e.key) == null, e.value),
      );
    }
  });

  group('Validators stringNullNotBlank', () {
    Map<String?, bool> stringDomain = <String?, bool>{
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

    for (final MapEntry<String?, bool> e in stringDomain.entries) {
      test(
        'Testing: ${e.key} => ${e.value}',
        () =>
            expect(FollyValidators.stringNullNotBlank(e.key) == null, e.value),
      );
    }
  });

  group('Validators notNull', () {
    Map<dynamic, bool> tests = <dynamic, bool>{
      null: false,
      '': true,
      ' ': true,
      '\t': true,
      '\n': true,
      '\t\n': true,
      '\n\t': true,
      ' \t \n ': true,
      'a': true,
      'A': true,
      0: true,
      1: true,
      true: true,
      false: true,
    };
    Map<dynamic, bool> domain = <dynamic, bool>{
      ...tests.map(MapEntry.new),

      /// List
      <dynamic>[]: true,
      ...tests.map(
        (final dynamic key, final bool value) =>
            MapEntry<dynamic, bool>(<dynamic>{key}, value),
      ),

      /// Set
      <dynamic>{}: true,
      ...tests.map(
        (final dynamic key, final bool value) =>
            MapEntry<dynamic, bool>(<dynamic>[key], value),
      ),

      /// Map
      <dynamic, dynamic>{}: true,
    };

    for (final MapEntry<dynamic, bool> e1 in tests.entries) {
      for (final MapEntry<dynamic, bool> e2 in tests.entries) {
        domain[<dynamic, dynamic>{e1.key: e2.key}] = e1.value && e2.value;
      }
    }

    for (final MapEntry<dynamic, bool> e in domain.entries) {
      test(
        'Testing: ${(e.key as Object?).runtimeType} ${e.key} => ${e.value}',
        () => expect(FollyValidators.notNull(e.key) == null, e.value),
      );
    }
  });

  group('Validators notEmpty', () {
    Map<dynamic, bool> tests = <dynamic, bool>{
      null: false,
      '': false,
      ' ': true,
      '\t': true,
      '\n': true,
      '\t\n': true,
      '\n\t': true,
      ' \t \n ': true,
      'a': true,
      'A': true,
      0: true,
      1: true,
      true: true,
      false: true,
    };

    Map<dynamic, bool> domain = <dynamic, bool>{
      ...tests.map(MapEntry.new),

      /// List
      <dynamic>[]: false,
      ...tests.map(
        (final dynamic key, final bool value) =>
            MapEntry<dynamic, bool>(<dynamic>{key}, value),
      ),

      /// Set
      <dynamic>{}: false,
      ...tests.map(
        (final dynamic key, final bool value) =>
            MapEntry<dynamic, bool>(<dynamic>[key], value),
      ),

      /// Map
      <dynamic, dynamic>{}: false,
    };

    for (final MapEntry<dynamic, bool> e1 in tests.entries) {
      for (final MapEntry<dynamic, bool> e2 in tests.entries) {
        domain[<dynamic, dynamic>{e1.key: e2.key}] = e1.value && e2.value;
      }
    }

    for (final MapEntry<dynamic, bool> e in domain.entries) {
      test(
        'Testing: ${(e.key as Object?).runtimeType} ${e.key} => ${e.value}',
        () => expect(FollyValidators.notEmpty(e.key) == null, e.value),
      );
    }
  });

  group('Validators notBlank', () {
    Map<dynamic, bool> tests = <dynamic, bool>{
      null: false,
      '': false,
      ' ': false,
      '\t': false,
      '\n': false,
      '\t\n': false,
      '\n\t': false,
      ' \t \n ': false,
      'a': true,
      'A': true,
      0: true,
      1: true,
      true: true,
      false: true,
    };

    Map<dynamic, bool> domain = <dynamic, bool>{
      ...tests.map(MapEntry.new),

      /// List
      <dynamic>[]: false,
      ...tests.map(
        (final dynamic key, final bool value) =>
            MapEntry<dynamic, bool>(<dynamic>{key}, value),
      ),

      /// Set
      <dynamic>{}: false,
      ...tests.map(
        (final dynamic key, final bool value) =>
            MapEntry<dynamic, bool>(<dynamic>[key], value),
      ),

      /// Map
      <dynamic, dynamic>{}: false,
    };

    for (final MapEntry<dynamic, bool> e1 in tests.entries) {
      for (final MapEntry<dynamic, bool> e2 in tests.entries) {
        domain[<dynamic, dynamic>{e1.key: e2.key}] = e1.value && e2.value;
      }
    }

    for (final MapEntry<dynamic, bool> e in domain.entries) {
      test(
        'Testing: ${(e.key as Object?).runtimeType} ${e.key} => ${e.value}',
        () => expect(FollyValidators.notBlank(e.key) == null, e.value),
      );
    }
  });

  group('Validators intGTEZero', () {
    Map<int?, bool> intDomain = <int?, bool>{
      null: false,
      -2: false,
      -1: false,
      0: true,
      1: true,
      2: true,
    };

    for (final MapEntry<int?, bool> e in intDomain.entries) {
      test(
        'Testing: ${e.key} => ${e.value}',
        () => expect(FollyValidators.intGTEZero(e.key) == null, e.value),
      );
    }
  });

  group('Validators intGTZero', () {
    Map<int?, bool> intDomain = <int?, bool>{
      null: false,
      -2: false,
      -1: false,
      0: false,
      1: true,
      2: true,
    };

    for (final MapEntry<int?, bool> e in intDomain.entries) {
      test(
        'Testing: ${e.key} => ${e.value}',
        () => expect(FollyValidators.intGTZero(e.key) == null, e.value),
      );
    }
  });

  group('Validators intLTZero', () {
    Map<int?, bool> intDomain = <int?, bool>{
      null: false,
      -2: true,
      -1: true,
      0: false,
      1: false,
      2: false,
    };

    for (final MapEntry<int?, bool> e in intDomain.entries) {
      test(
        'Testing: ${e.key} => ${e.value}',
        () => expect(FollyValidators.intLTZero(e.key) == null, e.value),
      );
    }
  });

  group('Validators intLTEZero', () {
    Map<int?, bool> intDomain = <int?, bool>{
      null: false,
      -2: true,
      -1: true,
      0: true,
      1: false,
      2: false,
    };

    for (final MapEntry<int?, bool> e in intDomain.entries) {
      test(
        'Testing: ${e.key} => ${e.value}',
        () => expect(FollyValidators.intLTEZero(e.key) == null, e.value),
      );
    }
  });

  group('Validators intNullGTEZero', () {
    Map<int?, bool> intDomain = <int?, bool>{
      null: true,
      -2: false,
      -1: false,
      0: true,
      1: true,
      2: true,
    };

    for (final MapEntry<int?, bool> e in intDomain.entries) {
      test(
        'Testing: ${e.key} => ${e.value}',
        () => expect(FollyValidators.intNullGTEZero(e.key) == null, e.value),
      );
    }
  });

  group('Validators intNullGTZero', () {
    Map<int?, bool> intDomain = <int?, bool>{
      null: true,
      -2: false,
      -1: false,
      0: false,
      1: true,
      2: true,
    };

    for (final MapEntry<int?, bool> e in intDomain.entries) {
      test(
        'Testing: ${e.key} => ${e.value}',
        () => expect(FollyValidators.intNullGTZero(e.key) == null, e.value),
      );
    }
  });

  group('Validators intNullLTZero', () {
    Map<int?, bool> intDomain = <int?, bool>{
      null: true,
      -2: true,
      -1: true,
      0: false,
      1: false,
      2: false,
    };

    for (final MapEntry<int?, bool> e in intDomain.entries) {
      test(
        'Testing: ${e.key} => ${e.value}',
        () => expect(FollyValidators.intNullLTZero(e.key) == null, e.value),
      );
    }
  });

  group('Validators intNullLTEZero', () {
    Map<int?, bool> intDomain = <int?, bool>{
      null: true,
      -2: true,
      -1: true,
      0: true,
      1: false,
      2: false,
    };

    for (final MapEntry<int?, bool> e in intDomain.entries) {
      test(
        'Testing: ${e.key} => ${e.value}',
        () => expect(FollyValidators.intNullLTEZero(e.key) == null, e.value),
      );
    }
  });
}
