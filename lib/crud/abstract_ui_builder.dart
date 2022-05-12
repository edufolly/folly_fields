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
  const AbstractUIBuilder({
    this.labelPrefix = '',
    this.labelSuffix = '',
  });

  ///
  ///
  ///
  String superSingle(BuildContext context) => <String>[
        if (labelPrefix.isNotEmpty) ...<String>[labelPrefix],
        single(context),
        if (labelSuffix.isNotEmpty) ...<String>[labelSuffix],
      ].join(' - ');

  ///
  ///
  ///
  String single(BuildContext context);

  ///
  ///
  ///
  String superPlural(BuildContext context) => <String>[
        if (labelPrefix.isNotEmpty) ...<String>[labelPrefix],
        plural(context),
        if (labelSuffix.isNotEmpty) ...<String>[labelSuffix],
      ].join(' - ');

  ///
  ///
  ///
  String plural(BuildContext context);

  ///
  ///
  ///
  Widget getLeading(BuildContext context, T model) =>
      const FaIcon(FontAwesomeIcons.solidCircle);

  ///
  ///
  ///
  Widget getTitle(BuildContext context, T model);

  ///
  ///
  ///
  Widget? getSubtitle(BuildContext context, T model) => null;

  ///
  ///
  ///
  Widget getSuggestionTitle(BuildContext context, T model) =>
      getTitle(context, model);

  ///
  ///
  ///
  Widget? getSuggestionSubtitle(BuildContext context, T model) =>
      getSubtitle(context, model);

  ///
  ///
  ///
  Widget buildBackgroundContainer(BuildContext context, Widget child) =>
      Container(child: child);

  ///
  ///
  ///
  Widget buildBottomNavigationBar(BuildContext context) =>
      const SizedBox.shrink();

  ///
  ///
  ///
  Map<String, Color> listLegend(BuildContext context) =>
      const <String, Color>{};

  ///
  ///
  ///
  IconData listLegendIcon(BuildContext context) => FontAwesomeIcons.circleInfo;

  ///
  ///
  ///
  String listLegendTitle(BuildContext context) => 'Informações';

  ///
  ///
  ///
  String listLegendButtonText(BuildContext context) => 'Fechar';
}
