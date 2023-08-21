# FollyFields

[![Build With Love](https://img.shields.io/badge/%20built%20with-%20%E2%9D%A4-ff69b4.svg)](https://github.com/edufolly/folly_fields/stargazers)
[![Version](https://img.shields.io/pub/v/folly_fields?color=orange)](https://pub.dev/packages/folly_fields)
[![Licence](https://img.shields.io/github/license/edufolly/folly_fields?color=blue)](https://github.com/edufolly/folly_fields/blob/main/LICENSE)
[![Build](https://img.shields.io/github/actions/workflow/status/edufolly/folly_fields/main.yml?branch=main)](https://github.com/edufolly/folly_fields/releases/latest)
[![Coverage Report](https://img.shields.io/badge/coverage-report-C08EA1)](https://edufolly.github.io/folly_fields/coverage/html/)

Basic form fields and utilities. Maybe a humble boilerplate.

## Funding

[![BuyMeACoffee](https://www.buymeacoffee.com/assets/img/guidelines/download-assets-sm-2.svg)](https://www.buymeacoffee.com/edufolly)

## Community

<div>
  <span>
    <div>Join our official Discord server</div>
    <a href="https://discord.gg/q67sGqkpvH">
      <img alt="discord" src="https://img.shields.io/badge/Discord-7289da?style=for-the-badge&logo=discord&logoColor=FFFFFF"/>
    </a>
  </span>
</div>

## Flutter 3.13 - Break Changes

Version 2.2.0 needs Flutter 3.13.0 and Dart 3.1.0

## Flutter 3.10 - Break Changes

Version 1.0.0 needs Flutter 3.10.0 and Dart 3.0.0

## Flutter 3.7 - Break Changes

Version 0.18.0 needs Flutter 3.7.0 and Dart 2.19.0

## Flutter 3.0 - Break Changes

Version 0.10.0 needs Flutter 3.0.0 and Dart 2.17.0

## Example

### Demo

https://edufolly.github.io/folly_fields/

### Code

https://github.com/edufolly/folly_fields/tree/main/example/lib

## How to use

### pubspec.yaml

``` yaml
dependencies:

  flutter:
    sdk: flutter
  
  flutter_localizations:
    sdk: flutter

  # https://pub.dev/packages/folly_fields
  folly_fields: x.y.z # lastest pub.dev release
```

Check [pub.dev latest release](https://pub.dev/packages/folly_fields).

For edge builds, replace pub.dev version to git repo:

``` yaml
# https://github.com/edufolly/folly_fields
folly_fields:
  git:
    url: https://github.com/edufolly/folly_fields.git
    ref: v0.0.1 # latest release or branch name
```

Use **ref** to avoid breaking changes.
Check [GitHub latest release](https://github.com/edufolly/folly_fields/releases).

### config.dart

https://github.com/edufolly/folly_fields/blob/main/example/lib/config.dart

```dart
class Config extends AbstractConfig {
  static final Config _singleton = Config._internal();

  factory Config() {
    return _singleton;
  }

  Config._internal();

/// Content...
}
```

### main.dart

https://github.com/edufolly/folly_fields/blob/main/example/lib/main.dart

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FollyFields.start(Config());

  runApp(MyApp());
}
```

### MaterialApp

https://github.com/edufolly/folly_fields/blob/main/example/lib/main.dart

```dart
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Folly Fields Example',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyHomePage(),
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('pt', 'BR'),
      ],
    );
  }
}
```
