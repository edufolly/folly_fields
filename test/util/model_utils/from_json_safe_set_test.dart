import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/folly_fields.dart';
import 'package:folly_fields/util/model_utils.dart';

import '../../mocks/crud/mock_consumer.dart';
import '../../mocks/crud/mock_model.dart';
import '../../mocks/mock_config.dart';
import '../../mocks/mock_connectivity.dart';

///
///
///
void main() {
  ///
  group(
    'ModelUtils fromJsonSafeSet',
    () {
      FollyFields.start(
        MockConfig(),
        connectivity: MockConnectivity(),
      );

      MockConsumer consumer = const MockConsumer();

      Map<Map<String, dynamic>, MockModel> baseDomain =
          <Map<String, dynamic>, MockModel>{
        <String, dynamic>{}: MockModel(),
        <String, dynamic>{'id': 'abc'}: MockModel(id: 'abc'),
        <String, dynamic>{'name': 'aline'}: MockModel(name: 'aline'),
        <String, dynamic>{'age': 20}: MockModel(age: 20),
        <String, dynamic>{'id': 'abc', 'name': 'aline', 'age': 20}:
            MockModel(id: 'abc', name: 'aline', age: 20),
        <String, dynamic>{'name': 'aline', 'age': 20}:
            MockModel(name: 'aline', age: 20),
        <String, dynamic>{'name': 20, 'age': '20'}:
            MockModel(name: '20', age: 20),
      };

      Map<dynamic, Set<MockModel>> domain = <dynamic, Set<MockModel>>{
        null: <MockModel>{},

        /// Set
        ...baseDomain.map(
          (Map<String, dynamic> key, MockModel value) =>
              MapEntry<dynamic, Set<MockModel>>(
            <dynamic>{key},
            <MockModel>{value},
          ),
        ),
        <dynamic>{}: <MockModel>{},
        <dynamic>{
          <String, dynamic>{},
          <String, dynamic>{},
        }: <MockModel>{
          MockModel(),
        },
        <dynamic>{
          <String, dynamic>{'id': 'abc', 'name': 'aline', 'age': 20},
          <String, dynamic>{'id': 'cde', 'name': 'kate', 'age': 28},
        }: <MockModel>{
          MockModel(id: 'abc', name: 'aline', age: 20),
          MockModel(id: 'cde', name: 'kate', age: 28),
        },
        <dynamic>{
          <String, dynamic>{'id': 'abc', 'name': 'aline', 'age': 20},
          <String, dynamic>{},
        }: <MockModel>{
          MockModel(id: 'abc', name: 'aline', age: 20),
          MockModel(),
        },

        /// List
        ...baseDomain.map(
          (Map<String, dynamic> key, MockModel value) =>
              MapEntry<dynamic, Set<MockModel>>(
            <dynamic>[key],
            <MockModel>{value},
          ),
        ),
        <dynamic>[]: <MockModel>{},
        <dynamic>[
          <String, dynamic>{},
          <String, dynamic>{},
        ]: <MockModel>{
          MockModel(),
        },
        <dynamic>[
          <String, dynamic>{'id': 'abc', 'name': 'aline', 'age': 20},
          <String, dynamic>{'id': 'cde', 'name': 'kate', 'age': 28},
        ]: <MockModel>{
          MockModel(id: 'abc', name: 'aline', age: 20),
          MockModel(id: 'cde', name: 'kate', age: 28),
        },
        <dynamic>[
          <String, dynamic>{'id': 'abc', 'name': 'aline', 'age': 20},
          <String, dynamic>{'id': 'abc', 'name': 'aline', 'age': 20},
        ]: <MockModel>{
          MockModel(id: 'abc', name: 'aline', age: 20),
        },
        <dynamic>[
          <String, dynamic>{'id': 'abc', 'name': 'aline', 'age': 20},
          <String, dynamic>{},
        ]: <MockModel>{
          MockModel(id: 'abc', name: 'aline', age: 20),
          MockModel(),
        },

        /// Map
        ...baseDomain.map(
          (Map<String, dynamic> key, MockModel value) =>
              MapEntry<dynamic, Set<MockModel>>(key, <MockModel>{value}),
        ),
      };

      for (final MapEntry<dynamic, Set<MockModel>> input in domain.entries) {
        test(
          '${input.key} // ${input.value}',
          () {
            expect(
              ModelUtils.fromJsonSafeSet(
                input.key,
                producer: (dynamic e) => consumer.fromJson(e),
              ),
              input.value,
            );
          },
        );
      }
    },
  );
}
