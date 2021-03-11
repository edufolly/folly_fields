import 'package:folly_fields_example/advanced/base_consumer_mock.dart';
import 'package:folly_fields_example/example_model.dart';

///
///
///
class ExampleConsumer extends BaseConsumerMock<int, ExampleModel> {
  ///
  ///
  ///
  @override
  ExampleModel get modelInstance => ExampleModel();

  ///
  ///
  ///
  @override
  List<String> get routeName => <String>['example'];
}
