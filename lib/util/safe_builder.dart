import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:folly_fields/widgets/error_message.dart';
import 'package:folly_fields/widgets/waiting_message.dart';

///
///
///
class SilentFutureBuilder<T> extends SafeFutureBuilder<T> {
  ///
  ///
  ///
  SilentFutureBuilder({
    required super.builder,
    super.future,
    super.initialData,
    super.key,
  }) : super(
          onWait: (ConnectionState connectionState, Widget widget) =>
              const SizedBox.shrink(),
          onError: (
            Object? error,
            StackTrace? stackTrace,
            Widget widget,
            ConnectionState connectionState,
          ) {
            if (kDebugMode) {
              print(connectionState);
              print(error);
              print(stackTrace);
            }
            return const SizedBox.shrink();
          },
        );
}

///
///
///
class SafeFutureBuilder<T> extends StatelessWidget {
  final Future<T>? future;
  final T? initialData;
  final Widget Function(
    BuildContext context,
    T data,
    ConnectionState connectionState,
  ) builder;
  final Widget Function(
    Object? error,
    StackTrace? stackTrace,
    Widget child,
    ConnectionState connectionState,
  )? onError;
  final Widget Function(
    ConnectionState connectionState,
    Widget child,
  )? onWait;
  final String? waitingMessage;

  ///
  ///
  ///
  const SafeFutureBuilder({
    required this.builder,
    this.future,
    this.initialData,
    this.onError,
    this.onWait,
    this.waitingMessage,
    super.key,
  }) : assert(
          onWait == null || waitingMessage == null,
          'onWait or waitingMessage must be null.',
        );

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      initialData: initialData,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError) {
          Widget child = ErrorMessage(
            error: snapshot.error,
            stackTrace: snapshot.stackTrace,
          );

          if (onError != null) {
            return onError!(
              snapshot.error,
              snapshot.stackTrace,
              child,
              snapshot.connectionState,
            );
          } else {
            return child;
          }
        }

        if (snapshot.hasData) {
          return builder(context, snapshot.data as T, snapshot.connectionState);
        }

        Widget child = WaitingMessage(message: waitingMessage);

        if (onWait != null) {
          return onWait!(snapshot.connectionState, child);
        } else {
          return child;
        }
      },
    );
  }
}

///
///
///
class SilentStreamBuilder<T> extends SafeStreamBuilder<T> {
  ///
  ///
  ///
  SilentStreamBuilder({
    required super.builder,
    super.stream,
    super.initialData,
    super.key,
  }) : super(
          onWait: (ConnectionState connectionState, Widget widget) =>
              const SizedBox.shrink(),
          onError: (
            Object? error,
            StackTrace? stackTrace,
            Widget widget,
            ConnectionState connectionState,
          ) {
            if (kDebugMode) {
              print(connectionState);
              print(error);
              print(stackTrace);
            }
            return const SizedBox.shrink();
          },
        );
}

///
///
///
class SafeStreamBuilder<T> extends StatelessWidget {
  final Stream<T>? stream;
  final T? initialData;
  final Widget Function(
    BuildContext context,
    T data,
    ConnectionState connectionState,
  ) builder;
  final Widget Function(
    Object? error,
    StackTrace? stackTrace,
    Widget child,
    ConnectionState connectionState,
  )? onError;
  final Widget Function(
    ConnectionState connectionState,
    Widget child,
  )? onWait;
  final String? waitingMessage;

  ///
  ///
  ///
  const SafeStreamBuilder({
    required this.builder,
    this.stream,
    this.initialData,
    this.onError,
    this.onWait,
    this.waitingMessage,
    super.key,
  }) : assert(
          onWait == null || waitingMessage == null,
          'onWait or waitingMessage must be null.',
        );

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      initialData: initialData,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError) {
          Widget child = ErrorMessage(
            error: snapshot.error,
            stackTrace: snapshot.stackTrace,
          );

          if (onError != null) {
            return onError!(
              snapshot.error,
              snapshot.stackTrace,
              child,
              snapshot.connectionState,
            );
          } else {
            return child;
          }
        }

        if (snapshot.hasData) {
          return builder(context, snapshot.data as T, snapshot.connectionState);
        }

        Widget child = WaitingMessage(message: waitingMessage);

        if (onWait != null) {
          return onWait!(snapshot.connectionState, child);
        } else {
          return child;
        }
      },
    );
  }
}
