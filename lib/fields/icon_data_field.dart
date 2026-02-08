import 'package:flutter/material.dart';
import 'package:folly_fields/controllers/icon_data_field_controller.dart';
import 'package:folly_fields/extensions/scope_extension.dart';
import 'package:folly_fields/responsive/responsive_form_field.dart';
import 'package:folly_fields/widgets/animated_search.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconDataField extends ResponsiveFormField<IconData> {
  final IconDataFieldController? controller;
  final Map<String, IconData> icons;

  IconDataField({
    required this.icons,
    final String? labelPrefix,
    final String? label,
    final Widget? labelWidget,
    this.controller,
    final FormFieldValidator<IconData>? validator,
    super.onSaved,
    final IconData? initialValue,
    super.enabled,
    final AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    final bool filled = false,
    final Color? fillColor,
    final double iconSize = 32.0,
    final double maxCrossAxisExtent = 40.0,
    final double mainAxisSpacing = 6.0,
    final double crossAxisSpacing = 6.0,
    final double height = 128.0,
    final double spaceBetween = 16.0,
    final InputDecoration? decoration,
    final EdgeInsets padding = const EdgeInsets.all(8),
    final String? hintText,
    final EdgeInsets? contentPadding,
    final bool showClearSelectionButton = true,
    super.sizeExtraSmall,
    super.sizeSmall,
    super.sizeMedium,
    super.sizeLarge,
    super.sizeExtraLarge,
    super.minHeight,
    super.key,
  }) : assert(
         initialValue == null || controller == null,
         'initialValue or controller must be null.',
       ),
       assert(
         label == null || labelWidget == null,
         'label or labelWidget must be null.',
       ),
       super(
         initialValue: controller != null ? controller.value : initialValue,
         validator: enabled ? validator : null,
         autovalidateMode: autoValidateMode,
         builder: (final FormFieldState<IconData> field) {
           _IconDataFieldState state = field as _IconDataFieldState;

           InputDecoration effectiveDecoration =
               (decoration ??
                       InputDecoration(
                         border: const OutlineInputBorder(),
                         filled: filled,
                         fillColor: fillColor,
                         label: labelWidget,
                         labelText: <String?>[
                           labelPrefix,
                           label,
                         ].nonNulls.join(' - '),
                         counterText: '',
                         hintText: hintText,
                         contentPadding:
                             contentPadding ??
                             const EdgeInsets.fromLTRB(12, 0, 8, 12),
                       ))
                   .applyDefaults(Theme.of(field.context).inputDecorationTheme);

           return Padding(
             padding: padding,
             child: InputDecorator(
               decoration: effectiveDecoration.copyWith(
                 errorText: enabled ? field.errorText : null,
               ),
               child: Column(
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.only(top: 16),
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: <Widget>[
                         Expanded(
                           child: isNull(state.value)
                               ? Container()
                               : Padding(
                                   padding: const EdgeInsets.only(
                                     left: 8,
                                     right: 16,
                                   ),
                                   child: Row(
                                     children: <Widget>[
                                       Icon(state.value, size: iconSize),
                                       const SizedBox(width: 16),
                                       Chip(
                                         label: Text(
                                           state._effectiveController.name,
                                         ),
                                       ),
                                       if (showClearSelectionButton)
                                         const SizedBox(width: 8),
                                       if (showClearSelectionButton)
                                         IconButton(
                                           icon: const Icon(
                                             FontAwesomeIcons.xmark,
                                           ),
                                           onPressed: () =>
                                               state.didChange(null),
                                         ),
                                     ],
                                   ),
                                 ),
                         ),
                         AnimatedSearch(controller: state._textController),
                       ],
                     ),
                   ),
                   Padding(
                     padding: EdgeInsets.only(top: spaceBetween),
                     child: SizedBox(
                       height: height,
                       child: Scrollbar(
                         controller: state._scrollController,
                         child: GridView.builder(
                           controller: state._scrollController,
                           gridDelegate:
                               SliverGridDelegateWithMaxCrossAxisExtent(
                                 maxCrossAxisExtent: maxCrossAxisExtent,
                                 mainAxisSpacing: mainAxisSpacing,
                                 crossAxisSpacing: crossAxisSpacing,
                               ),
                           itemCount: state.names.length,
                           itemBuilder:
                               (final BuildContext context, final int index) {
                                 IconData iconData = state
                                     ._effectiveController
                                     .icons[state.names[index]]!;

                                 return GestureDetector(
                                   onTap: () => state.didChange(iconData),
                                   child: Icon(iconData, size: iconSize),
                                 );
                               },
                         ),
                       ),
                     ),
                   ),
                 ],
               ),
             ),
           );
         },
       );

  @override
  FormFieldState<IconData> createState() => _IconDataFieldState();
}

class _IconDataFieldState extends FormFieldState<IconData> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  IconDataFieldController? _controller;
  List<String> names = <String>[];

  @override
  IconDataField get widget => super.widget as IconDataField;

  IconDataFieldController get _effectiveController =>
      widget.controller ?? _controller!;

  @override
  void initState() {
    super.initState();

    _textController.addListener(_handleSearch);

    if (widget.controller == null) {
      _controller = IconDataFieldController(
        value: widget.initialValue,
        icons: widget.icons,
      );
    } else {
      widget.controller!.addListener(_handleControllerChanged);
    }

    names = _effectiveController.icons.keys.toList();
  }

  @override
  void didUpdateWidget(final IconDataField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);

      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = IconDataFieldController.fromValue(oldWidget.controller!);
      }

      if (widget.controller != null) {
        setValue(widget.controller!.value);

        if (oldWidget.controller == null) {
          _controller = null;
        }
      }
    }
  }

  @override
  void dispose() {
    _textController.removeListener(_handleSearch);
    widget.controller?.removeListener(_handleControllerChanged);
    _scrollController.dispose();
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChange(final IconData? value) {
    super.didChange(value);
    if (_effectiveController.value != value) {
      _effectiveController.value = value;
    }
  }

  @override
  void reset() {
    super.reset();
    setState(() => _effectiveController.value = widget.initialValue);
  }

  void _handleSearch() {
    String text = _textController.text.toLowerCase();

    names = _effectiveController.icons.keys
        .where((final String key) => key.toLowerCase().contains(text))
        .toList();

    // ignore: no-empty-block
    setState(() {});
  }

  void _handleControllerChanged() {
    if (_effectiveController.value != value) {
      didChange(_effectiveController.value);
    }
  }
}
