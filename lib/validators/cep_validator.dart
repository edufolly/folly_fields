import 'package:folly_fields/validators/abstract_validator.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';

///
///
///
class CepValidator extends AbstractValidator<String> {
  ///
  ///
  ///
  CepValidator()
      : super(
          MaskTextInputFormatter(
            mask: '##.###-###',
          ),
        );

  ///
  ///
  ///
  @override
  String format(String value) => strip(value).replaceAllMapped(
        r'^(\d{2})(\d{3})(\d{3})$',
        (Match m) => '${m[1]}.${m[2]}-${m[3]}',
      );

  ///
  ///
  ///
  @override
  bool isValid(String cep, {bool stripBeforeValidation = true}) {
    if (stripBeforeValidation) {
      cep = strip(cep);
    }

    if (cep == null || cep.isEmpty) {
      return false;
    }

    if (cep.length != 8) {
      return false;
    }

    return true;
  }
}
