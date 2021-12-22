# folly_fields

Basic form fields and utilities. Maybe a humble boilerplate.

:star: to support the project.

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
    ref: # lastest release
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
      home: MyHomePage(),
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
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
