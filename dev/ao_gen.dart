// This is a command line program.
// To run, use: dart run dev/ao_gen.dart
// ignore_for_file: avoid_print, unreachable_from_main

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:yaml/yaml.dart';

///
///
///
void main() async {
  Response response = await get(
    Uri.parse(
      'https://raw.githubusercontent.com/dart-lang/site-www'
      '/main/src/_data/linter_rules.json',
    ),
  );

  List<Rule> rules =
      Utils.fromJsonSafeList(
          json.decode(response.body),
          producer: Rule.fromJson,
        )
        ..retainWhere(
          (Rule rule) =>
              rule.state != RuleState.removed &&
              rule.state != RuleState.deprecated,
        )
        ..sort((Rule a, Rule b) => a.name.compareTo(b.name));

  YamlDocument doc = loadYamlDocument(
    File('analysis_options.yaml').readAsStringSync(),
  );

  YamlMap yamlContent = doc.contents.value as YamlMap;

  YamlMap yamlLinter = yamlContent['linter'] as YamlMap;

  YamlMap yamlRules = yamlLinter['rules'] as YamlMap;

  for (final Rule rule in rules) {
    if (yamlRules.containsKey(rule.name)) {
      rule.active = yamlRules[rule.name].toString().toLowerCase() == 'true';
    }
  }

  for (final Rule rule in rules) {
    if (rule.active && rule.incompatible.isNotEmpty) {
      for (final Rule incompatible in rules) {
        if (rule.incompatible.contains(incompatible.name) &&
            rule.active == incompatible.active) {
          print(
            'Rule ${rule.name} is incompatible with '
            '${incompatible.name} but is active',
          );
        }
      }
    }
  }

  StringBuffer sb =
      StringBuffer()
        ..writeln('include: package:flutter_lints/flutter.yaml')
        ..writeln()
        ..writeln('# https://dart.dev/tools/analysis')
        ..writeln()
        ..writeln('# https://dart.dev/tools/linter-rules/all')
        ..writeln('linter:')
        ..writeln('  rules:');

  for (final Rule rule in rules) {
    if (rule.incompatible.isNotEmpty) {
      sb
        ..writeln()
        ..writeln('    # Incompatible with:');
    }

    for (final String incompatible in rule.incompatible) {
      sb.writeln('    # $incompatible');
    }

    sb.writeln('    ${rule.name}: ${rule.active}');

    if (rule.incompatible.isNotEmpty) {
      sb.writeln();
    }
  }

  File('ao.yaml')
    ..createSync(recursive: true)
    ..writeAsStringSync(sb.toString());
}

///
///
///
class Rule {
  final String name;
  final String description;
  final RuleGroup? group;
  final RuleState state;
  final Set<String> incompatible;
  final Set<RuleSet> sets;
  final RuleFixStatus fixStatus;
  final String details;
  final String sinceDartSdk;
  bool active = true;

  ///
  ///
  ///
  Rule({
    required this.name,
    required this.description,
    required this.group,
    required this.state,
    required this.incompatible,
    required this.sets,
    required this.fixStatus,
    required this.details,
    required this.sinceDartSdk,
  });

  ///
  ///
  ///

  factory Rule.fromJson(dynamic map) => switch (map) {
    Map<dynamic, dynamic> _ => Rule(
      name: map['name']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      group: RuleGroup.parse(map['group']),
      state: RuleState.values.byName(map['state'].toString()),
      incompatible: Utils.fromJsonSafeStringSet(map['incompatible']),
      sets: Utils.fromJsonSafeEnumSet(map['sets'], RuleSet.values),
      fixStatus: RuleFixStatus.values.byName(map['fixStatus']),
      details: map['details']?.toString() ?? '',
      sinceDartSdk: map['sinceDartSdk']?.toString() ?? '',
    ),
    _ => throw ArgumentError('map is not a Map'),
  };
}

///
///
///
class Utils {
  ///
  ///
  ///
  static Iterable<T>? _fromJsonRawIterable<T>(
    Iterable<dynamic>? value, {
    required T Function(dynamic e) producer,
  }) => value?.map<T>(producer);

  ///
  ///
  ///
  static List<T> fromJsonSafeList<T>(
    dynamic value, {
    required T Function(dynamic e) producer,
  }) =>
      value == null
          ? <T>[]
          : (value is Iterable)
          ? _fromJsonRawIterable<T>(value, producer: producer)!.toList()
          : <T>[producer(value)];

  ///
  ///
  ///
  static Set<T> fromJsonSafeSet<T>(
    dynamic value, {
    required T Function(dynamic e) producer,
  }) =>
      value == null
          ? <T>{}
          : (value is Iterable)
          ? _fromJsonRawIterable<T>(value, producer: producer)!.toSet()
          : <T>{producer(value)};

  ///
  ///
  ///
  static Set<T> fromJsonSafeEnumSet<T extends Enum>(
    dynamic value,
    Iterable<T> values,
  ) => switch (value) {
    null => <T>{},
    Iterable<dynamic> _ =>
      value.map((dynamic e) => values.byName(e.toString())).toSet(),
    _ => <T>{values.byName(value.toString())},
  };

  ///
  ///
  ///
  static Set<String> fromJsonSafeStringSet(dynamic value) =>
      fromJsonSafeSet<String>(value, producer: (dynamic e) => e.toString());
}

///
///
///
enum RuleGroup {
  style,
  pub,
  errors,
  none;

  static RuleGroup parse(dynamic value, {RuleGroup defaultValue = none}) =>
      RuleGroup.values.firstWhere(
        (RuleGroup element) => element.name == value.toString().toLowerCase(),
        orElse: () => defaultValue,
      );
}

///
///
///
enum RuleState { stable, deprecated, experimental, removed }

///
///
///
enum RuleFixStatus { hasFix, noFix, needsFix, needsEvaluation, unregistered }

///
///
///
enum RuleSet { core, recommended, flutter }
