# folly_fields

Basic form fields and utilities.

## How to use

### pubspec.yaml
``` yaml
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