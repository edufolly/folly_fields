import 'package:flutter/services.dart';

class DecimalTextFormatter extends TextInputFormatter {
  final int precision;
  final String decimalSeparator;
  final String thousandSeparator;
  final RegExp allow;

  DecimalTextFormatter({
    required this.precision,
    this.decimalSeparator = ',',
    this.thousandSeparator = '.',
  }) : allow = precision > 0
           ? RegExp('[-0-9$decimalSeparator$thousandSeparator]')
           : RegExp('[-0-9$thousandSeparator]');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    int signals = RegExp('-').allMatches(newValue.text).length;

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
        (precision > 0 && newText == decimalSeparator) ||
        newText == thousandSeparator) {
      String textRes = isNegative ? '-0' : '0';
      int offsetRes = isNegative ? 2 : 1;

      if (precision > 0) {
        textRes = '$textRes$decimalSeparator'.padRight(
          precision + (isNegative ? 3 : 2),
          '0',
        );
      } else {
        offsetRes = textRes.length;
      }

      return TextEditingValue(
        text: textRes,
        selection: TextSelection.collapsed(offset: offsetRes),
      );
    }

    /// Char not allowed.
    if (allow.allMatches(newText).length != newText.length) {
      return oldValue;
    }

    int oldDecimalCount = oldValue.text.split(decimalSeparator).length;
    int oldThousandCount = oldValue.text.split(thousandSeparator).length;

    int newDecimalCount = newText.split(decimalSeparator).length;
    int newThousandCount = newText.split(thousandSeparator).length;

    if ((precision > 0 && oldDecimalCount < newDecimalCount) ||
        oldThousandCount < newThousandCount) {
      if (precision > 0) {
        int curPos = oldValue.text.indexOf(decimalSeparator) + 1;

        if (newValue.selection.baseOffset <= curPos) {
          Map<String, dynamic> oldValueJson = oldValue.toJSON();
          oldValueJson['selectionBase'] = curPos;
          oldValueJson['selectionExtent'] = curPos;

          return TextEditingValue.fromJSON(oldValueJson);
        }
      }

      return oldValue;
    }

    /// Decimal Part
    if (precision > 0) {
      if (newText.contains(decimalSeparator)) {
        List<String> parts = newText.split(decimalSeparator);

        String decimalPart = parts.last;

        decimalPart = decimalPart.length > precision
            ? decimalPart.substring(0, precision)
            : decimalPart.padRight(precision, '0');

        newText = '${parts.first}$decimalSeparator$decimalPart';
      } else {
        if (newText.length == 1) {
          newText += decimalSeparator.padRight(precision + 1, '0');
        } else {
          int pos = newText.length - precision;
          newText =
              newText.substring(0, pos) +
              decimalSeparator +
              newText.substring(pos);
        }
      }
    }

    int firstLength = newText.length;

    /// Integer Part
    List<String> parts = precision > 0
        ? newText.split(decimalSeparator)
        : <String>[newText, ''];

    int integerPart =
        int.tryParse(parts.first.replaceAll(thousandSeparator, '')) ?? 0;

    List<String> numbers = integerPart.toString().split('').reversed.toList();

    for (int pos = 3; pos < numbers.length; pos += 4) {
      numbers.insert(pos, thousandSeparator);
    }

    newText =
        numbers.reversed.join() +
        (precision > 0 ? (decimalSeparator + parts.last) : '');

    /// Cursor Positioning
    int newTextLength = newText.length;

    int newPos = newValue.selection.baseOffset;

    newPos += newTextLength - firstLength;

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

    Map<String, dynamic> newValueJson = newValue.toJSON();
    newValueJson['text'] = newText;
    newValueJson['selectionBase'] = newPos;
    newValueJson['selectionExtent'] = newPos;

    return TextEditingValue.fromJSON(newValueJson);
  }
}
