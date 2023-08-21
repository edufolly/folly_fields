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
    'ModelUtils fromJsonList',
    () {
      FollyFields.start(
        MockConfig(),
        connectivity: MockConnectivity(),
      );

      const MockStringConsumer consumer = MockStringConsumer();

      Map<List<Map<String, dynamic>>?, List<MockStringModel>> domain =
          <List<Map<String, dynamic>>?, List<MockStringModel>>{
        null: <MockStringModel>[],
        <Map<String, dynamic>>[]: <MockStringModel>[],
        <Map<String, dynamic>>[
          <String, dynamic>{},
          <String, dynamic>{},
        ]: <MockStringModel>[
          MockStringModel(),
          MockStringModel(),
        ],
        ...MockStringModel.baseDomain.map(
          (Map<String, dynamic> key, MockStringModel value) =>
              MapEntry<List<Map<String, dynamic>>, List<MockStringModel>>(
            <Map<String, dynamic>>[key],
            <MockStringModel>[value],
          ),
        ),
        <Map<String, dynamic>>[
          MockStringModel.alineMap,
          MockStringModel.kateMap,
        ]: <MockStringModel>[
          MockStringModel.alineModel,
          MockStringModel.kateModel,
        ],
        <Map<String, dynamic>>[
          MockStringModel.alineMap,
          MockStringModel.alineMap,
        ]: <MockStringModel>[
          MockStringModel.alineModel,
          MockStringModel.alineModel,
        ],
        <Map<String, dynamic>>[
          MockStringModel.alineMap,
          <String, dynamic>{},
        ]: <MockStringModel>[
          MockStringModel.alineModel,
          MockStringModel(),
        ],
      };

      for (final MapEntry<List<Map<String, dynamic>>?, List<MockStringModel>>(
            :List<Map<String, dynamic>>? key,
            :List<MockStringModel> value,
          ) in domain.entries) {
        test(
          '$key => $value',
          () => expect(ModelUtils.fromJsonList(key, consumer), value),
        );
      }
    },
  );
}
