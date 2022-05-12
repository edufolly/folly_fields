import 'package:flutter/widgets.dart';
import 'package:folly_fields/folly_fields.dart';
import 'package:folly_fields/responsive/responsive.dart';

///
///
///
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    ResponsiveSize responsiveSize,
  ) builder;

  ///
  ///
  ///
  const ResponsiveBuilder({required this.builder, super.key});

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) => builder(
        context,
        FollyFields().checkResponsiveSize(context),
      );
}
