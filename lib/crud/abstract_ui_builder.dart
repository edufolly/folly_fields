import 'package:flutter/widgets.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
abstract class AbstractUIBuilder<T extends AbstractModel<Object>> {
  final String labelPrefix;

  ///
  ///
  ///
  @mustCallSuper
  const AbstractUIBuilder(this.labelPrefix);

  ///
  ///
  ///
  String get superSingle =>
      labelPrefix.isEmpty ? single : '$labelPrefix - $single';

  ///
  ///
  ///
  @Deprecated('Use superSingle instead getSuperSingle()')
  String getSuperSingle() => superSingle;

  ///
  ///
  ///
  String get single;

  ///
  ///
  ///
  @Deprecated('Use single instead getInternalSingle()')
  String getInternalSingle() => '';

  ///
  ///
  ///
  String get superPlural =>
      labelPrefix.isEmpty ? plural : '$labelPrefix - $plural';

  ///
  ///
  ///
  @Deprecated('Use superPlural instead getSuperPlural()')
  String getSuperPlural() => superPlural;

  ///
  ///
  ///
  String get plural;

  ///
  ///
  ///
  @Deprecated('Use plural instead getInternalPlural()')
  String getInternalPlural() => '';

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
