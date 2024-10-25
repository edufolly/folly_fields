import 'package:folly_fields_example/advanced/base_consumer_mock.dart';
import 'package:folly_fields_example/example_model.dart';

///
///
///
class ExampleConsumer extends BaseConsumerMock<ExampleModel> {
  ///
  ///
  ///
  const ExampleConsumer() : super(const <String>[]);

  ///
  ///
  ///
  @override
  ExampleModel fromJson(Map<String, dynamic> map) => ExampleModel.fromJson(map);

  ///
  ///
  ///
  @override
  int? idFrom(dynamic value) => int.tryParse(value.toString());
}
