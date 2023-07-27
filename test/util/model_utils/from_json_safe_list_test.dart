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
    'ModelUtils fromJsonSafeList',
    () {
      FollyFields.start(
        MockConfig(),
        connectivity: MockConnectivity(),
      );

      const MockStringConsumer consumer = MockStringConsumer();

      final Map<dynamic, Set<MockStringModel>> domain =
          <dynamic, Set<MockStringModel>>{
        null: <MockStringModel>{},

        /// Set
        ...MockStringModel.baseDomain.map(
          (Map<String, dynamic> key, MockStringModel value) =>
              MapEntry<dynamic, Set<MockStringModel>>(
            <dynamic>{key},
            <MockStringModel>{value},
          ),
        ),
        <dynamic>{}: <MockStringModel>{},
        <dynamic>{
          <String, dynamic>{},
          <String, dynamic>{},
        }: <MockStringModel>{
          MockStringModel(),
        },
        <dynamic>{
          MockStringModel.alineMap,
          MockStringModel.kateMap,
        }: <MockStringModel>{
          MockStringModel.alineModel,
          MockStringModel.kateModel,
        },
        <dynamic>{
          MockStringModel.alineMap,
          <String, dynamic>{},
        }: <MockStringModel>{
          MockStringModel.alineModel,
          MockStringModel(),
        },

        /// List
        ...MockStringModel.baseDomain.map(
          (Map<String, dynamic> key, MockStringModel value) =>
              MapEntry<dynamic, Set<MockStringModel>>(
            <dynamic>[key],
            <MockStringModel>{value},
          ),
        ),
        <dynamic>[]: <MockStringModel>{},
        <dynamic>[
          <String, dynamic>{},
          <String, dynamic>{},
        ]: <MockStringModel>{
          MockStringModel(),
          MockStringModel(),
        },
        <dynamic>[
          MockStringModel.alineMap,
          MockStringModel.kateMap,
        ]: <MockStringModel>{
          MockStringModel.alineModel,
          MockStringModel.kateModel,
        },
        <dynamic>[
          MockStringModel.alineMap,
          MockStringModel.alineMap,
        ]: <MockStringModel>{
          MockStringModel.alineModel,
          MockStringModel.alineModel,
        },
        <dynamic>[
          MockStringModel.alineMap,
          <String, dynamic>{},
        ]: <MockStringModel>{
          MockStringModel.alineModel,
          MockStringModel(),
        },

        /// Map
        ...MockStringModel.baseDomain.map(
          (Map<String, dynamic> key, MockStringModel value) =>
              MapEntry<dynamic, Set<MockStringModel>>(
            key,
            <MockStringModel>{value},
          ),
        ),
      };

      for (final MapEntry<dynamic, Set<MockStringModel>> input
          in domain.entries) {
        test(
          '${input.key} // ${input.value}',
          () {
            expect(
              ModelUtils.fromJsonSafeList(
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
