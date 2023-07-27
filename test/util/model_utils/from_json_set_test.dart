import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/folly_fields.dart';
import 'package:folly_fields/util/model_utils.dart';

import '../../mocks/crud/mock_string_consumer.dart';
import '../../mocks/crud/mock_string_model.dart';
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

      const MockStringConsumer consumer = MockStringConsumer();

      final Map<Set<dynamic>?, Set<MockStringModel>> domain =
          <Set<dynamic>?, Set<MockStringModel>>{
        null: <MockStringModel>{},
        <dynamic>{}: <MockStringModel>{},
        <dynamic>{
          <String, dynamic>{},
          <String, dynamic>{},
        }: <MockStringModel>{
          MockStringModel(),
        },
        ...MockStringModel.baseDomain.map(
          (Map<String, dynamic> key, MockStringModel value) =>
              MapEntry<Set<Map<String, dynamic>>, Set<MockStringModel>>(
            <Map<String, dynamic>>{key},
            <MockStringModel>{value},
          ),
        ),
        <dynamic>{
          MockStringModel.alineMap,
          MockStringModel.kateMap,
        }: <MockStringModel>{
          MockStringModel.alineModel,
          MockStringModel.kateModel,
        },
        <dynamic>{
          MockStringModel.alineMap,
          MockStringModel.alineMap,
        }: <MockStringModel>{
          MockStringModel.alineModel,
        },
        <dynamic>{
          MockStringModel.alineMap,
          <String, dynamic>{},
        }: <MockStringModel>{
          MockStringModel.alineModel,
          MockStringModel(),
        },
      };

      for (final MapEntry<Set<dynamic>?, Set<MockStringModel>> input
          in domain.entries) {
        test(
          '${input.key} // ${input.value}',
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
