import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

// TODO(edufolly): Bug ao excluir a vírgula usando backspace.
// TODO(edufolly): Bug ao excluir a vírgula usando delete.
// TODO(edufolly): Bug ao excluir o primeiro caractere com o delete.
// TODO(edufolly): Bug ao excluir o primeiro caractere com o baclspace.
// TODO(edufolly): Bug ao não deixar caracteres na parte inteira.

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
    if (kDebugMode) {
      print('old: ${oldValue.toJSON()}');
      print('new: ${newValue.toJSON()}');
    }

    bool isDeleting = oldValue.text.length > newValue.text.length;
    int newOffset = newValue.selection.baseOffset;

    if (kDebugMode) {
      print('isDeleting: $isDeleting');
      print('newOffset: $newOffset');
    }

    if (newValue.text.isEmpty ||
        newValue.text == decimalSeparator ||
        newValue.text == thousandSeparator) {
      if (kDebugMode) {
        print('\n');
      }
      return TextEditingValue(
        text: '0${decimalSeparator.padRight(precision + 1, '0')}',
        selection: const TextSelection.collapsed(offset: 1),
      );
    }

    if (allow.allMatches(newValue.text).length != newValue.text.length) {
      if (kDebugMode) {
        print('\n');
      }
      return oldValue;
    }

    int oldDecimalPos = oldValue.text.indexOf(decimalSeparator) + 1;
    int cursorPos = newValue.selection.baseOffset;

    int oldDecimalCount = oldValue.text.split(decimalSeparator).length;
    int oldThousandCount = oldValue.text.split(thousandSeparator).length;

    int newDecimalCount = newValue.text.split(decimalSeparator).length;
    int newThousandCount = newValue.text.split(thousandSeparator).length;

    if (oldDecimalCount < newDecimalCount ||
        oldThousandCount < newThousandCount) {
      if (kDebugMode) {
        print('oldDecimalPos: $oldDecimalPos');
      }

      if (cursorPos <= oldDecimalPos) {
        Map<String, dynamic> oldValueJson = oldValue.toJSON();
        if (kDebugMode) {
          oldValueJson['selectionBase'] = oldDecimalPos;
          oldValueJson['selectionExtent'] = oldDecimalPos;
          print('\n');
        }
        return TextEditingValue.fromJSON(oldValueJson);
      }

      if (kDebugMode) {
        print('\n');
      }
      return oldValue;
    }

    /// Format
    String newValueText = newValue.text;

    /// Decimal Part
    bool hasDecimalSeparator = newValueText.contains(decimalSeparator);

    if (hasDecimalSeparator) {
      List<String> p = newValueText.split(decimalSeparator);
      if (kDebugMode) {
        print('P First: ${p.first}');
        print('P Last: ${p.last}');
      }

      String decimalPart = p.last;

      if (decimalPart.length > precision) {
        decimalPart = decimalPart.substring(0, precision);
      } else {
        if (kDebugMode) {
          print('decimalPart Length: ${decimalPart.length}');
        }
        decimalPart = decimalPart.padRight(precision, '0');
      }

      newValueText = '${p.first}$decimalSeparator$decimalPart';
    } else {
      newValueText += decimalSeparator.padRight(precision + 1, '0');
    }

    int firstLength = newValueText.length;

    /// Integer Part
    List<String> p = newValueText.split(decimalSeparator);

    int integerPart =
        int.tryParse(p.first.replaceAll(thousandSeparator, '')) ?? 0;

    List<String> numbers = integerPart.toString().split('').reversed.toList();

    for (int i = 3; i < numbers.length; i += 4) {
      numbers.insert(i, thousandSeparator);
    }

    newValueText = numbers.reversed.join() + decimalSeparator + p.last;

    Map<String, dynamic> newValueJson = newValue.toJSON();

    newValueJson['text'] = newValueText;

    /// Cursor Positioning
    int newTextLength = newValueText.length;

    int newPos = newValue.selection.baseOffset;

    int delta = newTextLength - firstLength;
    if (kDebugMode) {
      print('delta: $delta');
    }

    newPos += delta;

    if (newValue.selection.baseOffset > newTextLength) {
      newPos = newTextLength;
    }

    if (newPos < 1) {
      newPos = 1;
    }

    newValueJson['selectionBase'] = newPos;
    newValueJson['selectionExtent'] = newPos;

    if (kDebugMode) {
      print('newValueJson: $newValueJson');
      print('\n');
    }

    return TextEditingValue.fromJSON(newValueJson);
  }
}
