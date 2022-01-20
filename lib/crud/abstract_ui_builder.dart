import 'package:flutter/widgets.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
abstract class AbstractUIBuilder<T extends AbstractModel<Object>> {
  final String labelPrefix;
  final String labelSuffix;

  ///
  ///
  ///
  @mustCallSuper
  const AbstractUIBuilder(
    this.labelPrefix, [
    this.labelSuffix = '',
  ]);

  ///
  ///
  ///
  String get superSingle => <String>[
        if (labelPrefix.isNotEmpty) ...<String>[labelPrefix],
        single,
        if (labelSuffix.isNotEmpty) ...<String>[labelSuffix],
      ].join(' - ');

  ///
  ///
  ///
  String get single;

  ///
  ///
  ///
  String get superPlural => <String>[
        if (labelPrefix.isNotEmpty) ...<String>[labelPrefix],
        plural,
        if (labelSuffix.isNotEmpty) ...<String>[labelSuffix],
      ].join(' - ');

  ///
  ///
  ///
  String get plural;

  ///
  ///
  ///
  Widget getLeading(T model) => const FaIcon(FontAwesomeIcons.solidCircle);

  ///
  ///
  ///
  Widget getTitle(T model);

  ///
  ///
  ///
  Widget? getSubtitle(T model) => null;

  ///
  ///
  ///
  Widget getSuggestionTitle(T model) => getTitle(model);

  ///
  ///
  ///
  Widget? getSuggestionSubtitle(T model) => getSubtitle(model);

  ///
  ///
  ///
  Widget buildBackgroundContainer(BuildContext context, Widget child) =>
      Container(child: child);

  ///
  ///
  ///
  Widget buildBottomNavigationBar(BuildContext context) =>
      const SizedBox(height: 0, width: 0);

  ///
  ///
  ///
  Map<String, Color> get listLegend => const <String, Color>{};

  ///
  ///
  ///
  IconData get listLegendIcon => FontAwesomeIcons.infoCircle;

  ///
  ///
  ///
  String get listLegendTitle => 'Informações';

  ///
  ///
  ///
  String get listLegendButtonText => 'Fechar';
}
