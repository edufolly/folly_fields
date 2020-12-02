import 'package:folly_fields/util/abstract_validator.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';

///
///
///
class NcmValidator extends AbstractValidator<String> {
  ///
  ///
  ///
  @override
  String format(String value) => strip(value).replaceAllMapped(
      RegExp(r'^(\d{4})(\d{2})(\d{2})$'),
      (Match m) => '${m[1]}.${m[2]}.${m[3]}');

  ///
  ///
  ///
  @override
  bool isValid(String ncm, {bool stripBeforeValidation = true}) {
    if (stripBeforeValidation) {
      ncm = strip(ncm);
    }

    if (ncm == null || ncm.isEmpty) {
      return false;
    }

    if (ncm.length != 8) {
      return false;
    }

    return true;
  }

  ///
  ///
  ///
  @override
  MaskTextInputFormatter get mask => MaskTextInputFormatter(
        mask: '####.##.##',
      );
}
