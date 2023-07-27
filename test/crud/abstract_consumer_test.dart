import 'package:flutter_test/flutter_test.dart';

import '../mocks/crud/mock_int_consumer.dart';
import '../mocks/crud/mock_int_model.dart';
import '../mocks/crud/mock_string_consumer.dart';
import '../mocks/crud/mock_string_model.dart';

///
///
///
void main() {
  group('Abstract Consumer', () {
    test('Mock String', () {
      const MockStringConsumer consumer = MockStringConsumer();

      expect(
        MockStringModel.alineModel.id,
        consumer.idFrom(MockStringModel.alineMap['id']),
      );

      expect(
        MockStringModel.kateModel.id,
        consumer.idFrom(MockStringModel.kateMap['id']),
      );
    });

    test('Mock Int', () {
      const MockIntConsumer consumer = MockIntConsumer();

      expect(
        MockIntModel.alineModel.id,
        consumer.idFrom(MockIntModel.alineMap['id']),
      );

      expect(
        MockIntModel.kateModel.id,
        consumer.idFrom(MockIntModel.kateMap['id']),
      );
    });
  });
}
