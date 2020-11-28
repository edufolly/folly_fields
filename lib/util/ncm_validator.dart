///
///
///
class NcmValidator {
  static const String STRIP_REGEX = r'[^\d]';

  ///
  ///
  ///
  static String format(String ncm) {
    RegExp regExp = RegExp(r'^(\d{4})(\d{2})(\d{2})$');

    return strip(ncm)
        .replaceAllMapped(regExp, (Match m) => '${m[1]}.${m[2]}.${m[3]}');
  }

  ///
  ///
  ///
  static String strip(String ncm) {
    RegExp regex = RegExp(STRIP_REGEX);
    ncm = ncm ?? '';

    return ncm.replaceAll(regex, '');
  }

  ///
  ///
  ///
  static bool isValid(String ncm, [bool stripBeforeValidation = true]) {
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
}
