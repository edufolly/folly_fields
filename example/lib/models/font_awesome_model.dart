import 'package:flutter/material.dart';
import 'package:folly_fields_example/models/abstract_base_model.dart';

class FontAwesomeModel extends AbstractBaseModel<String> {
  IconData? iconData;

  FontAwesomeModel({super.id, this.iconData});

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{if (id != null) 'id': id};

  @override
  String toString() => '$id';
}
