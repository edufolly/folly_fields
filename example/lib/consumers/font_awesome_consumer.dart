import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:folly_fields/extensions/string_extension.dart';
import 'package:folly_fields/util/icon_helper.dart';
import 'package:folly_fields_example/models/font_awesome_model.dart';

class FontAwesomeConsumer {
  static Future<List<FontAwesomeModel>> list(
    int page,
    int size,
    String? search,
  ) async {
    final start = page * size;
    if (isNullOrBlank(search)) {
      return _transform(start, size, IconHelper.unique.entries.toList());
    }

    return _transform(
      start,
      size,
      IconHelper.data.entries
          .where((e) => e.key.toLowerCase().contains(search!))
          .toList(),
    );
  }

  static List<FontAwesomeModel> _transform(
    int start,
    int size,
    List<MapEntry<String, IconData>> list,
  ) => list
      .sublist(start, min(start + size, list.length))
      .map((e) => FontAwesomeModel(id: e.key, iconData: e.value))
      .toList();
}
