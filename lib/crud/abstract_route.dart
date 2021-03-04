

import 'package:flutter/material.dart';

///
///
///
abstract class AbstractRoute extends StatefulWidget {
  ///
  ///
  ///
  const AbstractRoute({Key? key}) : super(key: key);

  ///
  ///
  ///
  List<String> get routeName;

  ///
  ///
  ///
  String get path => '/${routeName.join('/')}/';
}
