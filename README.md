# folly_fields

Basic form fields and utilities. Maybe a humble boilerplate.

:star: to support the project.

## Attention - flutter: ^2.0.0

Flutter did a breaking change for RaisedButton and FlatButton (1.26.0-0) and null safety (2.0.0).

http://flutter.dev/go/material-button-migration-guide

So we set the Flutter minimal version. Use beta channel for it.

## Example

### Demo

https://edufolly.github.io/folly_fields/

### Code

https://github.com/edufolly/folly_fields/tree/main/example/lib

## How to use

### pubspec.yaml

``` yaml
# https://github.com/edufolly/folly_fields
folly_fields:
  git:
    url: git://github.com/edufolly/folly_fields.git
    rev: # lastest release
```

Use **ref** to avoid breaking changes.
Check [latest release](https://github.com/edufolly/folly_fields/releases).

### config.dart

https://github.com/edufolly/folly_fields/blob/main/example/lib/config.dart

```dart
class Config extends AbstractConfig {
  static final Config _singleton = Config._internal();

  Config._internal();

  factory Config() {
    return _singleton;
  }

/// Content...
}
```

### main.dart

https://github.com/edufolly/folly_fields/blob/main/example/lib/main.dart

```dart
void main() {
  bool debug = false;

  assert(debug = true);

  WidgetsFlutterBinding.ensureInitialized();

  FollyFields.start(Config(), debug: debug);

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
      home: MyHomePage(),
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('pt', 'BR'),
      ],
    );
  }
}
```

## More Docs

https://docs.google.com/spreadsheets/d/1fg7yhz-Mum2Z-cQ8KHpkuTEQzgjYI3905Wcr49nmIIY/edit#gid=0