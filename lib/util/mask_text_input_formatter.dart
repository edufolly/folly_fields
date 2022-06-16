import 'dart:math';

import 'package:flutter/services.dart';

///
///
///
class MaskTextInputFormatter implements TextInputFormatter {
  String _mask = '';
  List<String> _maskChars = <String>[];
  Map<String, RegExp> _maskFilter = <String, RegExp>{};

  int _maskLength = 0;
  final _TextMatcher _resultTextArray = _TextMatcher();
  String _resultTextMasked = '';

  TextEditingValue? _lastResValue;
  TextEditingValue? _lastNewValue;

  ///
  ///
  ///
  MaskTextInputFormatter({
    String mask = '',
    Map<String, RegExp>? filter,
    String initialText = '',
  }) {
    updateMask(
      mask: mask,
      filter: filter ??
          <String, RegExp>{
            '#': RegExp('[0-9]'),
            'A': RegExp('[^0-9]'),
          },
    );

    formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(text: initialText),
    );
  }

  ///
  ///
  ///
  TextEditingValue updateMask({
    String mask = '',
    Map<String, RegExp>? filter,
    bool clear = false,
  }) {
    _mask = mask;

    if (_mask.isEmpty) {
      clear = true;
    }

    if (filter != null) {
      _updateFilter(filter);
    }

    _calcMaskLength();

    String unmaskedText = clear ? '' : getUnmaskedText();

    _resultTextMasked = '';
    _resultTextArray.clear();
    _lastResValue = null;
    _lastNewValue = null;

    return formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(
        text: unmaskedText,
        selection: TextSelection.collapsed(offset: unmaskedText.length),
      ),
    );
  }

  ///
  ///
  ///
  String getMask() => _mask;

  ///
  ///
  ///
  String getMaskedText() => _resultTextMasked;

  ///
  ///
  ///
  String getUnmaskedText() => _resultTextArray.toString();

  ///
  ///
  ///
  bool isFill() => _resultTextArray.length == _maskLength;

  ///
  ///
  ///
  String maskText(String text) => MaskTextInputFormatter(
        mask: _mask,
        filter: _maskFilter,
        initialText: text,
      ).getMaskedText();

  ///
  ///
  ///
  String unmaskText(String text) => MaskTextInputFormatter(
        mask: _mask,
        filter: _maskFilter,
        initialText: text,
      ).getUnmaskedText();

  ///
  ///
  ///
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (_lastResValue == oldValue && newValue == _lastNewValue) {
      return oldValue;
    }
    _lastNewValue = newValue;
    return _lastResValue = _format(oldValue, newValue);
  }

  ///
  ///
  ///
  TextEditingValue _format(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String mask = _mask;

    if (mask.isEmpty) {
      _resultTextMasked = newValue.text;
      _resultTextArray.set(newValue.text);
      return newValue;
    }

    String beforeText = oldValue.text;
    String afterText = newValue.text;

    TextSelection beforeSelection = oldValue.selection;
    int beforeSelectionStart =
        beforeSelection.isValid ? beforeSelection.start : 0;
    int beforeSelectionLength = beforeSelection.isValid
        ? beforeSelection.end - beforeSelection.start
        : 0;

    int lengthDifference =
        afterText.length - (beforeText.length - beforeSelectionLength);
    int lengthRemoved = lengthDifference < 0 ? lengthDifference.abs() : 0;
    int lengthAdded = lengthDifference > 0 ? lengthDifference : 0;

    int afterChangeStart = max(0, beforeSelectionStart - lengthRemoved);
    int afterChangeEnd = max(0, afterChangeStart + lengthAdded);

    int beforeReplaceStart = max(0, beforeSelectionStart - lengthRemoved);
    int beforeReplaceLength = beforeSelectionLength + lengthRemoved;

    int beforeResultTextLength = _resultTextArray.length;

    int currentResultTextLength = _resultTextArray.length;
    int currentResultSelectionStart = 0;
    int currentResultSelectionLength = 0;

    for (int i = 0;
        i < min(beforeReplaceStart + beforeReplaceLength, mask.length);
        i++) {
      if (_maskChars.contains(mask[i]) && currentResultTextLength > 0) {
        currentResultTextLength -= 1;
        if (i < beforeReplaceStart) {
          currentResultSelectionStart += 1;
        }
        if (i >= beforeReplaceStart) {
          currentResultSelectionLength += 1;
        }
      }
    }

    String replacementText =
        afterText.substring(afterChangeStart, afterChangeEnd);
    int targetCursorPosition = currentResultSelectionStart;
    if (replacementText.isEmpty) {
      _resultTextArray.removeRange(
        currentResultSelectionStart,
        currentResultSelectionStart + currentResultSelectionLength,
      );
    } else {
      if (currentResultSelectionLength > 0) {
        _resultTextArray.removeRange(
          currentResultSelectionStart,
          currentResultSelectionStart + currentResultSelectionLength,
        );
      }
      _resultTextArray.insert(currentResultSelectionStart, replacementText);
      targetCursorPosition += replacementText.length;
    }

    if (beforeResultTextLength == 0 && _resultTextArray.length > 1) {
      for (int i = 0; i < mask.length; i++) {
        if (_maskChars.contains(mask[i]) || _resultTextArray.isEmpty) {
          break;
        } else if (mask[i] == _resultTextArray[0]) {
          _resultTextArray.removeAt(0);
        }
      }
    }

    int curTextPos = 0;
    int maskPos = 0;
    _resultTextMasked = '';
    int cursorPos = -1;
    int nonMaskedCount = 0;

    while (maskPos < mask.length) {
      String curMaskChar = mask[maskPos];
      bool isMaskChar = _maskChars.contains(curMaskChar);

      bool curTextInRange = curTextPos < _resultTextArray.length;

      String? curTextChar;
      if (isMaskChar && curTextInRange) {
        while (curTextChar == null && curTextInRange) {
          String potentialTextChar = _resultTextArray[curTextPos];
          if (_maskFilter[curMaskChar]!.hasMatch(potentialTextChar) == true) {
            curTextChar = potentialTextChar;
          } else {
            _resultTextArray.removeAt(curTextPos);
            curTextInRange = curTextPos < _resultTextArray.length;
            if (curTextPos <= targetCursorPosition) {
              targetCursorPosition -= 1;
            }
          }
        }
      }

      if (isMaskChar && curTextInRange && curTextChar != null) {
        _resultTextMasked += curTextChar;
        if (curTextPos == targetCursorPosition && cursorPos == -1) {
          cursorPos = maskPos - nonMaskedCount;
        }
        nonMaskedCount = 0;
        curTextPos += 1;
      } else {
        if (curTextPos == targetCursorPosition &&
            cursorPos == -1 &&
            !curTextInRange) {
          cursorPos = maskPos;
        }

        if (!curTextInRange) {
          break;
        } else {
          _resultTextMasked += mask[maskPos];
        }

        nonMaskedCount++;
      }

      maskPos += 1;
    }

    if (nonMaskedCount > 0) {
      _resultTextMasked = _resultTextMasked.substring(
        0,
        _resultTextMasked.length - nonMaskedCount,
      );
      cursorPos -= nonMaskedCount;
    }

    if (_resultTextArray.length > _maskLength) {
      _resultTextArray.removeRange(_maskLength, _resultTextArray.length);
    }

    int finalCursorPosition =
        cursorPos < 0 ? _resultTextMasked.length : cursorPos;

    return TextEditingValue(
      text: _resultTextMasked,
      selection: TextSelection(
        baseOffset: finalCursorPosition,
        extentOffset: finalCursorPosition,
        affinity: newValue.selection.affinity,
        isDirectional: newValue.selection.isDirectional,
      ),
    );
  }

  ///
  ///
  ///
  void _calcMaskLength() {
    _maskLength = 0;
    String mask = _mask;
    for (int i = 0; i < mask.length; i++) {
      if (_maskChars.contains(mask[i])) {
        _maskLength++;
      }
    }
  }

  ///
  ///
  ///
  void _updateFilter(Map<String, RegExp> filter) {
    _maskFilter = filter;
    _maskChars = _maskFilter.keys.toList(growable: false);
  }
}

///
///
///
class _TextMatcher {
  final List<String> _symbolArray = <String>[];

  ///
  ///
  ///
  int get length =>
      _symbolArray.fold(0, (int prev, String match) => prev + match.length);

  ///
  ///
  ///
  void removeRange(int start, int end) => _symbolArray.removeRange(start, end);

  ///
  ///
  ///
  void insert(int start, String substring) {
    for (int i = 0; i < substring.length; i++) {
      _symbolArray.insert(start + i, substring[i]);
    }
  }

  ///
  ///
  ///
  bool get isEmpty => _symbolArray.isEmpty;

  ///
  ///
  ///
  void removeAt(int index) => _symbolArray.removeAt(index);

  ///
  ///
  ///
  String operator [](int index) => _symbolArray[index];

  ///
  ///
  ///
  void clear() => _symbolArray.clear();

  ///
  ///
  ///
  @override
  String toString() => _symbolArray.join();

  ///
  ///
  ///
  void set(String text) {
    _symbolArray.clear();
    for (int i = 0; i < text.length; i++) {
      _symbolArray.add(text[i]);
    }
  }
}

///
///
///
class UppercaseMask extends MaskTextInputFormatter {
  ///
  ///
  ///
  UppercaseMask({
    super.mask,
    super.filter,
    super.initialText,
  }) : assert(mask.isNotEmpty, 'mask must be not empty.');

  ///
  ///
  ///
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isNotEmpty) {
      newValue = TextEditingValue(
        text: newValue.text.toUpperCase(),
        selection: newValue.selection,
        composing: newValue.composing,
      );
    }

    return super.formatEditUpdate(oldValue, newValue);
  }
}

///
///
///
class ChangeMask extends MaskTextInputFormatter {
  final String firstMask;
  final String secondMask;

  ///
  ///
  ///
  ChangeMask({
    required this.firstMask,
    required this.secondMask,
    super.filter,
    super.initialText,
  })  : assert(firstMask.isNotEmpty, 'firstMask must be not empty.'),
        assert(secondMask.isNotEmpty, 'secondMask must be not empty.'),
        assert(
          firstMask.length < secondMask.length,
          'firstMask length must be lower than secondMask length.',
        ),
        super(
          mask: firstMask,
        );

  ///
  ///
  ///
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // print(hashCode);
    // print('oldValue (${oldValue.text.length}): ${oldValue.text}');
    // print('newValue (${newValue.text.length}): ${newValue.text}');

    int oldLength = oldValue.text.length;
    int newLength = newValue.text.length;

    if (oldLength == firstMask.length && newLength == firstMask.length + 1) {
      // print('1 => 2');
      oldValue = updateMask(mask: secondMask);
    }

    if (oldLength == firstMask.length + 1 && newLength == firstMask.length) {
      // print('2 => 1');
      oldValue = updateMask(mask: firstMask);
    }

    return super.formatEditUpdate(oldValue, newValue);
  }
}
