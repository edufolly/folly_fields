# folly_fields

Basic form fields and utilities. Maybe a humble boilerplate.

## How to use

### pubspec.yaml
``` yaml
flutter_localizations:
  sdk: flutter

# https://pub.dev/packages/intl
intl: 0.16.1

# https://github.com/edufolly/folly_fields
folly_fields:
  git:
    url: git://github.com/edufolly/folly_fields.git
```

### config.dart
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
```dart
void main() {
  bool debug = false;

  assert(debug = true);

  FollyFields.start(Config(), debug: debug);

  runApp(MyApp());
}
```

### MaterialApp
```dart
MaterialApp(
  title: 'Folly Fields Example',
  theme: ThemeData(
    primarySwatch: Colors.deepOrange,
  ),
  home: MyHomePage(),
  localizationsDelegates: <LocalizationsDelegate<dynamic>>[
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ],
  supportedLocales: <Locale>[
    Locale('pt', 'BR'),
  ],
);
```

## Docs

https://docs.google.com/spreadsheets/d/1fg7yhz-Mum2Z-cQ8KHpkuTEQzgjYI3905Wcr49nmIIY/edit#gid=0