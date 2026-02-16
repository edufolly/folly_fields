import 'package:flutter/material.dart';
import 'package:folly_fields/controllers/list_field_controller.dart';
import 'package:folly_fields/extensions/list_extension.dart';
import 'package:folly_fields/extensions/scope_extension.dart';
import 'package:folly_fields/responsive/responsive_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListField<T> extends ResponsiveFormField<List<T>> {
  final ListFieldController<T>? controller;
  final FocusNode? focusNode;
  final Widget? Function(
    BuildContext context,
    T model, {
    required bool enabled,
  })?
  getLeading;
  final Widget? Function(
    BuildContext context,
    T model, {
    required bool enabled,
  })?
  getTitle;
  final Widget? Function(
    BuildContext context,
    T model, {
    required bool enabled,
  })?
  getSubtitle;
  final IconData addButtonIcon;
  final String addButtonMessage;
  final Future<List<T>?> Function(BuildContext context, List<T> data)?
  addButtonOnTap;
  final bool Function(T model)? canDelete;
  final IconData deleteIcon;

  ListField({
    this.controller,
    this.focusNode,
    this.getLeading,
    this.getTitle,
    this.getSubtitle,
    final String? labelPrefix,
    final String? label,
    final Widget? labelWidget,
    final FormFieldValidator<List<T>?>? validator,
    super.onSaved,
    final List<T>? initialValue,
    super.enabled,
    final AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    final InputDecoration? decoration,
    final EdgeInsets padding = const EdgeInsets.all(8),
    final EdgeInsets? contentPadding,
    final bool showAddButton = true,
    this.addButtonIcon = FontAwesomeIcons.plus,
    this.addButtonMessage = 'Adicionar',
    this.addButtonOnTap,
    this.canDelete,
    this.deleteIcon = FontAwesomeIcons.trashCan,
    // TODO(edufolly): Delete before ask.
    // TODO(edufolly): Item on tap event.
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
         builder: (final FormFieldState<List<T>?> field) {
           final _ListFieldState<T> state = field as _ListFieldState<T>;

           final ThemeData theme = Theme.of(state.context);

           final bool hasFocus = state._effectiveFocusNode.hasFocus;

           final InputDecoration effectiveDecoration =
               (decoration ??
                       InputDecoration(
                         border: const OutlineInputBorder(),
                         counterText: '',
                         label: labelWidget,
                         labelText: <String?>[
                           labelPrefix,
                           label,
                         ].nonNulls.join(' - '),
                         contentPadding: contentPadding,
                       ))
                   .applyDefaults(theme.inputDecorationTheme)
                   .copyWith(enabled: enabled, errorText: state.errorText);

           return Padding(
             padding: padding,
             child: Focus(
               focusNode: state._effectiveFocusNode,
               canRequestFocus: enabled,
               skipTraversal: !enabled,
               child: MouseRegion(
                 cursor: enabled
                     ? SystemMouseCursors.click
                     : SystemMouseCursors.basic,
                 onEnter: (_) => state.hovering(enter: true),
                 onExit: (_) => state.hovering(enter: false),
                 child: InputDecorator(
                   decoration: effectiveDecoration,
                   isFocused: hasFocus,
                   isHovering: state._isHovering,
                   child: ValueListenableBuilder<List<T>>(
                     valueListenable: state._effectiveController,
                     builder: (_, final List<T> value, _) {
                       return Column(
                         mainAxisSize: MainAxisSize.min,
                         crossAxisAlignment: CrossAxisAlignment.stretch,
                         children: <Widget>[
                           /// Add Button
                           if (showAddButton)
                             _ListAddButton<T>(state, enabled: enabled),

                           /// List Items
                           ...value.map(
                             (final T model) =>
                                 _ListItem<T>(state, model, enabled: enabled),
                           ),
                         ].intersperse(const Divider()),
                       );
                     },
                   ),
                 ),
               ),
             ),
           );
         },
       );

  @override
  FormFieldState<List<T>> createState() => _ListFieldState<T>();
}

class _ListAddButton<T> extends StatelessWidget {
  final _ListFieldState<T> state;
  final bool enabled;

  const _ListAddButton(this.state, {required this.enabled, super.key});

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FilledButton.icon(
        icon: Icon(state.widget.addButtonIcon),
        label: Text(state.widget.addButtonMessage),
        onPressed: isNull(state.widget.addButtonOnTap) || !enabled
            ? null
            : () async {
                state._effectiveFocusNode.requestFocus();

                final List<T>? newItems = await state.widget.addButtonOnTap
                    ?.call(state.context, state.value ?? <T>[]);

                if (isNotNull(newItems)) {
                  state.didChange(
                    state.value
                      ?..clear()
                      ..addAll(newItems!),
                  );
                }
              },
      ),
    );
  }
}

class _ListItem<T> extends StatelessWidget {
  final _ListFieldState<T> state;
  final T model;
  final bool enabled;

  const _ListItem(this.state, this.model, {required this.enabled, super.key});

  @override
  Widget build(final BuildContext context) {
    return ListTile(
      enabled: enabled,
      leading: state.widget.getLeading?.call(
        state.context,
        model,
        enabled: enabled,
      ),
      title:
          state.widget.getTitle?.call(state.context, model, enabled: enabled) ??
          Text(model.toString()),
      subtitle: state.widget.getSubtitle?.call(
        state.context,
        model,
        enabled: enabled,
      ),
      trailing: (state.widget.canDelete?.call(model) ?? true)
          ? IconButton(
              icon: Icon(state.widget.deleteIcon),
              onPressed: enabled
                  ? () {
                      state._effectiveFocusNode.requestFocus();
                      state.didChange(state.value?..remove(model));
                    }
                  : null,
            )
          : null,
    );
  }
}

class _ListFieldState<T> extends FormFieldState<List<T>> {
  ListFieldController<T>? _controller;
  FocusNode? _focusNode;
  bool _isHovering = false;

  @override
  ListField<T> get widget => super.widget as ListField<T>;

  ListFieldController<T> get _effectiveController =>
      widget.controller ?? _controller!;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode!;

  @override
  void initState() {
    super.initState();
    if (isNull(widget.controller)) {
      _controller = ListFieldController<T>(value: widget.initialValue);
    }
    _effectiveController.addListener(_handleControllerChanged);

    if (isNull(widget.focusNode)) {
      _focusNode = FocusNode();
    }
    _effectiveFocusNode.addListener(_handleFocusChanged);
  }

  void hovering({required final bool enter}) =>
      setState(() => _isHovering = enter);

  // @override
  // void didUpdateWidget(final ListField<T> oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (widget.controller != oldWidget.controller) {
  //     oldWidget.controller?.removeListener(_handleControllerChanged);
  //
  //     widget.controller?.addListener(_handleControllerChanged);
  //
  //     if (oldWidget.controller != null && widget.controller == null) {
  //     _controller = ListFieldController<T>.fromValue(oldWidget.controller!);
  //     }
  //
  //     if (widget.controller != null) {
  //       setValue(widget.controller!.value);
  //
  //       if (oldWidget.controller == null) {
  //         _controller = null;
  //       }
  //     }
  //   }
  // }

  @override
  void didChange(final List<T>? value) {
    super.didChange(value);
    if (_effectiveController.value != value) {
      _effectiveController.value = value ?? <T>[];
    }
  }

  void _handleControllerChanged() {
    if (_effectiveController.value != value) {
      didChange(_effectiveController.value);
    }
  }

  void _handleFocusChanged() => setState(() {});

  @override
  void reset() {
    super.reset();
    // setState(() => _effectiveController.value = widget.initialValue ?? <T>[])
    _effectiveController.value = widget.initialValue ?? <T>[];
  }

  // void update(
  //   final T element, {
  //   required final bool selected,
  //   required final bool multiple,
  // }) {
  //   final List<T> value = List<T>.from(_effectiveController.value);
  //
  //   if (selected) {
  //     value.add(element);
  //   } else {
  //     value.remove(element);
  //   }
  //
  //   didChange(value);
  // }

  @override
  void dispose() {
    _effectiveController.removeListener(_handleControllerChanged);
    _controller?.dispose();

    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _focusNode?.dispose();

    super.dispose();
  }
}
