import 'package:flutter/material.dart';

///
///
///
abstract class AbstractRoute extends StatefulWidget {
  ///
  ///
  ///
  const AbstractRoute({super.key});

  ///
  ///
  ///
  List<String> get routeName;

  ///
  ///
  ///
  String get path => '/${routeName.join('/')}/';
}
