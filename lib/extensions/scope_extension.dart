extension ScopeExtension<T> on T {
  R let<R>(final R Function(T it) block) => block.call(this);

  T also(final void Function(T it) block) {
    block.call(this);
    return this;
  }

  T? takeIf(final bool Function(T it) condition) =>
      condition.call(this) ? this : null;

  T? takeUnless(final bool Function(T it) condition) =>
      condition.call(this) ? null : this;
}

String toString(final dynamic it) => it.toString();
