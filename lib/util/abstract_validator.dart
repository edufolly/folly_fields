import 'mask_text_input_formatter.dart';

///
///
///
abstract class AbstractValidator<T> {

  ///
  ///
  ///
  String format(T value);

  ///
  ///
  ///
  String strip(String value) => (value ?? '').replaceAll(RegExp(r'[^\d]'), '');

  ///
  ///
  ///
  bool isValid(String value, {bool stripBeforeValidation = true});

  ///
  ///
  ///
  MaskTextInputFormatter get mask;
}

///
///
///
abstract class AbstractTimeParser<T> {
  ///
  ///
  ///
  T parse(String value);

  ///
  ///
  ///
  String valid(String value);
}
