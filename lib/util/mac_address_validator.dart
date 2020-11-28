///
///
///
class MacAddressValidator {
  static const String STRIP_REGEX = r'[^A-F0-9]';

  ///
  ///
  ///
  static String format(String macAddress) {
    RegExp regExp = RegExp(r'^([A-F0-9]{2})([A-F0-9]{2})([A-F0-9]{2})'
        r'([A-F0-9]{2})([A-F0-9]{2})([A-F0-9]{2})$');

    return strip(macAddress).replaceAllMapped(
      regExp,
      (Match m) => '${m[1]}:${m[2]}:${m[3]}:${m[4]}:${m[5]}:${m[6]}',
    );
  }

  ///
  ///
  ///
  static String strip(String macAddress) {
    RegExp regex = RegExp(STRIP_REGEX);
    macAddress = macAddress ?? '';

    return macAddress.replaceAll(regex, '');
  }

  ///
  ///
  ///
  static bool isValid(String macAddress, [bool stripBeforeValidation = true]) {
    if (stripBeforeValidation) {
      macAddress = strip(macAddress);
    }

    // mac address must be defined
    if (macAddress == null || macAddress.isEmpty || macAddress.length > 12) {
      return false;
    }

    return true;
  }
}
