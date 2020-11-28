///
///
/// TODO - Criar classe abstrata para manter o padrão da validação.
class PhoneValidator {
  static const String STRIP_REGEX = r'[^\d]';

  ///
  ///
  ///
  static String format(String phone) {
    RegExp regExp = RegExp(r'^(\d{2})(\d{4,5})(\d{4})$');

    return strip(phone)
        .replaceAllMapped(regExp, (Match m) => '(${m[1]}) ${m[2]}-${m[3]}');
  }

  ///
  ///
  ///
  static String strip(String phone) {
    RegExp regex = RegExp(STRIP_REGEX);
    phone = phone ?? '';

    return phone.replaceAll(regex, '');
  }

  ///
  ///
  ///
  static bool isValid(String phone, [bool stripBeforeValidation = true]) {
    if (stripBeforeValidation) {
      phone = strip(phone);
    }

    // phone must be defined
    if (phone == null || phone.isEmpty) {
      return false;
    }

    // phone must have 10 or 11 chars
    if (phone.length < 10 || phone.length > 11) {
      return false;
    }

    // Não existe DDD com zero.
    if (phone[0] == '0' || phone[1] == '0') {
      return false;
    }

    // Números de 9 dígitos sempre iniciam com 9.
    if (phone.length == 11 && phone[2] != '9') {
      return false;
    }

    return true;
  }
}
