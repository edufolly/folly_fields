# folly_fields

Basic form fields and utilities. Maybe a humble boilerplate.

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
```

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

## Docs

https://docs.google.com/spreadsheets/d/1fg7yhz-Mum2Z-cQ8KHpkuTEQzgjYI3905Wcr49nmIIY/edit#gid=0