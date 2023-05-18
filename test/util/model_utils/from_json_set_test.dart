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
        <dynamic>{
          <String, dynamic>{},
          <String, dynamic>{},
        }: <MockModel>{
          MockModel(),
        },
        ...MockModel.baseDomain.map(
          (Map<String, dynamic> key, MockModel value) =>
              MapEntry<Set<Map<String, dynamic>>, Set<MockModel>>(
            <Map<String, dynamic>>{key},
            <MockModel>{value},
          ),
        ),
        <dynamic>{
          MockModel.alineMap,
          MockModel.kateMap,
        }: <MockModel>{
          MockModel.alineModel,
          MockModel.kateModel,
        },
        <dynamic>{
          MockModel.alineMap,
          MockModel.alineMap,
        }: <MockModel>{
          MockModel.alineModel,
        },
        <dynamic>{
          MockModel.alineMap,
          <String, dynamic>{},
        }: <MockModel>{
          MockModel.alineModel,
          MockModel(),
        },
      };

      for (final MapEntry<Set<dynamic>?, Set<MockModel>> input
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
