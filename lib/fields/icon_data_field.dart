import 'package:flutter/material.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields/widgets/animated_search.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class IconDataField extends FormFieldResponsive<IconData> {
  final IconFieldController? controller;
  final Map<String, IconData> icons;

  ///
  ///
  ///
  IconDataField({
    String labelPrefix = '',
    String? label,
    Widget? labelWidget,
    this.controller,
    FormFieldValidator<IconData>? validator,
    super.onSaved,
    IconData? initialValue,
    this.icons = const <String, IconData>{},
    super.enabled,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    bool filled = false,
    Color? fillColor,
    double iconSize = 32.0,
    double maxCrossAxisExtent = 40.0,
    double mainAxisSpacing = 6.0,
    double crossAxisSpacing = 6.0,
    double height = 128.0,
    double spaceBetween = 16.0,
    InputDecoration? decoration,
    EdgeInsets padding = const EdgeInsets.all(8),
    super.sizeExtraSmall,
    super.sizeSmall,
    super.sizeMedium,
    super.sizeLarge,
    super.sizeExtraLarge,
    super.minHeight,
    super.key,
  })  : assert(
          initialValue == null || controller == null,
          'initialValue or controller must be null.',
        ),
        assert(
          label == null || labelWidget == null,
          'label or labelWidget must be null.',
        ),
        super(
          initialValue: controller != null ? controller.value : initialValue,
          validator: enabled ? validator : (_) => null,
          autovalidateMode: autoValidateMode,
          builder: (FormFieldState<IconData> field) {
            IconDataFieldState state = field as IconDataFieldState;

            InputDecoration effectiveDecoration = (decoration ??
                    InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: filled,
                      fillColor: fillColor,
                      label: labelWidget,
                      labelText:
                          labelPrefix.isEmpty ? label : '$labelPrefix - $label',
                      counterText: '',
                      contentPadding: const EdgeInsets.fromLTRB(12, 0, 8, 12),
                    ))
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            Map<String, IconData> controllerIcons =
                state._effectiveController.icons;

            List<String> keys = state.names;

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
                            child: state.value == null
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8,
                                      right: 16,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        FaIcon(
                                          state.value,
                                          size: iconSize,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Text(
                                            state._effectiveController.name,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                          ),
                          AnimatedSearch(
                            controller: state._textController,
                          ),
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
                            itemCount: keys.length,
                            itemBuilder: (BuildContext context, int index) {
                              IconData iconData = controllerIcons[keys[index]]!;
                              return GestureDetector(
                                onTap: () => state.didChange(iconData),
                                child: Align(
                                  child: FaIcon(
                                    iconData,
                                    size: iconSize,
                                  ),
                                ),
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

  ///
  ///
  ///
  @override
  IconDataFieldState createState() => IconDataFieldState();
}

///
///
///
class IconDataFieldState extends FormFieldState<IconData> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  IconFieldController? _controller;
  List<String> names = <String>[];

  ///
  ///
  ///
  @override
  IconDataField get widget => super.widget as IconDataField;

  ///
  ///
  ///
  IconFieldController get _effectiveController =>
      widget.controller ?? _controller!;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();

    _textController.addListener(_handleSearch);

    if (widget.controller == null) {
      _controller = IconFieldController(
        value: widget.initialValue,
        icons: widget.icons,
      );
    } else {
      widget.controller!.addListener(_handleControllerChanged);
    }

    names = _effectiveController.icons.keys.toList();
  }

  ///
  ///
  ///
  @override
  void didUpdateWidget(IconDataField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);

      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = IconFieldController.fromValue(oldWidget.controller!);
      }

      if (widget.controller != null) {
        setValue(widget.controller!.value);

        if (oldWidget.controller == null) {
          _controller = null;
        }
      }
    }
  }

  ///
  ///
  ///
  @override
  void dispose() {
    _textController.removeListener(_handleSearch);
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  ///
  ///
  ///
  @override
  void didChange(IconData? value) {
    super.didChange(value);
    if (_effectiveController.value != value) {
      _effectiveController.value = value;
    }
  }

  ///
  ///
  ///
  @override
  void reset() {
    super.reset();
    setState(() => _effectiveController.value = widget.initialValue);
  }

  ///
  ///
  ///
  void _handleSearch() {
    String text = _textController.text.toLowerCase();

    names = _effectiveController.icons.keys
        .where((String key) => key.toLowerCase().contains(text))
        .toList();

    setState(() {});
  }

  ///
  ///
  ///
  void _handleControllerChanged() {
    if (_effectiveController.value != value) {
      didChange(_effectiveController.value);
    }
  }
}

///
///
///
class IconFieldController extends ValueNotifier<IconData?> {
  Map<String, IconData> _icons;

  ///
  ///
  ///
  IconFieldController({
    IconData? value,
    Map<String, IconData> icons = const <String, IconData>{},
  })  : _icons = icons,
        super(value);

  ///
  ///
  ///
  IconFieldController.fromValue(IconFieldController controller)
      : _icons = controller.icons,
        super(controller.value);

  ///
  ///
  ///
  Map<String, IconData> get icons => _icons;

  ///
  ///
  ///
  set icons(Map<String, IconData> icons) {
    _icons = icons;
    super.notifyListeners();
  }

  ///
  ///
  ///
  String get name {
    if (value == null) {
      return '';
    }

    return _icons.keys.firstWhere(
      (String key) => _icons[key] == value,
      orElse: () => '',
    );
  }
}
