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
    'ModelUtils fromJsonSet',
    () {
      FollyFields.start(
        MockConfig(),
        connectivity: MockConnectivity(),
      );

      MockConsumer consumer = const MockConsumer();

      Map<Set<dynamic>?, Set<MockModel>> domain =
          <Set<dynamic>?, Set<MockModel>>{
        null: <MockModel>{},
        <dynamic>{}: <MockModel>{},
        <dynamic>{<String, dynamic>{}}: <MockModel>{MockModel()},
        <dynamic>{
          <String, dynamic>{},
          <String, dynamic>{},
        }: <MockModel>{
          MockModel(),
        },
        <dynamic>{
          <String, dynamic>{'id': 'abc', 'name': 'aline', 'age': 20},
        }: <MockModel>{
          MockModel(id: 'abc', name: 'aline', age: 20),
        },
        <dynamic>{
          <String, dynamic>{'id': 'abc', 'name': 'aline', 'age': 20},
          <String, dynamic>{'id': 'abc', 'name': 'aline', 'age': 20},
        }: <MockModel>{
          MockModel(id: 'abc', name: 'aline', age: 20),
        },
        <dynamic>{
          <String, dynamic>{'id': 'abc', 'name': 'aline', 'age': 20},
          <String, dynamic>{'id': 'cde', 'name': 'kate', 'age': 28},
        }: <MockModel>{
          MockModel(id: 'abc', name: 'aline', age: 20),
          MockModel(id: 'cde', name: 'kate', age: 28),
        },
        <dynamic>{
          <String, dynamic>{'name': 'aline', 'age': 20},
        }: <MockModel>{
          MockModel(name: 'aline', age: 20),
        },
        <dynamic>{
          <String, dynamic>{'name': 20, 'age': '20'},
        }: <MockModel>{
          MockModel(name: '20', age: 20),
        },
        <dynamic>{
          <String, dynamic>{'name': 'aline'},
        }: <MockModel>{
          MockModel(name: 'aline'),
        },
        <dynamic>{
          <String, dynamic>{'age': 20},
        }: <MockModel>{
          MockModel(age: 20),
        },
      };

      for (final MapEntry<Set<dynamic>?, Set<MockModel>> input
          in domain.entries) {
        test(
          '${input.key} - ${input.value}',
          () {
            expect(
              ModelUtils.fromJsonSet(input.key, consumer),
              input.value,
            );
          },
        );
      }
    },
  );
}
