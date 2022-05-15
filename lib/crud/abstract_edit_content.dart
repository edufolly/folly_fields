import 'package:flutter/widgets.dart';
import 'package:folly_fields/crud/abstract_edit_controller.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/responsive/responsive.dart';

///
///
///
// TODO(edufolly): Check this hint.
// ignore: one_member_abstracts
abstract class AbstractEditContent<T extends AbstractModel<Object>,
    E extends AbstractEditController<T>> {
  ///
  ///
  ///
  List<Responsive> formContent(
    BuildContext context,
    T model,
    String labelPrefix,
    Function(bool refresh) refresh,
    bool Function() formValidate,
    E editController, {
    required bool edit,
  });
}
