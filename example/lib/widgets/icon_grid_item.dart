import 'package:flutter/material.dart';
import 'package:folly_fields/extensions/list_extension.dart';
import 'package:folly_fields/extensions/string_extension.dart';
import 'package:folly_fields_example/models/font_awesome_model.dart';

class IconGridItem extends StatelessWidget {
  final FontAwesomeModel model;

  const IconGridItem({required this.model, super.key});

  @override
  Widget build(BuildContext context) => Tooltip(
      waitDuration: const Duration(seconds: 2),
      message: model.id,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget?>[
            Icon(model.iconData, size: 32),
            model.id == null
                ? null
                : Text(
                    model.id!.splitCase.capitalizeWords,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
          ].nonNulls.toList().intersperse(SizedBox(height: 8)),
        ),
      ),
    );
}
