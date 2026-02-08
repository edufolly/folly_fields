import 'package:flutter/material.dart';
import 'package:folly_fields/controllers/list_field_controller.dart';
import 'package:folly_fields/extensions/scope_extension.dart';
import 'package:folly_fields/responsive/responsive_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sprintf/sprintf.dart';

class ListField<T> extends ResponsiveFormField<List<T>> {
  final ListFieldController<T>? controller;
  final Widget? Function(BuildContext context, T model)? getLeading;
  final Widget? Function(BuildContext context, T model)? getTitle;
  final Widget? Function(BuildContext context, T model)? getSubtitle;
  final IconData addButtonIcon;
  final String? addButtonEntity;
  final String addButtonMessage;
  final Future<List<T>?> Function(BuildContext context, List<T> data)?
  addButtonOnTap;
  final bool Function(T model)? canDelete;
  final IconData deleteIcon;

  ListField({
    this.getLeading,
    this.getTitle,
    this.getSubtitle,
    final double height = 250,
    final String? labelPrefix,
    final String? label,
    final Widget? labelWidget,
    this.controller,
    final FormFieldValidator<List<T>?>? validator,
    super.onSaved,
    final List<T>? initialValue,
    super.enabled,
    final AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    final bool filled = false,
    final Color? fillColor,
    final Color? focusColor,
    final InputDecoration? decoration,
    final EdgeInsets padding = const EdgeInsets.all(8),
    final String? hintText,
    final EdgeInsets? contentPadding,
    final bool showAddButton = true,
    this.addButtonIcon = FontAwesomeIcons.plus,
    this.addButtonEntity,
    this.addButtonMessage = 'Adicionar %s',
    this.addButtonOnTap,
    this.canDelete,
    this.deleteIcon = FontAwesomeIcons.trashCan,
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

           final InputDecoration effectiveDecoration =
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
                         focusColor: focusColor,
                         hintText: hintText,
                         contentPadding: contentPadding,
                         // prefix: prefix,
                         // suffix: suffix,
                       ))
                   .applyDefaults(Theme.of(field.context).inputDecorationTheme);

           return SizedBox(
             height: height,
             child: Padding(
               padding: padding,
               child: InputDecorator(
                 decoration: effectiveDecoration.copyWith(
                   errorText: enabled ? field.errorText : null,
                   enabled: enabled,
                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                   children: <Widget>[
                     // Add Button
                     if (showAddButton) _ListAddButton<T>(state),

                     // List
                     Expanded(
                       child: ValueListenableBuilder<List<T>>(
                         valueListenable: state._effectiveController,
                         builder: (_, final List<T> value, _) => Column(
                           children: <Widget>[
                             if (showAddButton && value.isNotEmpty)
                               const Divider(),
                             Expanded(child: _ListBuilder<T>(state, value)),
                           ],
                         ),
                       ),
                     ),
                   ],
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

  const _ListAddButton(this.state, {super.key});

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FilledButton.icon(
        icon: Icon(state.widget.addButtonIcon),
        label: Text(
          sprintf(state.widget.addButtonMessage, <dynamic>[
            state.widget.addButtonEntity,
          ]),
        ),
        onPressed: isNull(state.widget.addButtonOnTap)
            ? null
            : () async {
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

class _ListBuilder<T> extends StatelessWidget {
  final _ListFieldState<T> state;
  final List<T> data;

  const _ListBuilder(this.state, this.data, {super.key});

  @override
  Widget build(final BuildContext context) {
    return ListView.separated(
      itemCount: data.length,
      separatorBuilder: (_, _) => const Divider(),
      itemBuilder: (final BuildContext context, final int index) {
        final T model = data[index];
        return ListTile(
          leading: state.widget.getLeading?.call(state.context, model),
          title:
              state.widget.getTitle?.call(state.context, model) ??
              Text(model.toString()),
          subtitle: state.widget.getSubtitle?.call(state.context, model),
          trailing: (state.widget.canDelete?.call(model) ?? true)
              ? IconButton(
                  icon: Icon(state.widget.deleteIcon),
                  onPressed: () => state.didChange(state.value?..remove(model)),
                )
              : null,
        );
      },
    );
  }
}

class _ListFieldState<T> extends FormFieldState<List<T>> {
  ListFieldController<T>? _controller;

  @override
  ListField<T> get widget => super.widget as ListField<T>;

  ListFieldController<T> get _effectiveController =>
      widget.controller ?? _controller!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = ListFieldController<T>(value: widget.initialValue);
    } else {
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(final ListField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);

      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = ListFieldController<T>.fromValue(oldWidget.controller!);
      }

      if (widget.controller != null) {
        setValue(widget.controller!.value);

        if (oldWidget.controller == null) {
          _controller = null;
        }
      }
    }
  }

  void update(
    final T element, {
    required final bool selected,
    required final bool multiple,
  }) {
    final List<T> value = List<T>.from(_effectiveController.value);

    if (selected) {
      value.add(element);
    } else {
      value.remove(element);
    }

    didChange(value);
  }

  @override
  void didChange(final List<T>? value) {
    super.didChange(value);
    if (_effectiveController.value != value) {
      _effectiveController.value = value ?? <T>[];
    }
  }

  @override
  void reset() {
    super.reset();
    setState(() => _effectiveController.value = widget.initialValue ?? <T>[]);
  }

  void _handleControllerChanged() {
    if (_effectiveController.value != value) {
      didChange(_effectiveController.value);
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }
}
