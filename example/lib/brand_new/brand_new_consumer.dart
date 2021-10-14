import 'package:folly_fields_example/advanced/base_consumer_mock.dart';
import 'package:folly_fields_example/brand_new/brand_new_model.dart';

///
///
///
class BrandNewConsumer extends BaseConsumerMock<BrandNewModel> {
  ///
  ///
  ///
  @override
  BrandNewModel fromJson(Map<String, dynamic> map) =>
      BrandNewModel.fromJson(map);
}
