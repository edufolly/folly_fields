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

      const MockConsumer consumer = MockConsumer();

      final Map<dynamic, Set<MockModel>> domain = <dynamic, Set<MockModel>>{
        null: <MockModel>{},

        /// Set
        ...MockModel.baseDomain.map(
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
          MockModel.alineMap,
          MockModel.kateMap,
        }: <MockModel>{
          MockModel.alineModel,
          MockModel.kateModel,
        },
        <dynamic>{
          MockModel.alineMap,
          <String, dynamic>{},
        }: <MockModel>{
          MockModel.alineModel,
          MockModel(),
        },

        /// List
        ...MockModel.baseDomain.map(
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
          MockModel.alineMap,
          MockModel.kateMap,
        ]: <MockModel>{
          MockModel.alineModel,
          MockModel.kateModel,
        },
        <dynamic>[
          MockModel.alineMap,
          MockModel.alineMap,
        ]: <MockModel>{
          MockModel.alineModel,
        },
        <dynamic>[
          MockModel.alineMap,
          <String, dynamic>{},
        ]: <MockModel>{
          MockModel.alineModel,
          MockModel(),
        },

        /// Map
        ...MockModel.baseDomain.map(
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
