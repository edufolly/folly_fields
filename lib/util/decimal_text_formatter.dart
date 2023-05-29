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
  }) : allow = RegExp('[0-9$decimalSeparator$thousandSeparator]');

  ///
  ///
  ///
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // if (kDebugMode) {
    //   print('old: ${oldValue.toJSON()}');
    //   print('new: ${newValue.toJSON()}');
    // }

    String newText = newValue.text;

    /// Empty value
    if (newText.isEmpty ||
        newText == decimalSeparator ||
        newText == thousandSeparator) {
      // if (kDebugMode) {
      //   print('New value is empty or equals to "$decimalSeparator" '
      //       'or equals to "$thousandSeparator"');
      //   print('\n');
      // }

      return TextEditingValue(
        text: '0$decimalSeparator'.padRight(precision + 2, '0'),
        selection: const TextSelection.collapsed(offset: 1),
      );
    }

    /// Char not allowed.
    if (allow.allMatches(newText).length != newText.length) {
      // if (kDebugMode) {
      //   print('Char not allowed.');
      //   print('\n');
      // }

      return oldValue;
    }

    final int oldDecimalCount = oldValue.text.split(decimalSeparator).length;
    final int oldThousandCount = oldValue.text.split(thousandSeparator).length;

    final int newDecimalCount = newText.split(decimalSeparator).length;
    final int newThousandCount = newText.split(thousandSeparator).length;

    if (oldDecimalCount < newDecimalCount ||
        oldThousandCount < newThousandCount) {
      final int curPos = oldValue.text.indexOf(decimalSeparator) + 1;

      // if (kDebugMode) {
      //   print('curPos: $curPos');
      // }

      if (newValue.selection.baseOffset <= curPos) {
        final Map<String, dynamic> oldValueJson = oldValue.toJSON();
        oldValueJson['selectionBase'] = curPos;
        oldValueJson['selectionExtent'] = curPos;

        // if (kDebugMode) {
        //   print('\n');
        // }

        return TextEditingValue.fromJSON(oldValueJson);
      }

      // if (kDebugMode) {
      //   print('\n');
      // }

      return oldValue;
    }

    /// Decimal Part
    if (newText.contains(decimalSeparator)) {
      final List<String> parts = newText.split(decimalSeparator);

      // if (kDebugMode) {
      //   print('Integer Part: ${parts.first}');
      //   print('Decimal Part: ${parts.last}');
      // }

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

    final Map<String, dynamic> newValueJson = newValue.toJSON();

    newValueJson['text'] = newText;

    /// Cursor Positioning
    final int newTextLength = newText.length;

    int newPos = newValue.selection.baseOffset;

    final int delta = newTextLength - firstLength;

    // if (kDebugMode) {
    //   print('delta: $delta');
    // }

    newPos += delta;

    if (newValue.selection.baseOffset > newTextLength) {
      newPos = newTextLength;
    }

    if (newPos < 1) {
      newPos = 0;
    }

    newValueJson['selectionBase'] = newPos;
    newValueJson['selectionExtent'] = newPos;

    // if (kDebugMode) {
    //   print('newValueJson: $newValueJson');
    //   print('\n');
    // }

    return TextEditingValue.fromJSON(newValueJson);
  }
}
