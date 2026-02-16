extension ScopeExtension<T> on T {
  R let<R>(R Function(T it) block) => block.call(this);

  T also(void Function(T it) block) {
    block.call(this);
    return this;
  }

  T? takeIf(bool Function(T it) condition) =>
      condition.call(this) ? this : null;

  T? takeUnless(bool Function(T it) condition) =>
      condition.call(this) ? null : this;
}

void todo(String message) => throw UnimplementedError(message);

void error(String message) => throw Exception(message);

String parseString(dynamic it) => it.toString();

bool isNull(dynamic it) => it == null;

bool isNotNull(dynamic it) => it != null;
