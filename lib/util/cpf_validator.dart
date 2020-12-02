import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:folly_fields/util/abstract_validator.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';

///
///
///
class CpfValidator extends AbstractValidator<String> {
  ///
  ///
  ///
  CpfValidator()
      : super(
          MaskTextInputFormatter(
            mask: '###.###.###-##',
          ),
        );

  ///
  ///
  ///
  @override
  String format(String value) => CPFValidator.format(value);

  ///
  ///
  ///
  @override
  bool isValid(String value, {bool stripBeforeValidation = true}) =>
      CPFValidator.isValid(value, stripBeforeValidation);
}
