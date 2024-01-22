// ignore_for_file: deprecated_member_use_from_same_package

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
    'ModelUtils fromJsonModel',
    () {
      FollyFields.start(
        MockConfig(),
        connectivity: MockConnectivity(),
      );

      const MockStringConsumer consumer = MockStringConsumer();

      Map<Map<String, dynamic>?, MockStringModel?> domain =
          <Map<String, dynamic>?, MockStringModel?>{
        null: null,
        ...MockStringModel.baseDomain,
        MockStringModel.alineMap: MockStringModel.alineModel,
        MockStringModel.kateMap: MockStringModel.kateModel,
      };

      for (final MapEntry<Map<String, dynamic>?, MockStringModel?>(
            :Map<String, dynamic>? key,
            :MockStringModel? value,
          ) in domain.entries) {
        test(
          '$key => $value',
          () => expect(ModelUtils.fromJsonModel(key, consumer), value),
        );
      }
    },
  );
}
