import 'package:folly_fields_example/advanced/base_consumer_mock.dart';
import 'package:folly_fields_example/example_model.dart';

///
///
///
class ExampleConsumer extends BaseConsumerMock<ExampleModel> {
  ///
  ///
  ///
  const ExampleConsumer();

  ///
  ///
  ///
  @override
  ExampleModel fromJson(Map<String, dynamic> map) => ExampleModel.fromJson(map);

  ///
  ///
  ///
  @override
  List<String> get routeName => <String>[];
}
