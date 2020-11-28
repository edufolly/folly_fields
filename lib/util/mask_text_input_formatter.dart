import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

///
///
///
class MaskTextInputFormatter extends TextInputFormatter {
  String _mask;
  List<String> _maskChars;
  Map<String, RegExp> _maskFilter;

  int _maskLength;
  final List<String> _resultTextArray = <String>[];
  String _resultTextMasked = '';

  TextEditingValue _lastResValue;
  TextEditingValue _lastNewValue;

  ///
  ///
  ///
  MaskTextInputFormatter({
    String mask,
    Map<String, RegExp> filter,
  }) {
    updateMask(
      mask: mask,
      filter: filter ??
          <String, RegExp>{
            '#': RegExp(r'[0-9]'),
            'A': RegExp(r'[^0-9]'),
          },
    );
  }

  ///
  ///
  ///
  TextEditingValue updateMask({
    String mask,
    Map<String, RegExp> filter,
    bool clear = false,
  }) {
    _mask = mask;
//    _lastResValue = null;
//    _lastNewValue = null;
    if (_mask == null) clear = true;
    if (filter != null) _updateFilter(filter);
    _calcMaskLength();
    final String unmaskedText = clear ? '' : getUnmaskedText();
    _resultTextArray.clear();
    _resultTextMasked = '';
    return _formatUpdate(
      TextEditingValue(),
      TextEditingValue(
        text: unmaskedText,
        selection: TextSelection(
          baseOffset: unmaskedText.length,
          extentOffset: unmaskedText.length,
        ),
      ),
    );
  }

  ///
  ///
  ///
  String getMaskedText() => _resultTextMasked;

  ///
  ///
  ///
  String getUnmaskedText() => _resultTextArray.join();

  ///
  ///
  ///
  bool isFill() => _resultTextArray.length == _maskLength;

  ///
  ///
  ///
  String getMask() => _mask;

  ///
  ///
  ///
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (_lastResValue == oldValue && newValue == _lastNewValue) {
      return _lastResValue;
    }
    _lastNewValue = newValue;
    _lastResValue = _formatUpdate(oldValue, newValue);
    return _lastResValue;
  }

  ///
  ///
  ///
  TextEditingValue _formatUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (_mask == null) return newValue;

    final TextSelection selectionBefore = oldValue.selection;

    final String textBefore = oldValue.text;
    final String textAfter = newValue.text;

    final int startBefore = selectionBefore.start == -1 ? 0 : selectionBefore.start;
    final int countBefore = selectionBefore.start == -1 || selectionBefore.end == -1
        ? 0
        : selectionBefore.end - selectionBefore.start;

    final int after = textAfter.length - (textBefore.length - countBefore);
    final int removed = after < 0 ? after.abs() : 0;

    final int startAfter = max(0, startBefore + (after < 0 ? after : 0));
    final int endAfter = max(0, startAfter + (after > 0 ? after : 0));

    final int replaceStart = max(0, startBefore - removed);
    final int replaceLength = countBefore + removed;

    final int beforeResultTextLength = _resultTextArray.length;

    int currentTotalText = _resultTextArray.length;
    int selectionStart = 0;
    int selectionLength = 0;
    for (int i = 0; i < replaceStart + replaceLength; i++) {
      if (_maskChars.contains(_mask[i]) && currentTotalText > 0) {
        currentTotalText -= 1;
        if (i < replaceStart) {
          selectionStart += 1;
        }
        if (i >= replaceStart) {
          selectionLength += 1;
        }
      }
    }

    final String replacementText = textAfter.substring(startAfter, endAfter);
    int targetCursorPosition = selectionStart;
    if (replacementText.isEmpty) {
      _resultTextArray.removeRange(
        selectionStart,
        selectionStart + selectionLength,
      );
    } else {
      if (selectionLength > 0) {
        _resultTextArray.removeRange(
          selectionStart,
          selectionStart + selectionLength,
        );
      }
      _insertToResultText(selectionStart, replacementText);
      targetCursorPosition += replacementText.length;
    }

    if (beforeResultTextLength == 0 && _resultTextArray.length > 1) {
      for (int i = 0; i < _mask.length; i++) {
        if (_maskChars.contains(_mask[i]) || _resultTextArray.isEmpty) {
          break;
        } else if (_mask[i] == _resultTextArray[0]) {
          _resultTextArray.removeAt(0);
        }
      }
    }

    int curTextPos = 0;
    int maskPos = 0;
    _resultTextMasked = '';
    int cursorPos = -1;
    int nonMaskedCount = 0;

    while (maskPos < _mask.length) {
      final String curMaskChar = _mask[maskPos];
      final bool isMaskChar = _maskChars.contains(curMaskChar);

      bool curTextInRange = curTextPos < _resultTextArray.length;

      String curTextChar;
      if (isMaskChar && curTextInRange) {
        while (curTextChar == null && curTextInRange) {
          final String potentialTextChar = _resultTextArray[curTextPos];
          if (_maskFilter[curMaskChar].hasMatch(potentialTextChar)) {
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

      if (isMaskChar && curTextInRange) {
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
          _resultTextMasked += _mask[maskPos];
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
    cursorPos == -1 ? _resultTextMasked.length : cursorPos;

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
  void _insertToResultText(int start, String substring) {
    for (int i = 0; i < substring.length; i++) {
      _resultTextArray.insert(start + i, substring[i]);
    }
  }

  ///
  ///
  ///
  void _calcMaskLength() {
    _maskLength = 0;
    if (_mask != null) {
      for (int i = 0; i < _mask.length; i++) {
        if (_maskChars.contains(_mask[i])) {
          _maskLength++;
        }
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
class ChangeMask extends MaskTextInputFormatter {
  final String firstMask;
  final String secondMask;

  ///
  ///
  ///
  ChangeMask({
    @required this.firstMask,
    @required this.secondMask,
  })  : assert(firstMask != null),
        assert(secondMask != null),
        assert(firstMask.length < secondMask.length),
        super(mask: firstMask);

  ///
  ///
  ///
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (oldValue.text.length == firstMask.length &&
        newValue.text.length == firstMask.length + 1) {
      oldValue = updateMask(mask: secondMask);
    }

    if (oldValue.text.length == firstMask.length + 1 &&
        newValue.text.length == firstMask.length) {
      oldValue = updateMask(mask: firstMask);
    }

    return super.formatEditUpdate(oldValue, newValue);
  }
}
