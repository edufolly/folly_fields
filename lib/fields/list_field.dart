import 'package:flutter/material.dart';
import 'package:folly_fields/controllers/list_field_controller.dart';
import 'package:folly_fields/extensions/list_extension.dart';
import 'package:folly_fields/extensions/scope_extension.dart';
import 'package:folly_fields/responsive/responsive_form_field.dart';
import 'package:folly_fields/widgets/folly_dialogs.dart';
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
  final String addButtonLabel;
  final Future<List<T>?> Function(BuildContext context, List<T> data)?
  addButtonOnTap;
  final bool Function(T model)? canDelete;
  final IconData deleteIcon;
  final String Function(BuildContext context, T model)? deleteMessage;
  final String deleteDefaultMessage;
  final Future<T?> Function(BuildContext context, T model)? itemOnTap;
  final int Function(T a, T b)? sort;

  ListField({
    this.controller,
    this.focusNode,
    this.getLeading,
    this.getTitle,
    this.getSubtitle,
    String? labelPrefix,
    String? label,
    Widget? labelWidget,
    FormFieldValidator<List<T>?>? validator,
    super.onSaved,
    List<T>? initialValue,
    super.enabled,
    super.autovalidateMode = AutovalidateMode.disabled,
    InputDecoration? decoration,
    EdgeInsets padding = const EdgeInsets.all(8),
    EdgeInsets? contentPadding,
    bool showAddButton = true,
    this.addButtonIcon = FontAwesomeIcons.plus,
    this.addButtonLabel = 'Adicionar',
    this.addButtonOnTap,
    this.canDelete,
    this.deleteIcon = FontAwesomeIcons.trashCan,
    this.deleteMessage,
    this.deleteDefaultMessage = 'Deseja excluir o ítem?',
    this.itemOnTap,
    this.sort,
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
         builder: (FormFieldState<List<T>?> field) {
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
                 // cursor: enabled
                 //     ? SystemMouseCursors.click
                 //     : SystemMouseCursors.basic,
                 onEnter: (_) => state.hovering(enter: true),
                 onExit: (_) => state.hovering(enter: false),
                 child: InputDecorator(
                   decoration: effectiveDecoration,
                   isFocused: hasFocus,
                   isHovering: state._isHovering,
                   child: ValueListenableBuilder<List<T>>(
                     valueListenable: state._effectiveController,
                     builder: (_, List<T> value, _) {
                       return Column(
                         mainAxisSize: MainAxisSize.min,
                         crossAxisAlignment: CrossAxisAlignment.stretch,
                         children: <Widget>[
                           /// Add Button
                           if (showAddButton)
                             _ListAddButton<T>(state, sort, enabled: enabled),

                           /// List Items
                           ...value.map(
                             (T model) => _ListItem<T>(
                               context: state.context,
                               widget: state.widget,
                               focusNode: state._effectiveFocusNode,
                               model: model,
                               enabled: enabled,
                               onRemove: (T model) =>
                                   state.didChange(state.value?..remove(model)),
                               onTap: isNull(state.widget.itemOnTap) && !enabled
                                   ? null
                                   : (T model) async {
                                       final T? newModel = await state
                                           .widget
                                           .itemOnTap
                                           ?.call(state.context, model);

                                       if (newModel == null) return;

                                       if (sort != null) {
                                         state.value?.sort(sort);
                                       }

                                       state.didChange(state.value);
                                     },
                             ),
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
  final int Function(T a, T b)? sort;
  final bool enabled;

  const _ListAddButton(
    this.state,
    this.sort, {
    required this.enabled,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FilledButton.icon(
        icon: Icon(state.widget.addButtonIcon),
        label: Text(state.widget.addButtonLabel),
        onPressed: isNull(state.widget.addButtonOnTap) || !enabled
            ? null
            : () async {
                state._effectiveFocusNode.requestFocus();

                final List<T>? newItems = await state.widget.addButtonOnTap
                    ?.call(state.context, List<T>.of(state.value ?? <T>[]));

                if (isNotNull(newItems)) {
                  state.value!
                    ..clear()
                    ..addAll(newItems!);

                  if (sort != null) state.value!.sort(sort);

                  state.didChange(state.value);
                }
              },
      ),
    );
  }
}

class _ListItem<T> extends StatelessWidget {
  final BuildContext context;
  final ListField<T> widget;
  final T model;
  final bool enabled;
  final void Function(T model) onRemove;
  final FocusNode? focusNode;
  final Future<void> Function(T model)? onTap;

  const _ListItem({
    required this.context,
    required this.widget,
    required this.model,
    required this.enabled,
    required this.onRemove,
    this.focusNode,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: enabled,
      onTap: onTap != null && enabled ? () => onTap?.call(model) : null,
      leading: widget.getLeading?.call(context, model, enabled: enabled),
      title:
          widget.getTitle?.call(context, model, enabled: enabled) ??
          Text(model.toString()),
      subtitle: widget.getSubtitle?.call(context, model, enabled: enabled),
      trailing: (widget.canDelete?.call(model) ?? true)
          ? IconButton(
              icon: Icon(widget.deleteIcon),
              onPressed: enabled
                  ? () async {
                      focusNode?.requestFocus();

                      final bool go = await FollyDialogs.yesNoDialog(
                        context: context,
                        message:
                            widget.deleteMessage?.call(context, model) ??
                            widget.deleteDefaultMessage,
                      );

                      if (go) onRemove(model);
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

  void hovering({required bool enter}) => setState(() => _isHovering = enter);

  @override
  void didChange(List<T>? value) {
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

  @override
  void dispose() {
    _effectiveController.removeListener(_handleControllerChanged);
    _controller?.dispose();

    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _focusNode?.dispose();

    super.dispose();
  }
}
