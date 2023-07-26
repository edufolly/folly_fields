import 'package:flutter/widgets.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
abstract class AbstractUIBuilder<T extends AbstractModel<ID>, ID> {
  final String? labelPrefix;
  final String? labelSuffix;

  ///
  ///
  ///
  const AbstractUIBuilder({
    this.labelPrefix,
    this.labelSuffix,
  });

  ///
  ///
  ///
  String superSingle(BuildContext context) => <String>[
        if (labelPrefix?.isNotEmpty ?? false) ...<String>[labelPrefix ?? ''],
        single(context),
        if (labelSuffix?.isNotEmpty ?? false) ...<String>[labelSuffix ?? ''],
      ].join(' - ');

  ///
  ///
  ///
  String single(BuildContext context);

  ///
  ///
  ///
  String superPlural(BuildContext context) => <String>[
        if (labelPrefix?.isNotEmpty ?? false) ...<String>[labelPrefix ?? ''],
        plural(context),
        if (labelSuffix?.isNotEmpty ?? false) ...<String>[labelSuffix ?? ''],
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
  Widget buildListBody(BuildContext context, Widget child) => child;

  ///
  ///
  ///
  Widget buildSearchBody(BuildContext context, Widget child) => child;

  ///
  ///
  ///
  Widget buildEditBody(BuildContext context, T model, Widget child) => child;

  ///
  ///
  ///
  Widget? buildBottomNavigationBar(BuildContext context) => null;

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
