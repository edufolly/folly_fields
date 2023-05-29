import 'package:flutter/services.dart';

///
///
///
class DecimalTextFormatter extends TextInputFormatter {
  final int precision;
  final String decimalSeparator;
  final String thousandSeparator;
  final RegExp allow;

  ///
  ///
  ///
  DecimalTextFormatter({
    required this.precision,
    this.decimalSeparator = ',',
    this.thousandSeparator = '.',
  }) : allow = RegExp('[-0-9$decimalSeparator$thousandSeparator]');

  ///
  ///
  ///
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // print('old: ${oldValue.toJSON()}');
    // print('new: ${newValue.toJSON()}');

    final int signals = RegExp('-').allMatches(newValue.text).length;

    bool isNegative = oldValue.text.startsWith('-');
    bool delNegative = false;

    if (isNegative && signals != 1) {
      isNegative = false;
      delNegative = true;
    }

    if (!isNegative && signals == 1) {
      isNegative = true;
    }

    String newText = newValue.text.replaceAll('-', '');

    /// Empty value
    if (newText.isEmpty ||
        newText == decimalSeparator ||
        newText == thousandSeparator) {
      // print('New value is empty or equals to "$decimalSeparator" '
      //       'or equals to "$thousandSeparator"');
      // print('\n');

      return TextEditingValue(
        text: '${isNegative ? '-0' : '0'}$decimalSeparator'
            .padRight(precision + (isNegative ? 3 : 2), '0'),
        selection: TextSelection.collapsed(offset: (isNegative ? 2 : 1)),
      );
    }

    /// Char not allowed.
    if (allow.allMatches(newText).length != newText.length) {
      // print('Char not allowed.');
      // print('\n');

      return oldValue;
    }

    final int oldDecimalCount = oldValue.text.split(decimalSeparator).length;
    final int oldThousandCount = oldValue.text.split(thousandSeparator).length;

    final int newDecimalCount = newText.split(decimalSeparator).length;
    final int newThousandCount = newText.split(thousandSeparator).length;

    if (oldDecimalCount < newDecimalCount ||
        oldThousandCount < newThousandCount) {
      final int curPos = oldValue.text.indexOf(decimalSeparator) + 1;

      // print('curPos: $curPos');

      if (newValue.selection.baseOffset <= curPos) {
        final Map<String, dynamic> oldValueJson = oldValue.toJSON();
        oldValueJson['selectionBase'] = curPos;
        oldValueJson['selectionExtent'] = curPos;

        // print('\n');

        return TextEditingValue.fromJSON(oldValueJson);
      }

      // print('\n');

      return oldValue;
    }

    /// Decimal Part
    if (newText.contains(decimalSeparator)) {
      final List<String> parts = newText.split(decimalSeparator);

      // print('Integer Part: ${parts.first}');
      // print('Decimal Part: ${parts.last}');

      String decimalPart = parts.last;

      decimalPart = decimalPart.length > precision
          ? decimalPart.substring(0, precision)
          : decimalPart.padRight(precision, '0');

      newText = '${parts.first}$decimalSeparator$decimalPart';
    } else {
      if (newText.length == 1) {
        newText += decimalSeparator.padRight(precision + 1, '0');
      } else {
        final int pos = newText.length - precision;
        newText = newText.substring(0, pos) +
            decimalSeparator +
            newText.substring(pos);
      }
    }

    final int firstLength = newText.length;

    /// Integer Part
    final List<String> parts = newText.split(decimalSeparator);

    final int integerPart =
        int.tryParse(parts.first.replaceAll(thousandSeparator, '')) ?? 0;

    final List<String> numbers =
        integerPart.toString().split('').reversed.toList();

    for (int pos = 3; pos < numbers.length; pos += 4) {
      numbers.insert(pos, thousandSeparator);
    }

    newText = numbers.reversed.join() + decimalSeparator + parts.last;

    /// Cursor Positioning
    final int newTextLength = newText.length;

    int newPos = newValue.selection.baseOffset;

    // print('newPos: $newPos');

    newPos += newTextLength - firstLength;

    // print('delta: ${newTextLength - firstLength}');

    if (delNegative) {
      newPos -= 2;
    }

    if (newPos < 1) {
      newPos = 0;
    }

    newText = (isNegative ? '-' : '') + newText;

    if (newPos > newText.length) {
      newPos = newText.length;
    }

    final Map<String, dynamic> newValueJson = newValue.toJSON();
    newValueJson['text'] = newText;
    newValueJson['selectionBase'] = newPos;
    newValueJson['selectionExtent'] = newPos;

    // print('newValueJson: $newValueJson');
    // print('\n');

    return TextEditingValue.fromJSON(newValueJson);
  }
}
